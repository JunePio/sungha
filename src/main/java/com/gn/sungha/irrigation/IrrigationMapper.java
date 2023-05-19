package com.gn.sungha.irrigation;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.gn.sungha.sensor.SensorVO;
import com.gn.sungha.irrigation.IrrigationVO;

@Mapper
public interface IrrigationMapper {

	/**
	 * @Mapper Name : selectIrrigationList
	 * @Description : 관수 정보 리스트 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<IrrigationVO> selectIrrigationList(IrrigationVO param) throws Exception;
	
	/**
	 * @Mapper Name : selectIrrigationListExcel
	 * @Description : 관수 정보 리스트 조회 엑셀
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<IrrigationVO> selectIrrigationListExcel(@Param("searchingOrgId") String searchingOrgId,
			@Param("searchingLocalId") String searchingLocalId,
			@Param("searchingType") String searchingType,
			@Param("searchingContent") String searchingContent,
			@Param("startList") int firstIndex,
			@Param("listSize") int lastIndex,
			@Param("sortColumn") String sortColumn,
			@Param("sortType") String sortType) throws Exception;
	
	/**
	 * @Mapper Name : selectIrrigationListTotalCnt
	 * @Description : 관수 정보 리스트 총개수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	int selectIrrigationListTotalCnt(@Param("searchingOrgId") String searchingOrgId,
			@Param("searchingLocalId") String searchingLocalId,
			@Param("searchingType") String searchingType,
			@Param("searchingContent") String searchingContent) throws Exception;
	
	/**
	 * @Mapper Name : selectIrrigationDetail
	 * @Description : 관수 정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	IrrigationVO selectIrrigationDetail(IrrigationVO param) throws Exception;
	
	/**
	 * @Mapper Name : insertIrrigation
	 * @Description : 관수 정보 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertIrrigation(@Param("irrigationId") String irrigationId,
			@Param("irrigation") String irrigation,			
			@Param("organizationId") String organizationId,
			@Param("localId") String localId,
			@Param("irrigationDetail") String irrigationDetail) throws Exception;
	
	/**
	 * @Mapper Name : insertIrrigationControl
	 * @Description : 관수 설정 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertIrrigationControl(@Param("irrigationId") String irrigationId, @Param("userId") String userId, @Param("irrigationState") String irrigationState,
			@Param("irrigationAutoControl") String irrigationAutoControl) throws Exception;
	
	/**
	 * @Mapper Name : updateIrrigationStateChange
	 * @Description : 관수 상태 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateIrrigationStateChange(@Param("irrigationId") String irrigationId, @Param("state") String state) throws Exception;
	
	/**
	 * @Mapper Name : selectDupCheck
	 * @Description : 관수아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<IrrigationVO> selectIrrigationDupCheck(@Param("irrigationId") String irrigationId) throws Exception;

	/**
	 * @Mapper Name : selectDupCheck
	 * @Description : 관수아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.08  이창호      최초생성
	 * @
	 */
	List<IrrigationVO> selectDupCheck(
			@Param("irrigationId") String irrigationId) throws Exception;
	
	/**
	 * @Mapper Name : selectSensorControlDupCheck
	 * @Description : 관수설정아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<IrrigationVO> selectIrrigationControlDupCheck(@Param("irrigationId") String irrigationId) throws Exception;
	
	/**
	 * @Mapper Name : selectIrrigationReplyList
	 * @Description : 관수 댓글 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	List<IrrigationVO> selectIrrigationReplyList(@Param("irrigationId") String irrigationId) throws Exception;
	
	/**
	 * @Mapper Name : updateIrrigationMod
	 * @Description : 관수 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateIrrigationMod(@Param("irrigationId") String irrigationId, @Param("irrigation") String irrigation, @Param("organizationId") String organizationId, @Param("localId") String localId, @Param("irrigationDetail") String irrigationDetail) throws Exception;
	
	/**
	 * @Mapper Name : updateIrrigationControlMod
	 * @Description : 관수 설정 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateIrrigationControlMod(@Param("irrigationId") String irrigationId,
			@Param("userId") String userId,
			@Param("irrigationState") String irrigationState,
			@Param("irrigationAutoControl") String irrigationAutoControl) throws Exception;
	
	/**
	 * @Mapper Name : deleteUserMngDel
	 * @Description : 기관정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteIrrigation(@Param("irrigationId") String irrigationId) throws Exception;
	
	/**
	 * @Mapper Name : deleteUserMngDel
	 * @Description : 기관정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteIrrigationControl(@Param("irrigationId") String irrigationId) throws Exception;
	
	/**
	 * @Mapper Name : selectOriFileName
	 * @Description : 원본파일 이름 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	String getUuidName(@Param("replyId") int replyId) throws Exception;
	
	/**
	 * @Mapper Name : deleteIrrigationReply
	 * @Description : 관수 댓글 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteIrrigationReply(@Param("replyId") int replyId) throws Exception;
	
	/**
	 * @Mapper Name : deleteIrrigationReplyFile
	 * @Description : 관수 댓글 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteIrrigationReplyFile(@Param("replyId") int replyId) throws Exception;
	
	/**
	 * @Mapper Name : updateIrrigationReplyMod
	 * @Description : 관수 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateIrrigationReplyMod(IrrigationVO param) throws Exception;
	
	/**
	 * @Mapper Name : selectReplyFileList
	 * @Description : 관수 댓글 파일 리스트 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	List<IrrigationVO> selectReplyFileList(int replyId) throws Exception;
	
	/**
	 * @Mapper Name : updateIrrigationReplyFileMod
	 * @Description : 관수 댓글 파일 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateIrrigationReplyFileMod(IrrigationVO param) throws Exception;
	
	/**
	 * @Mapper Name : insertIrrigationSave
	 * @Description : 관수 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertIrrigationReplyInfo(@Param("writerId") String writerId,
			@Param("title") String title,
			@Param("irrigationDetail") String irrigationDetail,
			@Param("irrigationId") String irrigationId) throws Exception;
	
	/**
	 * @Mapper Name : insertIrrigationSave
	 * @Description : 관수 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	int getIrrigationReplyId(@Param("irrigationId") String irrigationId) throws Exception;

	/**
	 * @Mapper Name : insertReplyFileSave
	 * @Description : 관수 댓글 파일 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertReplyFileSave(IrrigationVO irrigationReplyParam) throws Exception;	
	
	/**
	 * @Mapper Name : selectIrrigationHistoryList
	 * @Description : 관수 수정이력 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	List<IrrigationVO> selectIrrigationHistoryList(@Param("irrigationId") String irrigationId) throws Exception;
	
	
	/**
	 * @Mapper Name : insertIrrigationHistoryChange
	 * @Description : 관수 댓글 파일 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertIrrigationHistoryChange(IrrigationVO param) throws Exception;	
}
