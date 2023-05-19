package com.gn.sungha.dashboard;

import com.gn.sungha.sensorInfo.SensorInfoVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DashboardService {

    private final DashboardMapper mapper;

    // 대시보드 센서 셀렉트박스
    public List<SelectListVO> selectSensorList(String organizationId, String localId) {
        return mapper.selectSensorList(organizationId, localId);
    }
    // 대시보드 센서 측정정보 리스트
    public List<DashSensorInfoVO> selectDashSensorInfoList(DashboaardSearchVO vo) {
        return mapper.selectDashSensorInfoList(vo);
    }

    public List<DashSensorInfoVO> selectDashIrrigationInfoList(DashboaardSearchVO vo) {
        return mapper.selectDashIrrigationInfoList(vo);
    }
}
