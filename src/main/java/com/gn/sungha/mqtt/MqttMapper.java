package com.gn.sungha.mqtt;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MqttMapper {
    PumpInfoVO selectPumpState(String id);

    int insertDeviceControlInfo(ControlInfoVO paramVO);


    //int updateDeviceAirhumiInfo(SensorMqttInfoVO paramVO);
    // mqtt 센서 측정정보 업데이트
    int updateMqttSenserInfo(SensorMqttInfoVO paramVO);

    //int updateDeviceAirTemperInfo(MeasureInfoVO airTemper);
}
