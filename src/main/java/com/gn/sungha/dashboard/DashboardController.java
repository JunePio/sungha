package com.gn.sungha.dashboard;

import com.gn.sungha.common.CommonNmList;
import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping(value="/dashboard")
public class DashboardController {

    private final CommonNmList commonNmList; // 공통 - 기관정보 콤보박스 리스트와 지역 콤보박스 리스트 객체
    private final DashboardService dashboardService;

    // 대시보드 메인화면 불러오기
    @GetMapping(value = "/main")
    public String selectDashboard() {
        return "dashboard/dashboard";
    }

    // 기관정보 셀렉트 박스
    @ResponseBody
    @PostMapping(value = "/orgList.ajax")
    public List<organizationInfoVO> orgList(@RequestBody DashboaardSearchVO vo) throws Exception {
        return commonNmList.selectOrgNmList(vo.getOrganizationId());  // 기관 콤보박스 리스트 조회
    }

    // 지역정보 셀렉트 박스
    @ResponseBody
    @PostMapping(value = "/localList.ajax")
    public List<localVO> localList(@RequestBody DashboaardSearchVO vo) throws Exception {
        return commonNmList.selectLocalNmList(vo.getOrganizationId());
    }

    // 센서정보 셀렉트 박스
    @ResponseBody
    @PostMapping(value = "/mainSearch.ajax")
    public List<SelectListVO> mainSearch(@RequestBody DashboaardSearchVO vo) {
        return dashboardService.selectSensorList(vo.getOrganizationId(), vo.getLocalId());
    }

    // 센서 측정정보리스트
    @ResponseBody
    @PostMapping(value = "/dashSensorList.ajax")
    public List<DashSensorInfoVO> dashSensorList(@RequestBody DashboaardSearchVO vo) {
        return  dashboardService.selectDashSensorInfoList(vo);
    }

    // 관수 정보리스트
    @ResponseBody
    @PostMapping(value = "/dashIrrigationList.ajax")
    public List<DashSensorInfoVO> dashIrrigationList(@RequestBody DashboaardSearchVO vo) {
        return  dashboardService.selectDashIrrigationInfoList(vo);
    }
}
