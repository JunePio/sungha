package com.gn.sungha.irrigation;

import com.gn.sungha.common.Pagination;

import lombok.Data;

@Data
public class IrrigationVO {
	/** 번호 */
	private String rownum;
	/** 관수ID */
	private String irrigationId;
	/** 관수명 */
	private String irrigation;
	/** 지역명 */
	private String local;
	/** 기관명 */
	private String organization;
	/** 관수 설명 */
	private String irrigationContent;
	/** 최소 */
	private String valueMin;
	/** 최대 */
	private String valueMax;
	/** 상태 */
	private String state;
	/** 지역ID */
	private String localId;
	/** 기관ID */
	private String organizationId;
	/** 등록일자 */
	private String regDate;
	/** 관수명 */
	private String irrigationName;
	/** 관수설명 */
	private String irrigationDetail;
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
	/** UUID명 */
	private String uuidName;
	/** 원본파일명 */
	private String oriFileName;
	/** 유량투입시간 */
	private int streamTime;
	/** 관수 상태 */
	private String irrigationState;
	/** 수정자ID */
	private String userId;
	/** 일시 */
	private String dateTime;
	
	private String sensorId;
	private String sensor;
	private Pagination pagination;
	private String searchingOrgId;
	private String searchingLocalId;
	private String searchingType;
	private String searchingContent;
	private String sortColumn;
	private String sortType;
	
	
	
	
	
	
	
}
