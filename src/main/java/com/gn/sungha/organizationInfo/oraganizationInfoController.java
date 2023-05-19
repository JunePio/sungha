package com.gn.sungha.organizationInfo;

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
import com.gn.sungha.irrigation.IrrigationVO;
import com.gn.sungha.local.localVO;
import com.gn.sungha.sensor.SensorVO;

/**
 * 성하 기관정보 컨트롤러
 * 
 *
 * 
 */

@RestController
@RequestMapping(value="/orgInfo")
public class oraganizationInfoController {

	@Autowired
	private organizationInfoService service;
	
	@Autowired
	private CommonNmList commonNmList; // 공통 - 기관정보 콤보박스 리스트와 지역 콤보박스 리스트 객체
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOrgInfoList
	 * @Description : 기관정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/orgInfoList.do")
	public ModelAndView selectOrgInfoList(HttpServletRequest httpServletRequest) throws Exception {
		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		String localId = httpServletRequest.getParameter("localId"); // 지역ID
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String personInCharge = httpServletRequest.getParameter("personInCharge"); // 담당자 검색어
		
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		String idx = httpServletRequest.getParameter("idx");
		
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
			rangeSize = "10";
		if(Util.isEmpty(orgId))
			orgId = "";
		if(Util.isEmpty(localId))
			localId = "";
		if(Util.isEmpty(personInCharge))
			personInCharge = "";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("orgInfo/orgInfoList"); // view 파일 경로
		Pagination pagination = new Pagination(); // 페이징 객체 생성
		pagination.setPage(Integer.parseInt(page));
		pagination.setPage(Integer.parseInt(range));
		pagination.setPage(Integer.parseInt(rangeSize));
		int totalCnt = service.selectOrgInfoListTotalCnt(searchingOrgId, searchingLocalId, personInCharge); // 기관정보 리스트 개수 조회
		pagination.pageInfo(Integer.parseInt(page),  Integer.parseInt(range),  totalCnt); // 페이지 처리 메소드에 파라미터 값 입력
		// 기관정보 리스트 조회
		List<organizationInfoVO> orgInfoList = service.selectOrgInfoList(searchingOrgId, searchingLocalId, personInCharge, pagination, sortColumn, sortType);
		
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(searchingOrgId);  // 기관 콤보박스 리스트 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(searchingOrgId); // 지역 콤보박스 리스트 조회
		
        modelAndView.addObject("orgInfoList", orgInfoList); // 기관정보 조회 리스트
        modelAndView.addObject("orgNmList", orgNmList);     // 기관정보 콤보박스 리스트
        modelAndView.addObject("localNmList", localNmList); // 지역정보 콤보박스 리스트
        modelAndView.addObject("orgId", orgId);
        modelAndView.addObject("localId", localId);
        modelAndView.addObject("searchingOrgId", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("searchingLocalId", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("personInCharge", personInCharge); // 담당자 검색어 리턴
        modelAndView.addObject("pagination", pagination); // 게시판 페이징 정보 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 게시판 헤더 정렬컬럼 정보 리턴
        modelAndView.addObject("sortType", sortType); // 게시판 헤더 정렬타입 정보 리턴
        modelAndView.addObject("idx", idx);
        modelAndView.addObject("page", page);
        modelAndView.addObject("range", range);
        modelAndView.addObject("rangeSize", rangeSize);
        
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
		//ModelAndView modelAndView = new ModelAndView();
		//modelAndView.setViewName("orgInfo/orgInfoList");
		List<localVO> localNmList = commonNmList.selectLocalNmList(orgId);
		HashMap<String, Object> list = new HashMap<String, Object>();
		list.put("list", localNmList);
		list.put("listSize", localNmList.size());
		return list;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOrgInfoRegist
	 * @Description : 기관정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/orgInfoRegist.do")
	public ModelAndView selectOrgInfoRegist(HttpServletRequest httpServletRequest) throws Exception {
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		
		
		HashMap<String, Object> detail = new HashMap<String, Object>();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("orgInfo/orgInfoRegist"); // view 파일 경로
		
		modelAndView.addObject("searchingOrgId", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("searchingLocalId", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("searchingType", searchingType); // 센서명 or 센서ID 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색어 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 정렬 컬럼
        modelAndView.addObject("sortType", sortType); // 정렬 방식
        modelAndView.addObject("page", page);
        modelAndView.addObject("range", range);
        modelAndView.addObject("rangeSize", rangeSize);
        
        
		return modelAndView;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectDupCheck
	 * @Description : 기관아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/dupCheck.do")
	public HashMap<String, Object> selectDupCheck(HttpServletRequest httpServletRequest) throws Exception {
		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		if(Util.isEmpty(orgId))
			orgId = "";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("orgInfo/orgInfoList");
		boolean dupCheckResult = service.selectDupCheck(orgId);
		HashMap<String, Object> list = new HashMap<String, Object>();
		list.put("dupCheckResult", dupCheckResult);
		return list;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertOrgInfoSave
	 * @Description : 기관정보 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/orgInfoSave.do")
	public HashMap<String, Object> insertOrgInfoSave(HttpServletRequest httpServletRequest) throws Exception {
		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		String orgNm = httpServletRequest.getParameter("orgNm"); // 기관명
		String personInCharge = httpServletRequest.getParameter("personInCharge"); // 담당자
		String telNo = httpServletRequest.getParameter("telNo"); // 연락처
		String email = httpServletRequest.getParameter("email"); // 이메일
		boolean saveResult = false;
		//for(int i = 0 ; i < 500; i++) {
			saveResult = service.insertOrgInfoSave(orgId, orgNm, personInCharge, telNo, email);
		//}
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("saveResult", saveResult);
		return result;
	}
	
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOrgInfoDetail
	 * @Description : 기관정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/orgInfoDetail.do")
	public ModelAndView selectOrgInfoDetail(HttpServletRequest httpServletRequest) throws Exception {
		String orgId = httpServletRequest.getParameter("orgIdParam"); // 센서ID
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		
		organizationInfoVO orgInfoDetail = service.selectOrgInfoDetail(orgId);
		
		//File file = new File(filePath + sensorInfoDetail.getUuidName());
		//sensorInfoDetail.setFile(new FileInputStream(file));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("orgInfo/orgInfoDetail"); // view 파일 경로
		
		modelAndView.addObject("orgInfoDetail", orgInfoDetail);
		modelAndView.addObject("searchingOrgId", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("searchingLocalId", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("searchingType", searchingType); // 센서명 or 센서ID 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색어 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 정렬 컬럼
        modelAndView.addObject("sortType", sortType); // 정렬 방식
        modelAndView.addObject("page", page);
        modelAndView.addObject("range", range);
        modelAndView.addObject("rangeSize", rangeSize);
        
		return modelAndView;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOrgInfoModDetail
	 * @Description : 사용자관리 수정조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/orgInfoModDetail.do")
	public ModelAndView selectOrgInfoModDetail(HttpServletRequest httpServletRequest) throws Exception {
		String orgInfoId = httpServletRequest.getParameter("orgInfoIdMod"); // 센서ID
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		
		
		organizationInfoVO orgInfoModDetail = service.selectOrgInfoModDetail(orgInfoId);
		
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(orgInfoId);  // 기관 콤보박스 리스트 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(orgInfoModDetail.getOrganizationId());
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("orgInfo/orgInfoMod"); // view 파일 경로
		
		modelAndView.addObject("orgInfoModDetail", orgInfoModDetail);
		modelAndView.addObject("searchingOrgId", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("searchingLocalId", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("searchingType", searchingType); // 센서명 or 센서ID 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색어 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 정렬 컬럼
        modelAndView.addObject("sortType", sortType); // 정렬 방식
        modelAndView.addObject("page", page);
        modelAndView.addObject("range", range);
        modelAndView.addObject("rangeSize", rangeSize);        
        
		return modelAndView;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertOrgInfoMod
	 * @Description : 기관정보 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/orgInfoMod.do")
	public HashMap<String, Object> updateOrgInfoMod(HttpServletRequest httpServletRequest) throws Exception {
		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		String orgNm = httpServletRequest.getParameter("orgNm"); // 기관명
		String personInCharge = httpServletRequest.getParameter("personInCharge"); // 담당자
		String telNo = httpServletRequest.getParameter("telNo"); // 연락처
		String email = httpServletRequest.getParameter("email"); // 이메일
		boolean modResult = true;
		try {
			service.updateOrgInfoMod(orgId, orgNm, personInCharge, telNo, email);
		} catch(Exception e) {
			modResult = false;
		}
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("modResult", modResult);
		return result;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOrgInfoDelIsOk
	 * @Description : 기관정보 삭제해도 되는지 사용자, 센서, 관수 체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/orgInfoDelIsOk.do")
	public HashMap<String, Object> deleteOrgInfoDelIsOk(HttpServletRequest httpServletRequest) throws Exception {
		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		boolean checkResult = true;
		try {
			checkResult = service.deleteOrgInfoDelIsOk(orgId);
		} catch(Exception e) {
			checkResult = false;
		}
		HashMap<String, Object> checkCnt = new HashMap<String, Object>();
		checkCnt.put("checkResult", checkResult);
		return checkCnt;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOrgInfoDel
	 * @Description : 기관정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/orgInfoDel.do")
	public HashMap<String, Object> deleteOrgInfoDel(HttpServletRequest httpServletRequest) throws Exception {
		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		boolean delResult = true;
		try {
			service.deleteOrgInfoDel(orgId);
		} catch(Exception e) {
			delResult = false;
		}
		HashMap<String, Object> modDetail = new HashMap<String, Object>();
		modDetail.put("delResult", delResult);
		return modDetail;
		
	}
	
	@RequestMapping("/point")
    public ResponseEntity getUsersPointStats(HttpServletResponse response, boolean excelDownload) throws Exception{
        return ResponseEntity.ok(service.getUsersPointStats(response, excelDownload, "", "", "", new Pagination(), "1", "asc"));
    }
	
	@RequestMapping("/excel.do")
    public ResponseEntity getUsersPointStats(HttpServletRequest httpServletRequest, HttpServletResponse response, boolean excelDownload) throws Exception{
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId"); // 기관ID
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId"); // 지역ID
		String personInCharge = httpServletRequest.getParameter("personInCharge"); // 담당자
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType"); // 정렬 타입
		
        return ResponseEntity.ok(service.selectOrgExcel(response, searchingOrgId, searchingLocalId, personInCharge, new Pagination(), sortColumn, sortType));
    }
}
