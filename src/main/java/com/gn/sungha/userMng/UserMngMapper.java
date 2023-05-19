package com.gn.sungha.userMng;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;

/**
 * 사용자정보 매퍼
 */

@Mapper
public interface UserMngMapper {
	
	/**
	 * @Mapper Name : selectOrgInfoList
	 * @Description : 기관정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<UserMngVO> selectUserMngList(UserMngVO param) throws Exception;
	
	/**
	 * @Mapper Name : selectOrgInfoList
	 * @Description : 기관정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<UserMngVO> selectUserMngListExcel(UserMngVO param) throws Exception;
	
	/**
	 * @Mapper Name : selectUserMngListTotalCnt
	 * @Description : 기관정보 총개수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	int selectUserMngListTotalCnt(@Param("searchingOrgId") String searchingOrgId,
			@Param("searchingLocalId") String searchingLocalId,
			@Param("searchingType") String searchingType,
			@Param("searchingContent") String searchingContent) throws Exception;
	
	/**
	 * @Mapper Name : updateUserMngConfirm
	 * @Description : 승인 변경
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateUserMngConfirm(@Param("userId") String userId, @Param("confirmStateMod") String confirmStateMod) throws Exception;
	
	
	/**
	 * @Mapper Name : selectUserMngConfirmOrCancelDate
	 * @Description : 승인 변경에 따른 승인일 가져오기 or 취소일 가져오기
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	UserMngVO selectUserMngConfirmOrCancelDate(@Param("userId") String userId, @Param("confirmStateMod") String confirmStateMod) throws Exception;
	
	/**
	 * @Mapper Name : selectUserMngDupCheck
	 * @Description : 사용자아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<UserMngVO> selectUserMngDupCheck(@Param("userId") String userId) throws Exception;
	
	/**
	 * @Mapper Name : selectRoleLocal
	 * @Description : 권한지역 선택 팝업에 데이터 전송 
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<localVO> selectRoleLocal(@Param("orgId") String orgId) throws Exception;
	
	/**
	 * @Mapper Name : selectRoleLocalSearchList
	 * @Description : 권한지역 선택 팝업 검색
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<localVO> selectRoleLocalSearchList(@Param("registOrgId") String registOrgId, @Param("searchingContent") String searchingContent) throws Exception;
	
	/**
	 * @Mapper Name : selectUserLevelList
	 * @Description : 사용자 레벨 콤보박스 리스트 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	List<UserMngVO> selectUserLevelList() throws Exception;
	
	/**
	 * @Mapper Name : insertUserMngSave
	 * @Description : 사용자관리 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertUserMngSave(@Param("inputUserId") String inputUserId,
			@Param("inputUserNm") String inputUserNm,
			@Param("registOrgId") String registOrgId,
			@Param("userLevelRegist") String userLevelRegist,
			@Param("telNo") String telNo,
			@Param("email") String email) throws Exception;

	/**
	 * @Mapper Name : selectUserMngId
	 * @Description : 사용자관리 저장시 ID 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	int selectUserMngId(@Param("inputUserId") String inputUserId) throws Exception;
	
	/**
	 * @Mapper Name : insertUserMngRoleLocal
	 * @Description : 사용자관리 저장시 권한지역 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertUserMngRoleLocal(HashMap<String, Object> userMngObject) throws Exception;
	
	/**
	 * @Mapper Name : selectUserMngDetail
	 * @Description : 기관정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	UserMngVO selectUserMngDetail(@Param("userId") String userId) throws Exception;
	
	/**
	 * @Mapper Name : updateUseMngMod
	 * @Description : 사용자관리 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateUserMngMod(@Param("userId") String userId,
			@Param("userNm") String userNm,
			@Param("userLevel") String userLevel,
			@Param("telNo") String telNo,
			@Param("email") String email,
			@Param("orgId") String orgId) throws Exception;
	
	/**
	 * @Mapper Name : deleteUserMngRoleLocal
	 * @Description : 사용자관리 수정시 권한지역 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteUserMngRoleLocal(int id) throws Exception;
	
	/**
	 * @Mapper Name : selectUserMngIdFor
	 * @Description : 사용자관리 삭제시 ID 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	int selectUserMngIdFor(@Param("userId") String userId) throws Exception;
	
	/**
	 * @Mapper Name : deleteUserMngDel
	 * @Description : 기관정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteUserMngDel(@Param("userId") String userId) throws Exception;
	
	/**
	 * @Mapper Name : updatePasswordChange
	 * @Description : 비밀번호 변경
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updatePasswordChange(@Param("userId") String userId, @Param("changedPassword") String changedPassword) throws Exception;
	
	/**
	 * @Mapper Name : selectUserMngList
	 * @Description : 사용자 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<UserMngVO> selectUserMngList(@Param("searchingOrgId") String searchingOrgId, @Param("searchingLocalId") String searchingLocalId,
			@Param("searchingType") String searchingType,
			@Param("searchingContent") String searchingContent,
			@Param("sortColumn") String sortColumn,
			@Param("sortType") String sortType) throws Exception;
}
