package com.gn.sungha.sensorInfo;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gn.sungha.common.CommonNmList;
import com.gn.sungha.common.Pagination;
import com.gn.sungha.common.Util;
import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;
import com.gn.sungha.sensor.SensorVO;

/**
 * @Class Name : sensorInfoController.java
 * @Description : 센서정보 Controller
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.27  CHLEE      최초생성
 * @version 1.0 
 */

@RestController
@RequestMapping(value="/sensorInfo")

public class SensorInfoController {

	@Autowired
	private SensorInfoService service;
	
	@Autowired
	private CommonNmList commonNmList;  // 공통 - 기관정보 콤보박스 리스트와 지역 콤보박스 리스트 객체
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorInfoList
	 * @Description : 센서정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.27  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorInfoSearchList.do")
	public ModelAndView selectSensorInfoSearchList(HttpServletRequest httpServletRequest) throws Exception {

		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		String localId = httpServletRequest.getParameter("localId"); // 지역ID
		String searchingOrgId = httpServletRequest.getParameter("orgNm");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("localNm");  // 지역 콤보박스 검색어
		String datepicker = httpServletRequest.getParameter("datepicker");    // 등록일자(TO)
		String datepicker1 = httpServletRequest.getParameter("datepicker1");  // 등록일자(FROM)	
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		String idx = httpServletRequest.getParameter("idx");
		String pageType = httpServletRequest.getParameter("pageType");
		String startPage = httpServletRequest.getParameter("startPage");
		String endPage = httpServletRequest.getParameter("endPage");
		String lastPage = httpServletRequest.getParameter("lastPage");
		String lastRange = httpServletRequest.getParameter("lastRange");
		
		if(Util.isEmpty(searchingOrgId))
			searchingOrgId = "";
		if(Util.isEmpty(sortColumn))
			sortColumn = "1";
		if(Util.isEmpty(sortType))
			sortType = "asc";
		if(Util.isEmpty(page))
			page = "1";
		if(Util.isEmpty(range))
			range = "1";
		if(Util.isEmpty(rangeSize))
			rangeSize="10";
		if(Util.isEmpty(orgId))
			orgId = "";
		if(Util.isEmpty(localId))
			localId = "";
			
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("sensorInfo/sensorInfoList");
		
		Pagination pagination = new Pagination(); // 페이징 객체 생성
		pagination.setPage(Integer.parseInt(page));
		pagination.setPage(Integer.parseInt(range));
		pagination.setPage(Integer.parseInt(rangeSize));
		// 전체현장 개수 조회
		int totalCnt = service.selectSensorInfoListTotalCnt(searchingOrgId, searchingLocalId, datepicker, datepicker1); // 센서정보 리스트 개수 조회
		pagination.pageInfo(Integer.parseInt(page),  Integer.parseInt(range),  totalCnt); // 페이지 처리 메소드에 파라미터 값 입력
		// 기관명 콤보박스 조회
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(searchingOrgId);  // 기관 콤보박스 리스트 조회
		// 지역명 콤보박스 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(searchingOrgId); // 지역 콤보박스 리스트 조회
		// 전체현장 리스트 조회
		List<SensorInfoVO> list = service.selectSensorInfoList(searchingOrgId, searchingLocalId, datepicker, datepicker1, pagination, sortColumn, sortType);
        
		modelAndView.addObject("list", list);
        modelAndView.addObject("orgNmList", orgNmList);
        modelAndView.addObject("localNmList", localNmList);
        modelAndView.addObject("orgNm", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("localNm", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("datepicker", datepicker); // 등록일자 TO
        modelAndView.addObject("datepicker1", datepicker1); // 등록일자 FROM       
        
        modelAndView.addObject("pagination", pagination); // 게시판 페이징 정보 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 게시판 헤더 정렬컬럼 정보 리턴
        modelAndView.addObject("sortType", sortType); // 게시판 헤더 정렬타입 정보 리턴
        modelAndView.addObject("idx", idx);
        modelAndView.addObject("page", page);
        modelAndView.addObject("range", range);
        modelAndView.addObject("rangeSize", rangeSize);
        modelAndView.addObject("pageType", pageType);
        modelAndView.addObject("startPage", startPage);
        modelAndView.addObject("endPage", endPage);
        modelAndView.addObject("lastPage", lastPage);
        modelAndView.addObject("lastRange", lastRange);
        
		return modelAndView;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorInfoList
	 * @Description : 센서정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.27  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorInfoList.do")
	public ModelAndView selectSensorInfoList(HttpServletRequest httpServletRequest) throws Exception {

		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		String localId = httpServletRequest.getParameter("localId"); // 지역ID
		String searchingOrgId = httpServletRequest.getParameter("orgNm");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("localNm");  // 지역 콤보박스 검색어
		String datepicker = httpServletRequest.getParameter("datepicker");    // 등록일자(TO)
		String datepicker1 = httpServletRequest.getParameter("datepicker1");  // 등록일자(FROM)	
		
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		String idx = httpServletRequest.getParameter("idx");
		String pageType = httpServletRequest.getParameter("pageType");
		String startPage = httpServletRequest.getParameter("startPage");
		String endPage = httpServletRequest.getParameter("endPage");
		String lastPage = httpServletRequest.getParameter("lastPage");
		String lastRange = httpServletRequest.getParameter("lastRange");
		
		List<SensorInfoVO> list;
		Pagination pagination = new Pagination(); // 페이징 객체 생성
		
		if(Util.isEmpty(searchingOrgId))
			searchingOrgId = "";
		if(Util.isEmpty(sortColumn))
			sortColumn = "1";
		if(Util.isEmpty(sortType))
			sortType = "asc";
		if(Util.isEmpty(page)) {
			page = "1";
			range = "1";
			rangeSize = "10";
			pagination.setPage(Integer.parseInt(page));
			pagination.setPage(Integer.parseInt(range));
			pagination.setPage(Integer.parseInt(rangeSize));
			//int totalCnt = service.selectSensorInfoListTotalCnt(searchingOrgId, searchingLocalId, datepicker, datepicker1); // 센서정보 리스트 개수 조회
			int totalCnt = 0;
			pagination.pageInfo(Integer.parseInt(page),  Integer.parseInt(range),  totalCnt); // 페이지 처리 메소드에 파라미터 값 입력
			list = service.selectSensorInfoList(" ", " ", datepicker, datepicker1, pagination, sortColumn, sortType);
		} else {
			pagination.setPage(Integer.parseInt(page));
			pagination.setPage(Integer.parseInt(range));
			pagination.setPage(Integer.parseInt(rangeSize));
			int totalCnt = service.selectSensorInfoListTotalCnt(searchingOrgId, searchingLocalId, datepicker, datepicker1); // 센서정보 리스트 개수 조회
			pagination.pageInfo(Integer.parseInt(page),  Integer.parseInt(range),  totalCnt); // 페이지 처리 메소드에 파라미터 값 입력
			list = service.selectSensorInfoList(searchingOrgId, searchingLocalId, datepicker, datepicker1, pagination, sortColumn, sortType);
		}
			
		if(Util.isEmpty(range))
			range = "1";
		if(Util.isEmpty(rangeSize))
			rangeSize="10";
		if(Util.isEmpty(orgId))
			orgId = "";
		if(Util.isEmpty(localId))
			localId = "";
			
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("sensorInfo/sensorInfoList");
		
		//pagination.setPage(Integer.parseInt(page));
		//pagination.setPage(Integer.parseInt(range));
		//pagination.setPage(Integer.parseInt(rangeSize));
		//int totalCnt = service.selectSensorInfoListTotalCnt(searchingOrgId, searchingLocalId, datepicker, datepicker1); // 센서정보 리스트 개수 조회
		//pagination.pageInfo(Integer.parseInt(page),  Integer.parseInt(range),  totalCnt); // 페이지 처리 메소드에 파라미터 값 입력
		
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(searchingOrgId);  // 기관 콤보박스 리스트 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(orgNmList.get(0).getOrganizationId()); // 지역 콤보박스 리스트 조회

        modelAndView.addObject("list", list);
        modelAndView.addObject("orgNmList", orgNmList);
        modelAndView.addObject("localNmList", localNmList);
        modelAndView.addObject("orgNm", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("localNm", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("datepicker", datepicker); // 등록일자 TO
        modelAndView.addObject("datepicker1", datepicker1); // 등록일자 FROM       
        modelAndView.addObject("pagination", pagination); // 게시판 페이징 정보 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 게시판 헤더 정렬컬럼 정보 리턴
        modelAndView.addObject("sortType", sortType); // 게시판 헤더 정렬타입 정보 리턴
        modelAndView.addObject("idx", idx);
        modelAndView.addObject("page", page);
        modelAndView.addObject("range", range);
        modelAndView.addObject("rangeSize", rangeSize);

        modelAndView.addObject("pageType", pageType);
        modelAndView.addObject("startPage", startPage);
        modelAndView.addObject("endPage", endPage);
        modelAndView.addObject("lastPage", lastPage);
        modelAndView.addObject("lastRange", lastRange);
        
        
		return modelAndView;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorInfoDetail
	 * @Description : 계측데이터 상세 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.27  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorInfoDetail.do")
	public ModelAndView selectSensorInfoDetail(HttpServletRequest httpServletRequest) throws Exception {
		String count = httpServletRequest.getParameter("count"); // 센서ID
		
		String organizationId = httpServletRequest.getParameter("organizationId"); // 센서ID
		String localId = httpServletRequest.getParameter("localId"); // 센서ID
		
		
		String sensorId = httpServletRequest.getParameter("sensorId"); // 센서ID
		String sensor = httpServletRequest.getParameter("sensor"); // 센서명
		String regDate = httpServletRequest.getParameter("regDate"); // 계측일시
		String temp = httpServletRequest.getParameter("temp"); // 온도
		String humi = httpServletRequest.getParameter("humi"); // 수분함량
		String ph = httpServletRequest.getParameter("ph"); // 산도
		String conduc = httpServletRequest.getParameter("conduc"); // 전도도
		String nitro = httpServletRequest.getParameter("nitro"); // 질소
		String phos = httpServletRequest.getParameter("phos"); // 인
		String pota = httpServletRequest.getParameter("pota"); // 칼륨
		String batcaprema = httpServletRequest.getParameter("batcaprema"); // 배터리

		SensorInfoVO sensorRangeValue = service.selectSensorControlInfoDetail(sensorId);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("sensorInfo/sensorInfoDetail");
		modelAndView.addObject("sensor", sensor);

		String[] temp1 = regDate.split("");	
		String temp12 = temp1[0] + temp1[1] + temp1[2] + temp1[3] + '-' + temp1[4] + temp1[5] + '-' 
				+ temp1[6] + temp1[7] + ' ' + temp1[8] + temp1[9] + ':' + temp1[10] + temp1[11];
		
		modelAndView.addObject("tempMin", sensorRangeValue.getTempValueMin());
		modelAndView.addObject("tempMax", sensorRangeValue.getTempValueMax());
		modelAndView.addObject("humiMin", sensorRangeValue.getHumiValueMin());
		modelAndView.addObject("humiMax", sensorRangeValue.getHumiValueMax());
		modelAndView.addObject("phMin", sensorRangeValue.getPhValueMin());
		modelAndView.addObject("phMax", sensorRangeValue.getPhValueMax());
		modelAndView.addObject("conducMin", sensorRangeValue.getConducValueMin());
		modelAndView.addObject("conducMax", sensorRangeValue.getConducValueMax());
		modelAndView.addObject("nitroMin", sensorRangeValue.getNitroValueMin());
		modelAndView.addObject("nitroMax", sensorRangeValue.getNitroValueMax());
		modelAndView.addObject("phosMin", sensorRangeValue.getPhosValueMin());
		modelAndView.addObject("phosMax", sensorRangeValue.getPhosValueMax());
		modelAndView.addObject("potaMin", sensorRangeValue.getPotaValueMin());
		modelAndView.addObject("potaMax", sensorRangeValue.getPotaValueMax());
		modelAndView.addObject("batcapremaMin", sensorRangeValue.getBatcapremaValueMin());
		modelAndView.addObject("batcapremaMax", sensorRangeValue.getBatcapremaValueMax());
		
		modelAndView.addObject("organizationId", organizationId);
		modelAndView.addObject("localId", localId);
		
		modelAndView.addObject("sensorId", sensorId);
		modelAndView.addObject("regDate", temp12);
		modelAndView.addObject("temp", temp);
		modelAndView.addObject("humi", humi);
		modelAndView.addObject("ph", ph);
		modelAndView.addObject("conduc", conduc);
		modelAndView.addObject("nitro", nitro);
		modelAndView.addObject("phos", phos);
		modelAndView.addObject("pota", pota);
		modelAndView.addObject("batcaprema", batcaprema);

		return modelAndView;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectLocalNmList
	 * @Description : 지역정보 콤보박스 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/localNmList.do")
	public HashMap<String, Object> selectLocalNmList(HttpServletRequest httpServletRequest) throws Exception {
		String orgId = httpServletRequest.getParameter("searchingOrgId"); // orgInfoList.jsp에서 보내온 파라미터를 받는다.
		if(Util.isEmpty(orgId)) // orgId가 null이면 초기화
			orgId = "total";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("orgInfo/orgInfoList");
		List<localVO> localNmList = commonNmList.selectLocalNmList(orgId);
		HashMap<String, Object> list = new HashMap<String, Object>();
		list.put("list", localNmList);
		list.put("listSize", localNmList.size());
		return list;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : excelDownload
	 * @Description : 엑셀다운로드 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.01.03  이창호      최초생성
	 * @
	 */
	
	@RequestMapping("/point.do")
    public ResponseEntity getUsersPointStats(HttpServletRequest httpServletRequest, HttpServletResponse response, boolean excelDownload) throws Exception{
		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		String localId = httpServletRequest.getParameter("localId"); // 지역ID
		String searchingOrgId = httpServletRequest.getParameter("orgNm");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("localNm");  // 지역 콤보박스 검색어
		String datepicker = httpServletRequest.getParameter("datepicker");    // 등록일자(TO)
		String datepicker1 = httpServletRequest.getParameter("datepicker1");  // 등록일자(FROM)	
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		String idx = httpServletRequest.getParameter("idx");
		
        return ResponseEntity.ok(service.getUsersPointStats(response, excelDownload, searchingOrgId, searchingLocalId,datepicker,datepicker1,new Pagination(), "1", "asc"));
    }
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorInfoSearchData
	 * @Description : 센서정보 항목별 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.07  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorInfoSearchData.do")
	public ModelAndView selectSensorInfoSearchData(HttpServletRequest httpServletRequest) throws Exception {

		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		String localId = httpServletRequest.getParameter("localId"); // 지역ID
		String sensorId = httpServletRequest.getParameter("sensorId");  // 센서ID		
		String searchingOrgId = httpServletRequest.getParameter("orgNm");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("localNm");  // 지역 콤보박스 검색어
		String searchingSensorId = httpServletRequest.getParameter("sensorNm");  // 센서명 콤보박스 검색어
		String searchingSensorGubun = httpServletRequest.getParameter("searchingSensorGubun");  // 센서항목 콤보박스 검색어

		if(Util.isEmpty(searchingOrgId))
			searchingOrgId = "";
		if(Util.isEmpty(orgId))
			orgId = "";
		if(Util.isEmpty(localId))
			localId = "";
		if(Util.isEmpty(sensorId))
			sensorId = "";
		if(Util.isEmpty(searchingSensorGubun))
			searchingSensorGubun = "";
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("sensorInfo/sensorInfoData");

		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(searchingOrgId);  // 기관 콤보박스 리스트 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(orgNmList.get(0).getOrganizationId()); // 지역 콤보박스 리스트 조회
		List<SensorVO> sensorNmList = commonNmList.selectSensorComboList(localNmList.get(0).getLocalId()); // 센서 콤보박스 리스트 조회
		List<SensorInfoVO> list = service.selectSensorInfoSearchData(searchingOrgId, searchingLocalId, searchingSensorId, searchingSensorGubun);

		modelAndView.addObject("list", list);
		modelAndView.addObject("listSize", list.size());
        modelAndView.addObject("orgNmList", orgNmList);
        modelAndView.addObject("localNmList", localNmList);
        modelAndView.addObject("sensorNmList", sensorNmList);
        modelAndView.addObject("orgNm", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("localNm", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("searchingSensorId", searchingSensorId); // 센서 콤보박스 검색어 리턴
        modelAndView.addObject("searchingSensorGubun", searchingSensorGubun); // 센서항목 콤보박스 검색어 리턴
                
		return modelAndView;
	}

	/**
	 * @throws Exception 
	 * @Method Name : selectSensorInfoSearchData
	 * @Description : 센서정보 항목별 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.07  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorNmList.do")
	public HashMap<String, Object> selectSensorInfoListData(HttpServletRequest httpServletRequest) throws Exception {
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어	
		
		List<SensorVO> sensorNmList = commonNmList.selectSensorComboList(searchingLocalId); // 센서 콤보박스 리스트 조회
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("sensorNmList", sensorNmList);
		result.put("sensorNmListSize", sensorNmList.size());

		return result;
	}
	
}
