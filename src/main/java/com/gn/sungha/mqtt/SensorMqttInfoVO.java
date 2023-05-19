package com.gn.sungha.mqtt;

import lombok.Data;

@Data
public class SensorMqttInfoVO {
    /** Mac address */
    private String chipId;
    /** 사용자지정장치관리ID */
    private String sensorId;
    /** MQTT Broker정보 */
    private String ipAddr;
    /** 등록일자 */
    private String regDateTime;
    /** 메시지전송주기 */
    private String messageInterval;
    /** 온도 측정값 */
    private String temp;
    /** 습도측정값 */
    private String humi;
    /** conduc */
    private String conduc;
    /** ph */
    private String ph;
    /** nitro */
    private String nitro;
    /** phos */
    private String phos;
    /** pota */
    private String pota;
    /** batcaprema */
    private String batcaprema;
    /* 위도 */
    private String latitude;
    /* 경도 */
    private String longitude;
}
