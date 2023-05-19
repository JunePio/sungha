package com.gn.sungha.mqtt;

import lombok.Data;

@Data
public class MeasureInfoVO {
    /** 행번호 */
    private String rownum;
    /** 기기ID */
    private String deviceId;
    /** 기기명 */
    private String device;
    /** 매설지점ID */
    private String devicePlotId;
    /** 매설위치 */
    private String devicePlot;
    /** 온도 측정값 */
    private Double temperatureValue;
    /** 습도측정값 */
    private Double humidityValue;
    /** 온도 측정값01 */
    private String temperatureValue01;
    /** 습도측정값01 */
    private String humidityValue01;
    /** 온도 측정값02 */
    private String temperatureValue02;
    /** 습도측정값02 */
    private String humidityValue02;
    /** 온도 측정값03 */
    private String temperatureValue03;
    /** 습도측정값03 */
    private String humidityValue03;

    /**토양 습도측정값 */
    private Double soilHumidityValue;
    /** 수위측정값 */
    private String levelValue;
    /** 유량계측정값 */
    private String flowValue;
    /** 측정일자 */
    private String measurementDate;
    /** 측정시간 */
    private String measurementTime;
}
