package com.gn.sungha.mqtt;


import lombok.RequiredArgsConstructor;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.Message;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

import static java.lang.Integer.parseInt;

@Service
@RequiredArgsConstructor
public class MqttService {
    @Autowired
    private final MqttMapper mqttMapper;

    public int insertDeviceControlInfo(ControlInfoVO paramVO) {
        return mqttMapper.insertDeviceControlInfo(paramVO);
    }

    public void insertSensorInfo(Message<?> message) throws ParseException {
        String content = message.getPayload().toString();
        int[] updateCnt = new int[2];
        //2. Parser
        JSONParser jsonParser = new JSONParser();
        //3. To Object
        Object obj = jsonParser.parse(content);
        //4. To JsonObject
        JSONObject jsonObject = (JSONObject) obj;
        // 측정정보 리스트 생성
        List<SensorMqttInfoVO> vauleList = new ArrayList<SensorMqttInfoVO>();
        // 측정정보 객체 생성
        SensorMqttInfoVO data = new SensorMqttInfoVO();
        // 기기정보
        data.setSensorId((jsonObject.get("DeviceID")).toString());

        String currentTimestampToString = (jsonObject.get("Time")).toString();
        //  String to Timestamp
        data.setRegDateTime("20"+currentTimestampToString.replace(",", "").replaceAll("/", "").replaceAll(":", "").substring(0, 12));
        // 습도
        data.setHumi((jsonObject.get("Humi")).toString());
        // 대기온도
        data.setTemp((jsonObject.get("Temp")).toString());
        // Conduc
        data.setConduc((jsonObject.get("Conduc")).toString());
        // Hp
        data.setPh((jsonObject.get("pH")).toString());
        // nitro
        data.setNitro((jsonObject.get("Nitro")).toString());
        // phos
        data.setPhos((jsonObject.get("Phos")).toString());
        // pota
        data.setPota((jsonObject.get("Pota")).toString());
        // batcaprema
        data.setBatcaprema((jsonObject.get("Bat_CapRema")).toString());
        // 위도
        data.setLatitude((jsonObject.get("GPS_Latitude")).toString());
        // 경도
        data.setLongitude((jsonObject.get("GPS_Longitude")).toString());

        // 리스트에 넣기
        vauleList.add(data);

        for(SensorMqttInfoVO paramVO : vauleList) {
            updateCnt[0] += mqttMapper.updateMqttSenserInfo(paramVO);
        }
    }
    private String getDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        Calendar calendar = Calendar.getInstance();
        Date date = calendar.getTime();
        sdf.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
        String dateResult = sdf.format(date);
        return dateResult;
    }

    public PumpInfoVO selectPumpState(String id) {
        return mqttMapper.selectPumpState(id);
    }
}
