package com.gn.sungha.common;

import java.util.List;

import com.gn.sungha.dashboard.SelectListVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;
import com.gn.sungha.sensor.SensorVO;

@Service
public class CommonNmList {
	@Autowired
	private CommonMapper mapper;
	
	public List<organizationInfoVO> selectOrgNmList(String orgId) throws Exception {
		List<organizationInfoVO> orgNmList = mapper.selectOrgNmList(orgId);
		return orgNmList;
	}	
	
	public List<localVO> selectFirstLocalNmList() throws Exception {
		List<localVO> localNmList = mapper.selectFirstLocalNmList();
		return localNmList;
	}	
	
	public List<localVO> selectLocalNmList(String orgId) throws Exception {
		List<localVO> localNmList = mapper.selectLocalNmList(orgId);
		return localNmList;
	}

	
	public List<SensorVO> selectSensorComboList(String localId) throws Exception {
		List<SensorVO> sensorList = mapper.selectSensorComboList(localId);
		return sensorList;
	}	
}