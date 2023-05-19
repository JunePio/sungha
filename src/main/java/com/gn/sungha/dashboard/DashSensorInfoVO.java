package com.gn.sungha.dashboard;

import lombok.Data;

/**
 * @Class Name : DashSensorInfoVO.java
 * @Description : 대시보드센서 VO
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.07  LEY      최초생성
 * @version 1.0
 */ 

@Data
public class DashSensorInfoVO {
	/* 센서측정 값 */
	private int rownum;
	private String organization;
	private String local;
	private String sensor;
	private String chipId;
	private String sensorId;
	private String messageInterval;
	private String temp;
	private String humi;
	private String conduc;
	private String ph;
	private String nitro;
	private String phos;
	private String pota;
	private String batcaprema;
	private String ipAddr;
	private String state;
	private String regDateTime;

	private String latitudeY;
	private String longitudeX;
}
