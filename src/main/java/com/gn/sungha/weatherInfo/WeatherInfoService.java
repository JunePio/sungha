package com.gn.sungha.weatherInfo;

import com.gn.sungha.mqtt.MqttMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WeatherInfoService {
    @Autowired
    private final WeatherInfoMapper weatherInfoMapper;
    public List<UserInfoVO> selectOrganizationInfo() {
        return weatherInfoMapper.selectOrganizationInfo();
    }

    public int updateLocalWeatherInfo(List<LocalWeatherInfoVO> paramList) {
        int updateCnt = 0;
        for(LocalWeatherInfoVO paramVO : paramList) {
            updateCnt += weatherInfoMapper.updateLocalWeatherInfo(paramVO);
        }
        return updateCnt;
    }
}
