package com.gn.sungha.organizationInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.gn.sungha.local.localVO;
import com.gn.sungha.userMng.UserMngVO;

/**
 * 기관정보 매퍼
 */

@Mapper
public interface organizationInfoMapper {
	
	/**
	 * @Mapper Name : selectOrgInfoList
	 * @Description : 기관정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<organizationInfoVO> selectOrgInfoList(organizationInfoVO param) throws Exception;
	
	/**
	 * @Mapper Name : selectOrgInfoList
	 * @Description : 기관정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<organizationInfoVO> selectOrgInfoListExcel(organizationInfoVO param) throws Exception;
	
	/**
	 * @Mapper Name : selectOrgInfoListTotalCnt
	 * @Description : 기관정보 총개수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	int selectOrgInfoListTotalCnt(@Param("searchingOrgId") String searchingOrgId,
			@Param("searchingLocalId") String searchingLocalId,
			@Param("personInCharge") String personInCharge) throws Exception;
	
	/**
	 * @Mapper Name : selectDupCheck
	 * @Description : 기관아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<organizationInfoVO> selectOrgDupCheck(@Param("orgId") String orgId) throws Exception;
	
	/**
	 * @Mapper Name : selectLocalDupCheck
	 * @Description : 지역아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<localVO> selectLocalDupCheck(@Param("orgId") String orgId) throws Exception;
	
	/**
	 * @Mapper Name : selectLocalDupCheck
	 * @Description : 지역아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<UserMngVO> selectUserMngDupCheck(@Param("orgId") String orgId) throws Exception;
	
	/**
	 * @Mapper Name : insertOrgInfoSave
	 * @Description : 기관정보 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertOrgInfoSave(@Param("orgId") String orgId,
			@Param("orgNm") String orgNm,
			@Param("personInCharge") String personInCharge,
			@Param("telNo") String telNo,
			@Param("email") String email) throws Exception;
	
	/**
	 * @Mapper Name : insertOrgInfoSave
	 * @Description : 기관정보 저장
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
			@Param("email") String email,
			@Param("confirmState") String confirmState,
			@Param("inputUserPw") String inputUserPw) throws Exception;
	
	/**
	 * @Mapper Name : selectOrgInfoDetail
	 * @Description : 기관정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	organizationInfoVO selectOrgInfoDetail(@Param("organizationId") String organizationId) throws Exception;
	
	/**
	 * @Mapper Name : selectOrgInfoModDetail
	 * @Description : 기관정보 수정조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	organizationInfoVO selectOrgInfoModDetail(@Param("organizationId") String organizationId) throws Exception;
	
	/**
	 * @Mapper Name : updateOrgInfoMod
	 * @Description : 기관정보 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateOrgInfoMod(@Param("orgId") String orgId,
			@Param("orgNm") String orgNm,
			@Param("personInCharge") String personInCharge,
			@Param("telNo") String telNo,
			@Param("email") String email) throws Exception;
	
	/**
	 * @Mapper Name : selectEtcInfoCount
	 * @Description : 기관정보 삭제해도 되는지 사용자, 센서, 관수 체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	organizationInfoVO selectEtcInfoCount(@Param("organizationId") String organizationId) throws Exception;
	
	/**
	 * @Mapper Name : deleteOrgInfoDel
	 * @Description : 기관정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteOrgInfoDel(@Param("organizationId") String organizationId) throws Exception;
	
	/**
	 * @Mapper Name : deleteLocalDel
	 * @Description : 기관정보 삭제시 지역도 같이 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteLocalDel(@Param("organizationId") String organizationId) throws Exception;
}
