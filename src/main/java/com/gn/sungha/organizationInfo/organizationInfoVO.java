package com.gn.sungha.organizationInfo;

import com.gn.sungha.common.Pagination;

import lombok.Data;

/**
 * @Class Name : organizationInfoVO.java
 * @Description : 기관정보 VO
 * @Modification Information
 * @ 수정일        수정자     수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.07  유성우      최초생성
 * @
 */

@Data
public class organizationInfoVO {

	/** 번호 */
	private int rownum;
	/** 기관ID */
	private String organizationId;
	/** 기관명 */
	private String organization;
	/** 기관지역명 */
	private String organizationLocal;
	/** 담당자 이름*/
	private String personInCharge;
	/** 연락처 */
	private String telNo;
	/** 연락처 middle */
	private String telNoMiddle;
	/** 연락처 end */
	private String telNoEnd;
	/** 이메일 */
	private String email;
	/** 이메일 head */
	private String emailHead;
	/** 이메일 body */
	private String emailBody;
	/** 사용자 수 */
	private int userCnt;
	/** 센서 수 */
	private String sensorCnt;
	/** 관수 수 */
	private int deviceCnt;
	/** 지역명 */
	private String locals;
	/** 지역 X좌표 */
	private String localNx;
	/** 지역 Y좌표 */
	private String localNy;
	/** 등록일자 */
	private String regDate;
	/** 수정일자 */
	private String modDate;
	/** 권한용 기관 ID **/
	private String authOrganizationId;
	/** 총 갯수 */
	private int totcnt;
	/** 지역ID */
	private String localId;
	private int startList;
	private int listSize;
	/** 정렬 컬럼 */
	private String sortColumn;
	/** 정렬 타입 */
	private String sortType;
	/** 검색 타입 */
	private String searchingType;
	/** 검색 내용 */
	private String searchingContent;
	private Pagination pagination;
	
	
	
	
	
	
	
	
}