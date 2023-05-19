package com.gn.sungha.mqtt;

import lombok.RequiredArgsConstructor;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@RequiredArgsConstructor
@RestController
@RequestMapping("/mqtt")
public class MqttController {

    private final MqttGateway mqttGateway;
    @Autowired
    private final MqttService mqttService;

    @GetMapping("/pump")
    public String mqttSendPumpMessage(/*@RequestBody ControllVO message*/) {
        // String message = "test message";
        PumpInfoVO pumpLastOne = mqttService.selectPumpState("DI00000001");
        ControlInfoVO paramVO = new ControlInfoVO();
        paramVO.setDeviceId("DI00000001");
        paramVO.setState(pumpLastOne.getState().equals("on") ? "off" : "on");
        paramVO.setValueMax(pumpLastOne.getValueMax());
        paramVO.setValueMin(pumpLastOne.getValueMin());
        paramVO.setUserId("gn");
        paramVO.setAutoControl(pumpLastOne.getAutoControl());
        LocalDateTime datetime = LocalDateTime.now();
        DateTimeFormatter formatDate = DateTimeFormatter.ofPattern("yyyyMMdd");
        DateTimeFormatter formatHour = DateTimeFormatter.ofPattern("HHmmss");
        paramVO.setControlDate(datetime.format(formatDate));
        paramVO.setControlTime(datetime.format(formatHour));
        mqttService.insertDeviceControlInfo(paramVO);
        mqttGateway.sendToMqtt(pumpLastOne.toString(), "sungha/iot/pump");
        return pumpLastOne.toString();
    }
    @GetMapping("/senser/{id}/{humi}/{temp}")
    public String mqttSendSensorMessage(@PathVariable String id, @PathVariable String humi, @PathVariable String temp) {

        JSONObject obj = new JSONObject();
        // 임시 데이터
        // obj.put("ChipMac", "40-16-7E-A7-6D-AE");
        // 디바이스 아이디
        obj.put("DeviceID", id);
        // obj.put("MessageSendingInterval(min)", 60);
        // 온도 습도
        obj.put("Temp", temp);
        obj.put("Humi", humi);
        // 나머지 ...
        obj.put("Conduc", 0.0000);
        obj.put("pH", "");
        obj.put("Nitro", 0);
        obj.put("Phos", 0);
        obj.put("Pota", 0);
        obj.put("BatCapRema", 100);
        obj.put("Time", "23/04/08,12:12:07+36");
        // 아이피
        obj.put("ip_addr", "192.168.10.6");

        mqttGateway.sendToMqtt(obj.toString(), "sungha/iot/sensor");
        //mqttGateway.sendToMqtt(pumpLastOne.toString(), "prod/receive");
        return obj.toString();

    }
}
