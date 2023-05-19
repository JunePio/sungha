package com.gn.sungha.sensorInfo;

import com.gn.sungha.common.Pagination;

import lombok.Data;

/**
 * @Class Name : SensorInfoVO.java
 * @Description : 센서 VO
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.08  CHLEE      최초생성
 * @version 1.0
 */ 

@Data
public class SensorInfoVO {
	/* 센서항목별 MQTT 전송받은 값 */
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
	private String regDate;
	private String temperatureValue;
	private String humidityValue;
	private String latitude;
	private String longitude;
	private int totcnt;
	private String regDateTime;
	/* 센서항목별 최대~최소 설정값 */
	private String organizationId;
	private String localId;
	private String userid;
	private String tempValueMin;
	private String tempValueMax;
	private String humiValueMin;
	private String humiValueMax;
	private String conducValueMin;
	private String conducValueMax;
	private String phValueMin;
	private String phValueMax;
	private String nitroValueMin;
	private String nitroValueMax;
	private String phosValueMin;
	private String phosValueMax;
	private String potaValueMin;
	private String potaValueMax;
	private String batcapremaValueMin;
	private String batcapremaValueMax;
	private int firstIndex;
	private int lastIndex;
	private String sortColumn;
	private String sortType;
	private Pagination pagination;
	private String datepicker;
	private String datepicker1;
	private String searchingOrgId;
	private String searchingLocalId;
	
}
