package com.gn.sungha.userMng;

import java.util.Arrays;

import com.gn.sungha.common.Pagination;

import lombok.Data;

@Data
public class UserMngVO {

	/** ID */
	private int id;
	/** 권한지역ID */
	private String localId;
	/** 번호 */
	private int rownum;
	/** 사용자ID */
	private String username;
	/** 사용자 이름 */
	private String name;
	/** 기관명 */
	private String organization;
	/** 지역명 */
	private String locals;
	/** 지역ID 배열 */
	private String localIds;
	/** 등록일 */
	private String regDate;
	/** 수정일 */
	private String modDate;
	/** 승인일 */
	private String confirmDate;
	/** 취소일 */
	private String cancelDate;
	/** 승인상태 */
	private String confirmState;
	/** 권한ID */
	private String role;
	/** 권한명 */
	private String roleName;
	/** 연락처 */
	private String telNo;
	/** 이메일 */
	private String email;
	/** 기관ID */
	private String organizationId;
	/** 연락처 바디 */
	private String telNoBody;
	/** 연락처 나머지 */
	private String telNoEnd;
	/** 이메일 헤더 */
	private String emailHead;
	/** 이메일 바디 */
	private String emailBody;
	
	private String searchingType;
	private String searchingContent;
	private String sortColumn;
	private String sortType;
	private Pagination pagination;
	private String searchingOrgId;
	private String searchingLocalId;
	

	
}
