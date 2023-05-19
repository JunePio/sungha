package com.gn.sungha.mqtt;

import org.eclipse.paho.client.mqttv3.MqttAsyncClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.integration.annotation.IntegrationComponentScan;
import org.springframework.integration.annotation.ServiceActivator;
import org.springframework.integration.channel.DirectChannel;
import org.springframework.integration.core.MessageProducer;
import org.springframework.integration.mqtt.core.DefaultMqttPahoClientFactory;
import org.springframework.integration.mqtt.core.MqttPahoClientFactory;
import org.springframework.integration.mqtt.inbound.MqttPahoMessageDrivenChannelAdapter;
import org.springframework.integration.mqtt.outbound.MqttPahoMessageHandler;
import org.springframework.integration.mqtt.support.DefaultPahoMessageConverter;
import org.springframework.integration.mqtt.support.MqttHeaders;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.MessageHandler;


@Configuration
@IntegrationComponentScan
public class MqttConfig {

    private static final String BROKER_URL = "tcp://182.162.141.59:1883";
    private static final String MQTT_CLIENT_ID = MqttAsyncClient.generateClientId();
    private static final String TOPIC_FILTER = "sungha/iot/sensor";
    private static final String TOPIC_SEND_FILTER = "sungha/iot/pump";

    private static final String MQTT_USERNAME = "gnmqtt";
    private static final String MQTT_PASSWORD = "gn1234";

/*    private static final String BROKER_URL = "tcp://101.101.210.48:1883";
     private static final String TOPIC_FILTER = "prod/receive";
     private static final String TOPIC_SEND_FILTER = "prod/pump";
 */
    @Autowired
    MqttService mqttService;


    private MqttConnectOptions connectOptions() {
        MqttConnectOptions options = new MqttConnectOptions();
        options.setCleanSession(true);
        options.setUserName(MQTT_USERNAME);
        options.setPassword(MQTT_PASSWORD.toCharArray());
        return options;
    }

    @Bean
    public DefaultMqttPahoClientFactory defaultMqttPahoClientFactory() {
        DefaultMqttPahoClientFactory clientFactory = new DefaultMqttPahoClientFactory();
        clientFactory.setConnectionOptions(connectOptions());
        return clientFactory;
    }

    @Bean
    public MessageChannel mqttInputChannel() {
        return new DirectChannel();
    }

    @Bean
    public MessageProducer inboundChannel() {
        DefaultMqttPahoClientFactory factory = new DefaultMqttPahoClientFactory();
        MqttConnectOptions options = new MqttConnectOptions();
        options.setServerURIs(new String[] { BROKER_URL });
        options.setUserName(MQTT_USERNAME);
        options.setPassword(MQTT_PASSWORD.toCharArray());
        factory.setConnectionOptions(options);
        MqttPahoMessageDrivenChannelAdapter adapter =
                new MqttPahoMessageDrivenChannelAdapter(MQTT_CLIENT_ID, factory, TOPIC_FILTER);

        adapter.setCompletionTimeout(5000);
        adapter.setConverter(new DefaultPahoMessageConverter());
        adapter.setQos(1);
        adapter.setOutputChannel(mqttInputChannel());
        return adapter;
    }
    // 인바운드 채널 어댑터
    @Bean
    @ServiceActivator(inputChannel = "mqttInputChannel")
    public MessageHandler inboundMessageHandler() {
        return message -> {
            String topic = (String) message.getHeaders().get(MqttHeaders.RECEIVED_TOPIC);
            try {
                mqttService.insertSensorInfo(message);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
            // JsonParser jsonParser = new JsonParser();
            // JsonObject jsonObject = (JsonObject) jsonParser.parse((String) message.getPayload());
        };
    }
    // 아웃바운드 채널 어댑터
    @Bean
    public MqttPahoClientFactory mqttClientFactory() {
        DefaultMqttPahoClientFactory factory = new DefaultMqttPahoClientFactory();
        MqttConnectOptions options = new MqttConnectOptions();
        options.setServerURIs(new String[] { BROKER_URL });
        options.setUserName(MQTT_USERNAME);
        options.setPassword(MQTT_PASSWORD.toCharArray());
        factory.setConnectionOptions(options);
        return factory;
    }


    @Bean
    @ServiceActivator(inputChannel = "mqttOutboundChannel")
    public MessageHandler mqttOutbound() {
        MqttPahoMessageHandler messageHandler =
                new MqttPahoMessageHandler(MQTT_CLIENT_ID, mqttClientFactory());
        messageHandler.setAsync(true);
        messageHandler.setDefaultTopic(TOPIC_SEND_FILTER);
        return messageHandler;
    }


    @Bean
    public MessageChannel mqttOutboundChannel() {
        return new DirectChannel();
    }

}
