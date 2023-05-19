package com.gn.sungha.sensorControl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.gn.sungha.sensorControl.SensorControlVO;

/**
 * 센서정보 매퍼
 */ 

@Mapper
public interface SensorControlMapper {

	/**
	 * @Mapper Name : selectSensorControlList
	 * @Description : 센서정보 조회
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<SensorControlVO> selectSensorControlList(SensorControlVO param) throws Exception;
	
	/**
	 * @Mapper Name : selectSensorControlListExcel
	 * @Description : 센서정보 조회 엑셀
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	List<SensorControlVO> selectSensorControlListExcel(@Param("searchingOrgId") String searchingOrgId,
			@Param("searchingLocalId") String searchingLocalId,		
			@Param("startList") int firstIndex,
			@Param("listSize") int lastIndex,
			@Param("sortColumn") String sortColumn,
			@Param("sortType") String sortType,
			@Param("searchingType") String searchingType,
			@Param("searchingContent") String searchingContent) throws Exception;
	
	/**
	 * @Mapper Name : selectSensorControlListTotalCnt
	 * @Description : 센서정보 총개수
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	int selectSensorControlListTotalCnt(@Param("searchingOrgId") String searchingOrgId,
			@Param("searchingLocalId") String searchingLocalId,
			@Param("searchingType") String searchingType,
			@Param("searchingContent") String searchingContent) throws Exception;
	
	/**
	 * @Mapper Name : insertSensorSave
	 * @Description : 센서 저장
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertSensor(@Param("sensorId") String sensorId,
			@Param("chipId") String chipId) throws Exception;
	
	/**
	 * @Mapper Name : insertSensorControlSave
	 * @Description : 센서 저장
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void insertSensorControl(@Param("sensorId") String sensorId,
			@Param("sensor") String sensor,
			@Param("organizationId") String organizationId,
			@Param("localId") String localId,
			@Param("sensorDetail") String sensorDetail) throws Exception;
	
	/**
	 * @Mapper Name : selectSensorControlDetail
	 * @Description : 센서정보 상세조회
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	SensorControlVO selectSensorControlDetail(@Param("sensorId") String sensorId) throws Exception;
	
	/**
	 * @Mapper Name : updateSensorMod
	 * @Description : 센서 수정
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateSensorMod(@Param("sensorId") String sensorId, @Param("chipId") String chipId) throws Exception;
	
	/**
	 * @Mapper Name : updateSensorControlMod
	 * @Description : 센서 설정 수정
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void updateSensorControlMod(@Param("sensorId") String sensorId,
			@Param("alarmYn") String alarmYn,
			@Param("num") String num,
			@Param("batteryMin") String batteryMin,
			@Param("batteryMax") String batteryMax,
			@Param("temperatureMin") String temperatureMin,
			@Param("temperatureMax") String temperatureMax,
			@Param("humidityMin") String humidityMin,
			@Param("humidityMax") String humidityMax,
			@Param("pHMin") String pHMin,
			@Param("pHMax") String pHMax,
			@Param("ECMin") String ECMin,
			@Param("ECMax") String ECMax,
			@Param("NMin") String NMin,
			@Param("NMax") String NMax,
			@Param("PMin") String PMin,
			@Param("PMax") String PMax,
			@Param("KMin") String KMin,
			@Param("KMax") String KMax) throws Exception;
	
	/**
	 * @Mapper Name : deleteUserMngDel
	 * @Description : 기관정보 삭제
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteSensor(@Param("sensorId") String sensorId) throws Exception;
	
	/**
	 * @Mapper Name : deleteUserMngDel
	 * @Description : 기관정보 삭제
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	void deleteSensorControl(@Param("sensorId") String sensorId) throws Exception;
	
	/**
	 * @Mapper Name : selectSensorDetailForMail
	 * @Description : 센서정보 상세조회
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	SensorControlVO selectSensorDetailForMail(@Param("sensorId") String sensorId) throws Exception;
	
	/**
	 * @Mapper Name : selectSensorControlDetailForMail
	 * @Description : 센서정보 상세조회
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	List<SensorControlVO> selectSensorControlDetailForMail() throws Exception;
	
}
