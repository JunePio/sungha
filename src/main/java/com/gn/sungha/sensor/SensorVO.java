package com.gn.sungha.sensor;

import java.io.FileInputStream;

import org.springframework.core.io.Resource;

import com.gn.sungha.common.Pagination;

import lombok.Data;
import lombok.Getter;

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
public class SensorVO {

	/** 번호 */
	private int rownum;
	/** 센서ID */
	private String sensorId;
	/** 센서명 */
	private String sensor;
	/** 지역명 */
	private String local;
	/** 기관명 */
	private String organization;
	/** 배터리 잔량 */
	private String batcaprema;
	/** 센서 상태 */
	private String sensorState;
	/** 등록일 */
	private String regDate;
	/** 수정일 */
	private String modDate;
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
	/** 반출여부 */
	private String outYn;
	/** 댓글ID */
	private int replyId;
	/** 작성자ID */
	private String writerId;
	/** 파일사이즈 */
	private String fileSize;
	/** 등록일시 */
	private String regDateTime;
	/** 수정일시 */
	private String modDateTime;
	/** 작성자명 */
	private String name;
	/** 제목 */
	private String title;
	/** 관수ID */
	private String irrigationId;
	/** 관수명 */
	private String irrigationName;
	private Pagination pagination;
	private String searchingOrgId;
	private String searchingLocalId;
	private String searchingType;
	private String searchingContent;
	private String sortColumn;
	private String sortType;
	
	
	
	
	
	
	
}
