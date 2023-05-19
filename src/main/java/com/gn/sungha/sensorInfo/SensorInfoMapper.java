package com.gn.sungha.sensorInfo;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.gn.sungha.irrigation.IrrigationVO;
import com.gn.sungha.local.localVO;
import com.gn.sungha.sensorInfo.SensorInfoVO;

/**
 * @Class Name : sensorInfoMapper.java
 * @Description : 센서정보 Mapper
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.27  CHLEE      최초생성
 * @version 1.0 
 */

@Mapper
public interface SensorInfoMapper {
	
	List<SensorInfoVO> selectSensorInfoList(SensorInfoVO param) throws Exception;
	
	/**
	 * @Mapper Name : selectOrgInfoListTotalCnt
	 * @Description : 기관정보 총개수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.30  이창호      최초생성
	 * @
	 */
	int selectSensorInfoListTotalCnt(
			@Param("searchingOrgId") String searchingOrgId,
			@Param("searchingLocalId") String searchingLocalId,
			@Param("datepicker") String datepicker,
			@Param("datepicker1") String datepicker1) throws Exception;
	
	/**
	 * @Mapper Name : selectsensorInfoDetail
	 * @Description : 계측데이터 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.27  이창호      최초생성
	 * @
	 */
	SensorInfoVO selectSensorInfoDetail(@Param("sensorId") String sensorId,
			                            @Param("regDate") String regDate) throws Exception;
	
	/**
	 * @Mapper Name : selectSensorControlInfoDetail
	 * @Description : 계측데이터 임계치 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.27  이창호      최초생성
	 * @
	 */
	SensorInfoVO selectSensorControlInfoDetail(@Param("sensorId") String sensorId) throws Exception;
	
	
	List<SensorInfoVO> selectSensorInfoSearchData(
			@Param("searchingOrgId") String searchingOrgId,
			@Param("searchingLocalId") String searchingLocalId,
			@Param("searchingSensorId") String searchingSensorId,
			@Param("searchingSensorGubun") String searchingSensorGubun) throws Exception;
	
}
