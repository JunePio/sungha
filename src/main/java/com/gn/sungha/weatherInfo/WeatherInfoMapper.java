package com.gn.sungha.weatherInfo;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface WeatherInfoMapper {
    List<UserInfoVO> selectOrganizationInfo();

    int updateLocalWeatherInfo(LocalWeatherInfoVO vo);
}
