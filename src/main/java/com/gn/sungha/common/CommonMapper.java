package com.gn.sungha.common;

import java.util.List;

import com.gn.sungha.dashboard.SelectListVO;
import org.apache.ibatis.annotations.Mapper;

import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;
import com.gn.sungha.sensor.SensorVO;

@Mapper
public interface CommonMapper {

	/**
	 * @Mapper Name : selectOrgNmList
	 * @Description : 기관정보 콤보박스 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	List<organizationInfoVO> selectOrgNmList(String organizationId) throws Exception;
	
	/**
	 * @Mapper Name : selectLocalNmList
	 * @Description : 지역정보 콤보박스 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	List<localVO> selectFirstLocalNmList() throws Exception;
	
	/**
	 * @Mapper Name : selectLocalNmList
	 * @Description : 지역정보 콤보박스 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	List<localVO> selectLocalNmList(String organizationId) throws Exception;

	
	/**
	 * @Mapper Name : selectLocalNmList
	 * @Description : 지역정보 콤보박스 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	List<SensorVO> selectSensorComboList(String localId) throws Exception;
	
	
}
