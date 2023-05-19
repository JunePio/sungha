package com.gn.sungha.sensor;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.gn.sungha.irrigation.IrrigationVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;



/**
 * 센서정보 매퍼
 */

@Mapper
public interface SensorMapper {

	/**
	 * @Mapper Name : selectSensorInfoList
	 * @Description : 센서정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<SensorVO> selectSensorInfoList(SensorVO param) throws Exception;
	
	/**
	 * @Mapper Name : selectSensorInfoListExcel
	 * @Description : 센서정보 조회 엑셀
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<SensorVO> selectSensorInfoListExcel(@Param("searchingOrgId") String searchingOrgId,
			@Param("searchingLocalId") String searchingLocalId,		
			@Param("startList") int firstIndex,
			@Param("listSize") int lastIndex,
			@Param("sortColumn") String sortColumn,
			@Param("sortType") String sortType,
			@Param("searchingType") String searchingType,
			@Param("searchingContent") String searchingContent) throws Exception;
	
	/**
	 * @Mapper Name : selectSensorInfoListTotalCnt
	 * @Description : 센서정보 총개수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	int selectSensorInfoListTotalCnt(@Param("searchingOrgId") String searchingOrgId,
			@Param("searchingLocalId") String searchingLocalId,
			@Param("searchingType") String searchingType,
			@Param("searchingContent") String searchingContent) throws Exception;
	
	/**
	 * @Mapper Name : insertSensorSave
	 * @Description : 센서 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertSensorInfo(@Param("sensorId") String sensorId,
			@Param("usimId") String usimId,
			@Param("outYn") String outYn,
			@Param("sensorDetail") String sensorDetail) throws Exception;
	
	/**
	 * @Mapper Name : insertSensorControlSave
	 * @Description : 센서 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertSensorControl(@Param("sensorId") String sensorId,
			@Param("sensor") String sensor,
			@Param("organizationId") String organizationId,
			@Param("localId") String localId) throws Exception;
	
	/**
	 * @Mapper Name : selectSensorInfoDetail
	 * @Description : 센서정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	SensorVO selectSensorInfoDetail(SensorVO param) throws Exception;
	
	/**
	 * @Mapper Name : updateSensorMod
	 * @Description : 센서 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateSensorMod(@Param("sensorId") String sensorId, @Param("usimId") String chipId, @Param("sensorDetail") String sensorDetail, @Param("outYn") String outYn) throws Exception;
	
	/**
	 * @Mapper Name : updateSensorControlMod
	 * @Description : 센서 설정 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateSensorControlMod(@Param("sensorId") String sensorId,
			@Param("sensor") String sensor,
			@Param("orgId") String orgId,
			@Param("localId") String localId) throws Exception;
	
	/**
	 * @Mapper Name : deleteUserMngDel
	 * @Description : 기관정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteSensor(@Param("sensorId") String sensorId) throws Exception;
	
	/**
	 * @Mapper Name : deleteUserMngDel
	 * @Description : 기관정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteSensorControl(@Param("sensorId") String sensorId) throws Exception;
	
	/**
	 * @Mapper Name : selectDupCheck
	 * @Description : 센서아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<SensorVO> selectSensorDupCheck(@Param("sensorId") String sensorId) throws Exception;
	
	/**
	 * @Mapper Name : selectSensorControlDupCheck
	 * @Description : 센서설정아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<SensorVO> selectSensorControlDupCheck(@Param("sensorId") String sensorId) throws Exception;
	
	/**
	 * @Mapper Name : insertSensorSave
	 * @Description : 센서 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertSensorReplyInfo(@Param("writerId") String writerId,
			@Param("title") String title,
			@Param("sensorDetail") String sensorDetail,
			@Param("sensorId") String sensorId) throws Exception;

	/**
	 * @Mapper Name : insertSensorSave
	 * @Description : 센서 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	int getSensorReplyId(@Param("sensorId") String sensorId) throws Exception;
	
	
	/**
	 * @Mapper Name : insertReplyFileSave
	 * @Description : 센서 댓글 파일 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	int insertReplyFileSave(SensorVO sensorReplyParam) throws Exception;	
	
	/**
	 * @Mapper Name : insertReplyFileSave
	 * @Description : 센서 댓글 파일 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	List<SensorVO> selectSensorReplyList(@Param("sensorId") String sensorId) throws Exception;
	
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
	 * @Mapper Name : deleteSensorReply
	 * @Description : 센서 댓글 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteSensorReply(@Param("replyId") int replyId) throws Exception;
	
	/**
	 * @Mapper Name : deleteSensorReplyFile
	 * @Description : 센서 댓글 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteSensorReplyFile(@Param("replyId") int replyId) throws Exception;
	
	/**
	 * @Mapper Name : updateSensorReplyMod
	 * @Description : 센서 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateSensorReplyMod(SensorVO param) throws Exception;
	
	/**
	 * @Mapper Name : selectReplyFileList
	 * @Description : 센서 댓글 파일 리스트 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	List<SensorVO> selectReplyFileList(int replyId) throws Exception;
	
	/**
	 * @Mapper Name : updateSensorReplyFileMod
	 * @Description : 센서 댓글 파일 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateSensorReplyFileMod(SensorVO param) throws Exception;
	
	/**
	 * @Mapper Name : selectSensorInfoList
	 * @Description : 센서정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<IrrigationVO> selectIrrigationComboList(@Param("localId") String localId) throws Exception;
	
	
	/**
	 * @Mapper Name : insertSensorIrrigaton
	 * @Description : 센서 관수 매핑
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	void insertSensorIrrigaton(@Param("sensorId") String sensorId, @Param("irrigationId") String irrigationId) throws Exception;
	
	/**
	 * @Mapper Name : insertSensorIrrigaton
	 * @Description : 센서 관수 매핑
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	void updateSensorIrrigation(@Param("sensorId") String sensorId, @Param("irrigationId") String irrigationId) throws Exception;
	
	/**
	 * @Mapper Name : selectIrrigationList
	 * @Description : 센서에 매핑된 관수 리스트 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<IrrigationVO> selectIrrigationList(@Param("sensorId") String sensorId) throws Exception;
}
