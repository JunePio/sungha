package com.gn.sungha.weatherInfo;

import lombok.Data;

@Data
public class LocalWeatherInfoVO {
    /** 예측일자 */
    private String fcstDate;
    /** 예측시간 */
    private String fcstTime;
    /** 기온 값 */
    private Integer temperatureValue;
    /** 습도 값 */
    private Integer humidityValue;
    /** 기관ID */
    private String organizationId;
    /** 기관지역명 */
    private String organizationLocal;
    /** 기관지역ID */
    private String LocalId;
}
