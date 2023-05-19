package com.gn.sungha.sensorControl;

import java.io.FileInputStream;

import com.gn.sungha.common.Pagination;

import lombok.Data;

/** 
 * @Class Name : SensorInfoVO.java
 * @Description : 센서정보 VO
 * @Modification Information
 * @ 수정일        수정자     수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.01.09  유성우      최초생성
 * @
 */

@Data
public class SensorControlVO {

	/** 번호 */
	private int rownum;
	/** 센서ID */
	private String sensorId;
	/** 센서명 */
	private String sensor;
	/** Mac address */
	private String chipId;
	/** 지역명 */
	private String local;
	/** 기관명 */
	private String organization;
	/** 센서 상태 */
	private String sensorState;
	/** 등록일 */
	private String regDate;
	/** 센서상세위치 */
	private String sensorDetail;
	/** 지역ID */
	private String localId;
	/** 기관ID */
	private String organizationId;
	/** UUID명 */
	private String uuidName;
	/** 원본파일명 */
	private String oriFileName;
	/** 조감도 파일 */
	private FileInputStream file;
	/** 유심코드 */
	private String usimId;
	/** 배터리 설정값 최저 */
	private String batcapremaValueMin;
	/** 배터리 설정값 최고 */
	private String batcapremaValueMax;
	/** 온도 설정값 최저 */
	private String tempValueMin;
	/** 온도 설정값 최고 */
	private String tempValueMax;
	/** 습도 설정값 최저 */
	private String humiValueMin;
	/** 습도 설정값 최고 */
	private String humiValueMax;
	/** EC 설정값 최저 */
	private String conducValueMin;
	/** EC 설정값 최고 */
	private String conducValueMax;
	/** pH 설정값 최저 */
	private String phValueMin;
	/** pH 설정값 최고 */
	private String phValueMax;
	/** N 설정값 최저 */
	private String nitroValueMin;
	/** N 설정값 최고 */
	private String nitroValueMax;
	/** P 설정값 최저 */
	private String phosValueMin;
	/** P 설정값 최고 */
	private String phosValueMax;
	/** K 설정값 최저 */
	private String potaValueMin;
	/** K 설정값 최고 */
	private String potaValueMax;
	/** 전체 알림 여부 */
	private String alarmYn;
	/** 배터리 잔량 */
	private String batcaprema;
	/** 온도 */
	private String temp;
	/** 습도 */
	private String humi;
	/** 토양 EC */
	private String conduc;
	/** 수소이온농도지수 pH */
	private String ph;
	/** 질소 N */
	private String nitro;
	/** 인 P */
	private String phos;
	/** 칼륨 K */
	private String pota;
	/** 순번 */
	private String num;
	private String irrigationId;
	private String irrigationName;
	private Pagination pagination;
	private String searchingOrgId;
	private String searchingLocalId;
	private String searchingType;
	private String searchingContent;
	private String sortColumn;
	private String sortType;
	
	
	
}
