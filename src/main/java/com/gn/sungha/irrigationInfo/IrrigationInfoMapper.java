package com.gn.sungha.irrigationInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.gn.sungha.organizationInfo.organizationInfoVO;

/**
 * @Class Name : IrrigationInfoMapper.java
 * @Description : 관수정보 Mapper
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.08  CHLEE      최초생성
 * @version 1.0
 */

@Mapper
public interface IrrigationInfoMapper {
	
	/**
	 * @Mapper Name : selectIrrigationInfoList
	 * @Description : 관수정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.28  이창호      최초생성
	 * @
	 */
	List<IrrigationInfoVO> selectIrrigationInfoList(
			@Param("irrigationId") String irrigationId,
			@Param("irrigation") String irrigation,		
			@Param("organizationId") String organizationId,			
			@Param("startList") int firstIndex,
			@Param("listSize") int lastIndex,
			@Param("sortColumn") String sortColumn,
			@Param("sortType") String sortType) throws Exception;
	
	/**
	 * @Mapper Name : selectIrrigationInfoListTotalCnt
	 * @Description : 관수정보 총개수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.28  이창호      최초생성
	 * @
	 */
	int selectIrrigationInfoListTotalCnt(
			@Param("irrigationId") String irrigationId,
			@Param("irrigation") String irrigation,
			@Param("organizationId") String organizationId) throws Exception;
	
	/**
	 * @Mapper Name : selectDupCheck
	 * @Description : 관수아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.08  이창호      최초생성
	 * @
	 */
	List<IrrigationInfoVO> selectDupCheck(
			@Param("irrigationId") String irrigationId) throws Exception;
			
	
	/**
	 * @Mapper Name : selectIrrigationInfoSave
	 * @Description : 관수정보 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.22  이창호      최초생성
	 * @
	 */
	void insertIrrigationInfoSave(
			@Param("irrigationId") String irrigationId,
			@Param("irrigation") String irrigation,
			@Param("streamTime") String streamTime,
			@Param("streamFlow") String streamFlow,
			@Param("nutrientTime") String nutrientTime,
			@Param("nutrientSolution") String nutrientSolution,
			@Param("organizationId") String organizationId) throws Exception;
	
	
	/**
	 * @Mapper Name : selectIrrigationInfoDetail
	 * @Description : 관수정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.28  이창호      최초생성
	 * @
	 */
	IrrigationInfoVO selectIrrigationInfoDetail(
			@Param("irrigationId") String irrigationId) throws Exception;
	
	/**
	 * @Mapper Name : selectIrrigationInfoModDetail
	 * @Description : 관수정보 수정조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.28  이창호      최초생성
	 * @
	 */
	IrrigationInfoVO selectIrrigationInfoModDetail(@Param("irrigationId") String irrigationId) throws Exception;
	
	/**
	 * @Mapper Name : updateOrgInfoMod
	 * @Description : 기관정보 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.28  이창호      최초생성
	 * @
	 */
	void updateIrrigationInfoMod(
			@Param("irrigationIdDetail") String irrigationIdDetail,
			@Param("irrigationId") String irrigationId,
			@Param("irrigation") String irrigation,
			@Param("streamTime") String streamTime,
			@Param("streamFlow") String streamFlow,
			@Param("nutrientTime") String nutrientTime,
			@Param("nutrientSolution") String nutrientSolution,
			@Param("organizationId") String organizationId
			) throws Exception;
	
	/**
	 * @Mapper Name : selectOrgInfoDel
	 * @Description : 관수정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.28  이창호      최초생성
	 * @
	 */
	void deleteIrrigationInfoDel(
			@Param("irrigationId") String irrigationId) throws Exception;

}
