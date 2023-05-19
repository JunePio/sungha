package com.gn.sungha.local;

import com.gn.sungha.common.Pagination;

import lombok.Data;

@Data
public class localVO {

	/** 순번 */
	private int rownum;
	/** 기관ID */
	private String organizationId;
	/** 기관명 */
	private String organization;
	/** 지역주소 메인 */
	private String localAddressMain;
	/** 지역주소 서브 */
	private String localAddressSub;
	/** 지역주소 */
	private String localAddress;
	/** 지역 X좌표 */
	private String localNx;
	/** 지역 Y좌표 */
	private String localNy;
	/** 등록일시 */
	private String regDate;
	/** 수정일시 */
	private String modDate;
	/** uuid 이름 */
	private String uuidName;
	/** 원본 파일 이름 */
	private String oriFileName;
	/** 파일 사이즈 */
	private String fileSize;
	/** 지역ID */
	private String localId;
	/** 지역명 */
	private String local;
	/** 사용자 수 */
	private int userCnt;
	/** 센서 사용수 */
	private int sensorUseCnt;
	/** 센서 전체수 */
	private int sensorCnt;
	/** 관수 수 */
	private int deviceCnt;
	/** 총 갯수 */
	private int totcnt;
	/**날짜*/
	private String dateTime;
	private int userLevel;
	private int firstIndex;
	private int lastIndex;
	private String sortColumn;
	private String sortType;
	private Pagination pagination;
	
	
	
	
	
}
