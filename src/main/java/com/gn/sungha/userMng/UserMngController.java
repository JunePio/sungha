package com.gn.sungha.userMng;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gn.sungha.common.CommonNmList;
import com.gn.sungha.common.Pagination;
import com.gn.sungha.common.Util;
import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoService;
import com.gn.sungha.organizationInfo.organizationInfoVO;

/**
 * 사용자정보 컨트롤러
 * 
 *
 * 
 */

@RestController
@RequestMapping(value="/userMng")
public class UserMngController {
	
	@Autowired
	private UserMngService service;
	
	@Autowired
	private CommonNmList commonNmList; // 공통 - 기관정보 콤보박스 리스트와 지역 콤보박스 리스트 객체
	
	/**
	 * @throws Exception 
	 * @Method Name : selectUserMngList
	 * @Description : 기관정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/userMngList.do")
	public ModelAndView selectOrgInfoList(HttpServletRequest httpServletRequest) throws Exception {
		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		String localId = httpServletRequest.getParameter("localId"); // 지역ID
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 검색 타입
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색 내용
		
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
		if(Util.isEmpty(searchingType))
			searchingType = "";
		if(Util.isEmpty(searchingContent))
			searchingContent = "";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("userMng/userMngList"); // view 파일 경로
		Pagination pagination = new Pagination(); // 페이징 객체 생성
		pagination.setPage(Integer.parseInt(page));
		pagination.setPage(Integer.parseInt(range));
		pagination.setPage(Integer.parseInt(rangeSize));
		int totalCnt = service.selectUserMngListTotalCnt(searchingOrgId, searchingLocalId, searchingType, searchingContent); // 기관정보 리스트 개수 조회
		pagination.pageInfo(Integer.parseInt(page),  Integer.parseInt(range),  totalCnt); // 페이지 처리 메소드에 파라미터 값 입력
		// 기관정보 리스트 조회
		List<UserMngVO> orgInfoList = service.selectUserMngList(searchingOrgId, searchingLocalId, searchingType, searchingContent, pagination, sortColumn, sortType);
		
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(searchingOrgId);  // 기관 콤보박스 리스트 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(searchingOrgId); // 지역 콤보박스 리스트 조회
		
		List<UserMngVO> userLevelList = service.selectUserLevelList(); // 사용자 레벨 콤보박스 리스트 조회
		
        modelAndView.addObject("userMngList", orgInfoList); // 기관정보 조회 리스트
        modelAndView.addObject("orgNmList", orgNmList);     // 기관정보 콤보박스 리스트
        modelAndView.addObject("localNmList", localNmList); // 지역정보 콤보박스 리스트
        modelAndView.addObject("orgId", orgId);
        modelAndView.addObject("localId", localId);
        modelAndView.addObject("searchingOrgId", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("searchingLocalId", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("searchingType", searchingType); // 검색 타입 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색 내용 리턴
        modelAndView.addObject("userLevelList", userLevelList); // 사용자 레벨 콤보박스 리스트 리턴
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
	 * @Method Name : selectUserMngRegist
	 * @Description : 사용자 등록 페이지 불러오기
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/userMngRegist.do")
	public ModelAndView selectUserMngRegist(HttpServletRequest httpServletRequest) throws Exception {
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 검색 타입
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색 내용
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		
		String userMngId = httpServletRequest.getParameter("userIdParam"); // 사용자ID
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		
		
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(searchingOrgId);  // 기관 콤보박스 리스트 조회
		String tempOrgId = orgNmList.get(0).getOrganizationId();
		List<localVO> localNmList = commonNmList.selectLocalNmList(tempOrgId); // 지역 콤보박스 리스트 조회
		
		List<UserMngVO> userLevelList = service.selectUserLevelList(); // 사용자 레벨 콤보박스 리스트 조회
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("userMng/userMngRegist"); // view 파일 경로
		
		modelAndView.addObject("orgNmList", orgNmList);     // 기관정보 콤보박스 리스트
        modelAndView.addObject("localNmList", localNmList); // 지역정보 콤보박스 리스트
        modelAndView.addObject("userLevelList", userLevelList); // 사용자 레벨 콤보박스 리스트 리턴
        modelAndView.addObject("searchingOrgId", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("searchingLocalId", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("searchingType", searchingType); // 검색 타입 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색 내용 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 게시판 헤더 정렬컬럼 정보 리턴
        modelAndView.addObject("sortType", sortType); // 게시판 헤더 정렬타입 정보 리턴
        modelAndView.addObject("page", page);
        modelAndView.addObject("range", range);
        modelAndView.addObject("rangeSize", rangeSize);        
        
		return modelAndView;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateUserMngConfirm
	 * @Description : 승인 변경
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/userMngConfirm.do")
	public HashMap<String, Object> updateUserMngConfirm(HttpServletRequest httpServletRequest) throws Exception {
		String userId = httpServletRequest.getParameter("userId"); // 사용자ID
		String confirmStateMod = httpServletRequest.getParameter("confirmStateMod"); // 수정된 승인상태
		UserMngVO resultDate = new UserMngVO();
		boolean confirmResult = true;
		
		try {
			resultDate = service.updateUserMngConfirm(userId, confirmStateMod); // 승인 변경에 따른 승인일 가져오기 or 취소일 가져오기
		} catch(Exception e) {
			confirmResult = false;
		}
		HashMap<String, Object> confirm = new HashMap<String, Object>();
		confirm.put("confirmResult", confirmResult);
		confirm.put("confirmDate", resultDate.getConfirmDate());
		confirm.put("cancelDate", resultDate.getCancelDate());
		return confirm;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectUserMngDupCheck
	 * @Description : 사용자아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/userMngDupCheck.do")
	public HashMap<String, Object> selectUserMngDupCheck(HttpServletRequest httpServletRequest) throws Exception {
		String userId = httpServletRequest.getParameter("userId"); // 사용자ID
		if(Util.isEmpty(userId))
			userId = "";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("userMng/userMngList");
		boolean dupCheckResult = service.selectUserMngDupCheck(userId);
		HashMap<String, Object> list = new HashMap<String, Object>();
		list.put("dupCheckResult", dupCheckResult);
		return list;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectRoleLocal
	 * @Description : 권한지역 선택 팝업에 데이터 전송 
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/roleLocal.do")
	public ModelAndView selectRoleLocal(HttpServletRequest httpServletRequest) throws Exception {
		String registOrgId = httpServletRequest.getParameter("registOrgId"); // 기관ID
		if(Util.isEmpty(registOrgId))
			registOrgId = "";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("userMng/roleLocal");
		List<localVO> roleLocalList = service.selectRoleLocal(registOrgId);
		modelAndView.addObject("roleLocalList", roleLocalList);
		modelAndView.addObject("registOrgId", registOrgId);
		return modelAndView;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectRoleLocalMod
	 * @Description : 사용자관리 수정시 권한지역 선택 팝업에 데이터 전송 
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/roleLocalMod.do")
	public ModelAndView selectRoleLocalMod(HttpServletRequest httpServletRequest) throws Exception {
		String orgIdMod = httpServletRequest.getParameter("orgIdMod"); // 기관ID
		String roleLocalIdMod = httpServletRequest.getParameter("roleLocalIdMod"); // 권한지역ID
		if(Util.isEmpty(roleLocalIdMod))
			roleLocalIdMod = "";
		String[] roleLocalIdModList = roleLocalIdMod.split(",");
		if(Util.isEmpty(orgIdMod))
			orgIdMod = "";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("userMng/roleLocalMod"); // view 이름 입력
		List<localVO> roleLocalList = service.selectRoleLocal(orgIdMod);
		modelAndView.addObject("roleLocalList", roleLocalList);
		modelAndView.addObject("orgIdMod", orgIdMod);
		modelAndView.addObject("roleLocalIdModList", roleLocalIdModList);
		return modelAndView;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectRoleLocalSearchList
	 * @Description : 권한지역 선택 팝업 검색
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/roleLocalSearchList.do")
	public ModelAndView selectRoleLocalSearchList(HttpServletRequest httpServletRequest) throws Exception {
		String registOrgId = httpServletRequest.getParameter("registOrgId"); // 기관ID
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("userMng/roleLocal");
		List<localVO> roleLocalList = service.selectRoleLocalSearchList(registOrgId, searchingContent);
		modelAndView.addObject("roleLocalList", roleLocalList);
		modelAndView.addObject("registOrgId", registOrgId);
		modelAndView.addObject("searchingContent", searchingContent);
		return modelAndView;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectRoleLocal
	 * @Description : 권한지역 선택 팝업에 데이터 전송 
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/roleLocalSend.do")
	public ModelAndView selectRoleLocalSend(HttpServletRequest httpServletRequest, @RequestParam(value="localIdArray[]") String[] localIdArray, @RequestParam(value="localArray[]") String[] localArray) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("userMng/userMngList");
		//List<localVO> roleLocalList = service.selectRoleLocal(registOrgId);
		modelAndView.addObject("localArray", localArray);
		return modelAndView;
	}
	
	
	/**
	 * @throws Exception 
	 * @Method Name : insertUserMngSave
	 * @Description : 기관정보 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/userMngSave.do")
	public HashMap<String, Object> insertUserMngSave(HttpServletRequest httpServletRequest) throws Exception {
		String inputUserId = httpServletRequest.getParameter("inputUserId"); // 사용자ID
		String inputUserNm = httpServletRequest.getParameter("inputUserNm"); // 사용자명
		String registOrgId = httpServletRequest.getParameter("registOrgId"); // 기관ID
		String userLevelRegist = httpServletRequest.getParameter("userLevelRegist"); // 사용자 레벨
		String telNo = httpServletRequest.getParameter("telNo"); // 연락처
		String email = httpServletRequest.getParameter("email"); // 이메일
		String roleLocalId = httpServletRequest.getParameter("roleLocalId"); // 권한지역
		boolean saveResult = false;
		//for(int i = 0 ; i < 500; i++) {
			saveResult = service.insertUserMngSave(inputUserId, inputUserNm, registOrgId, userLevelRegist, telNo, email, roleLocalId);
		//}
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("saveResult", saveResult);
		return result;
	}
	
	
	/**
	 * @throws Exception 
	 * @Method Name : selectUserMngDetail
	 * @Description : 사용자관리 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/userMngDetail.do")
	public ModelAndView selectUserMngDetail(HttpServletRequest httpServletRequest) throws Exception {
		String userId = httpServletRequest.getParameter("userIdParam"); // 사용자ID
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 검색 타입
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색 내용
		
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		
		UserMngVO userMngDetail = service.selectUserMngDetail(userId);
		
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/userMng/userMngDetail");
		
		modelAndView.addObject("userMngDetail", userMngDetail);
		modelAndView.addObject("searchingOrgId", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("searchingLocalId", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("searchingType", searchingType); // 검색 타입 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색 내용 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 게시판 헤더 정렬컬럼 정보 리턴
        modelAndView.addObject("sortType", sortType); // 게시판 헤더 정렬타입 정보 리턴
        modelAndView.addObject("page", page);
        modelAndView.addObject("range", range);
        modelAndView.addObject("rangeSize", rangeSize);
        
		return modelAndView;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectUserMngModDetail
	 * @Description : 사용자관리 수정조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/userMngModDetail.do")
	public ModelAndView selectUserMngModDetail(HttpServletRequest httpServletRequest) throws Exception {
		String userId = httpServletRequest.getParameter("userIdParam"); // 사용자ID
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 검색 타입
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색 내용
		
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		
		
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(searchingOrgId);  // 기관 콤보박스 리스트 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(searchingOrgId); // 지역 콤보박스 리스트 조회
		
		UserMngVO userMngModDetail = service.selectUserMngDetail(userId);		
		
		List<UserMngVO> userLevelList = service.selectUserLevelList(); // 사용자 레벨 콤보박스 리스트 조회
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/userMng/userMngMod");
		
		modelAndView.addObject("userMngModDetail", userMngModDetail);
		modelAndView.addObject("orgNmList", orgNmList);
		modelAndView.addObject("localNmList", localNmList);
		modelAndView.addObject("userLevelList", userLevelList);
		modelAndView.addObject("searchingOrgId", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("searchingLocalId", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("searchingType", searchingType); // 검색 타입 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색 내용 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 게시판 헤더 정렬컬럼 정보 리턴
        modelAndView.addObject("sortType", sortType); // 게시판 헤더 정렬타입 정보 리턴
        modelAndView.addObject("page", page);
        modelAndView.addObject("range", range);
        modelAndView.addObject("rangeSize", rangeSize);        
        
		return modelAndView;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertOrgInfoMod
	 * @Description : 사용자관리 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/userMngMod.do")
	public HashMap<String, Object> updateUserMngMod(HttpServletRequest httpServletRequest) throws Exception {
		String userId = httpServletRequest.getParameter("userId"); // 사용자ID
		String userNm = httpServletRequest.getParameter("userNm"); // 사용자명
		String userLevel = httpServletRequest.getParameter("userLevel"); // 사용자 레벨
		String telNo = httpServletRequest.getParameter("telNo"); // 연락처
		String email = httpServletRequest.getParameter("email"); // 이메일
		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		String roleLocalIdMod = httpServletRequest.getParameter("roleLocalIdMod"); // 권한지역ID
		
		boolean modResult = true;
		try {
			service.updateUserMngMod(userId, userNm, userLevel, telNo, email, orgId, roleLocalIdMod);
		} catch(Exception e) {
			modResult = false;
		}
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("modResult", modResult);
		return result;
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
	@RequestMapping(value="/userMngDel.do")
	public HashMap<String, Object> deleteUserMngDel(HttpServletRequest httpServletRequest) throws Exception {
		String userId = httpServletRequest.getParameter("userId"); // 기관ID
		boolean delResult = true;
		try {
			service.deleteUserMngDel(userId);
		} catch(Exception e) {
			e.printStackTrace();
			delResult = false;
		}
		HashMap<String, Object> modDetail = new HashMap<String, Object>();
		modDetail.put("delResult", delResult);
		return modDetail;
		
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
	@RequestMapping(value="/userMngPasswordChange.do")
	public HashMap<String, Object> updatePasswordChange(HttpServletRequest httpServletRequest) throws Exception {
		String userId = httpServletRequest.getParameter("userId"); // 사용자ID
		HashMap<String, Object> modDetail = new HashMap<String, Object>();
		modDetail.put("changeResult", service.updatePasswordChange(userId));
		return modDetail;
		
	}
	
	@RequestMapping("/excel.do")
    public ResponseEntity getUsersPointStats(HttpServletRequest httpServletRequest, HttpServletResponse response, boolean excelDownload) throws Exception{
		String orgId = httpServletRequest.getParameter("orgId");
		String localId = httpServletRequest.getParameter("localId");
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 검색 타입
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색 내용
		
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		
        return ResponseEntity.ok(service.selectOrgExcel(response, searchingOrgId, searchingLocalId, searchingType, searchingContent, new Pagination(), sortColumn, sortType));
    }
	
}
