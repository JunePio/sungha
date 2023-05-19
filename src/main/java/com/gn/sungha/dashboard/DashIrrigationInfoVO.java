package com.gn.sungha.dashboard;

import lombok.Data;

/**
 * @Class Name : DashIrrigationInfoVO.java
 * @Description : 관수정보 VO
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.13  LEY      최초생성
 * @version 1.0
 */ 

@Data
public class DashIrrigationInfoVO {
	/* 관수정보 */
	private String irrigationId;
	private String irrigationName;
	private String localId;
	private String reg_dateTime;
	private String irrigationDetail;
	private String organizationId;
	private String mod_dateTime;
	private String latitudeY;
	private String longitudeX;
}
