package com.gn.sungha.dashboard;

import com.gn.sungha.sensorInfo.SensorInfoVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DashboardMapper {
    // 센서측정정보 리스트
    List<DashSensorInfoVO> selectDashSensorInfoList(DashboaardSearchVO vo);
    // 센서명 리스트
    List<SelectListVO> selectSensorList(String organizationId, String localId);
    // 관수 정보 리스트
    List<DashSensorInfoVO> selectDashIrrigationInfoList(DashboaardSearchVO vo);
}
