package com.gn.sungha.local;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.gn.sungha.organizationInfo.organizationInfoVO;


@Mapper
public interface localMapper {

	/**
	 * @Mapper Name : selectLocalList
	 * @Description : 지역 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<localVO> selectLocalList(localVO param) throws Exception;
	
	/**
	 * @Mapper Name : selectLocalListExcel
	 * @Description : 지역 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<localVO> selectLocalListExcel(localVO param) throws Exception;
	
	/**
	 * @Mapper Name : selectLocalListTotalCnt
	 * @Description : 지역 총개수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	int selectLocalListTotalCnt(@Param("searchingOrgId") String searchingOrgId,
			@Param("searchingLocalId") String searchingLocalId) throws Exception;
	
	/**
	 * @Mapper Name : selectLatestLocalId
	 * @Description : 최신 지역ID 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	String selectLatestLocalId();
	
	/**
	 * @Mapper Name : selectLocalIdList
	 * @Description : 최신 지역ID 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<localVO> selectLocalIdList(@Param("organizationId") String organizationId);
	
	/**
	 * @Mapper Name : selectEtcInfoCount
	 * @Description : 기관정보 삭제해도 되는지 사용자, 센서, 관수 체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	localVO selectEtcInfoCount(@Param("localId") String localId) throws Exception;
	
	/**
	 * @Mapper Name : insertLocalSave
	 * @Description : 지역 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertLocalSave(@Param("localId") String localId,
			@Param("localNm") String localNm,
			@Param("registOrgId") String registOrgId,
			@Param("localAddressMain") String localAddressMain,
			@Param("localAddressSub") String localAddressSub,
			@Param("localNx") String localNx,
			@Param("localNy") String localNy) throws Exception;
	
	/**
	 * @Mapper Name : insertLocalFileSave
	 * @Description : 지역 파일 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertLocalFileSave(@Param("localId") String localId,
			@Param("uuidNm") String uuidNm,
			@Param("oriFileName") String oriFileName,
			@Param("fileSize") String fileSize,
			@Param("no") String no) throws Exception;
	
	/**
	 * @Mapper Name : selectLocalModDetail
	 * @Description : 지역 수정조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	localVO selectLocalModDetail(@Param("localId") String localId) throws Exception;
	
	/**
	 * @Mapper Name : selectLocalFileList
	 * @Description : 지역 파일 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	List<localVO> selectLocalFileList(@Param("localId") String localId) throws Exception;
	
	/**
	 * @Mapper Name : updateLocalMod
	 * @Description : 지역 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateLocalModNoFile(@Param("orgIdMod") String orgIdMod,
			@Param("localIdMod") String localIdMod,
			@Param("localNmMod") String localNmMod,
			@Param("localAddressMainMod") String localAddressMainMod,
			@Param("localAddressSubMod") String localAddressSubMod,
			@Param("localNxMod") String localNxMod,
			@Param("localNyMod") String localNyMod) throws Exception;
	
	/**
	 * @Mapper Name : updateLocalMod
	 * @Description : 지역 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateLocalMod(@Param("orgIdMod") String orgIdMod,
			@Param("localIdMod") String localIdMod,
			@Param("localNmMod") String localNmMod,
			@Param("localAddressMainMod") String localAddressMainMod,
			@Param("localAddressSubMod") String localAddressSubMod,
			@Param("localNxMod") String localNxMod,
			@Param("localNyMod") String localNyMod) throws Exception;
	
	/**
	 * @Mapper Name : updateLocalFileMod
	 * @Description : 지역 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateLocalFileMod(@Param("localIdMod") String localIdMod,
			@Param("uuid") String uuid,
			@Param("oriFileName") String oriFileName,
			@Param("fileSize") String fileSize,
			@Param("no") String no) throws Exception;
	
	/**
	 * @Mapper Name : selectLocalDel
	 * @Description : 지역 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	localVO localDelValidationCheck(@Param("localIdVal") String localIdVal) throws Exception;
	
	/**
	 * @Mapper Name : selectOriFileName
	 * @Description : 원본파일 이름 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	List<String> selectOriFileName(@Param("localIdDel") String localIdDel) throws Exception;
	
	/**
	 * @Mapper Name : deleteLocal
	 * @Description : 지역 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteLocal(@Param("localIdDel") String localIdDel) throws Exception;
	
	/**
	 * @Mapper Name : deleteLocalFile
	 * @Description : 지역 파일 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteLocalFile(@Param("localIdDel") String localIdDel) throws Exception;
	
	/**
	 * @Mapper Name : selectLocalXY
	 * @Description : 해당 지역의 위도, 경도 좌표 가져오기
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	localVO selectLocalXY(@Param("localId") String localId) throws Exception;
}
