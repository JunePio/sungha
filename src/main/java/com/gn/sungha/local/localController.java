package com.gn.sungha.local;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.gn.sungha.common.CommonNmList;
import com.gn.sungha.common.Pagination;
import com.gn.sungha.common.Util;
import com.gn.sungha.organizationInfo.organizationInfoService;
import com.gn.sungha.organizationInfo.organizationInfoVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StreamUtils;
import org.springframework.util.StringUtils;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

/**
 * 성하 지역 컨트롤러
 * 
 *
 * 
 */

/**
 * @author gn
 *
 */
@Slf4j
@RestController
@RequestMapping(value="/local")
public class localController {
	
	private final static Logger log = Logger.getGlobal(); // 메일 발송시 에러 로그 체크
	
	@Autowired
	private localService service;
	
	@Autowired
	private CommonNmList commonNmList; // 공통 - 기관정보 콤보박스 리스트와 지역 콤보박스 리스트 객체
	
	@Autowired
	private JavaMailSender javaMailSender; // 메일 발송 객체
	
	//@Value("${spring.servlet.multipart.location}")
	private String filePath = "C:\\local_file_store";
	
	/**
	 * @throws Exception 
	 * @Method Name : selectLocalList
	 * @Description : 지역 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/localList.do")
	public ModelAndView selectLocalList(HttpServletRequest httpServletRequest) throws Exception {
		String orgId = httpServletRequest.getParameter("orgId");
		String localId = httpServletRequest.getParameter("localId");
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		
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
		modelAndView.setViewName("local/localList"); // view 파일 경로
		Pagination pagination = new Pagination(); // 페이징 객체 생성
		pagination.setPage(Integer.parseInt(page));
		pagination.setPage(Integer.parseInt(range));
		pagination.setPage(Integer.parseInt(rangeSize));
		int totalCnt = service.selectLocalListTotalCnt(searchingOrgId, searchingLocalId); // 지역 리스트 개수 조회
		pagination.pageInfo(Integer.parseInt(page),  Integer.parseInt(range),  totalCnt); // 페이지 처리 메소드에 파라미터 값 입력
		
		// 지역 리스트 조회
		List<localVO> localList = service.selectLocalList(searchingOrgId, searchingLocalId, pagination, sortColumn, sortType);
		
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(searchingOrgId);  // 기관 콤보박스 리스트 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(searchingOrgId); // 지역 콤보박스 리스트 조회
		
        modelAndView.addObject("localList", localList); // 지역 조회 리스트
        modelAndView.addObject("orgNmList", orgNmList);     // 기관정보 콤보박스 리스트
        modelAndView.addObject("localNmList", localNmList); // 지역정보 콤보박스 리스트
        modelAndView.addObject("orgId", orgId);
        modelAndView.addObject("localId", localId);
        modelAndView.addObject("searchingOrgId", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("searchingLocalId", searchingLocalId); // 지역 콤보박스 검색어 리턴
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
	 * @Method Name : selectLocalNmList
	 * @Description : 지역 콤보박스 조회
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
	@RequestMapping(value="/localRegist.do")
	public ModelAndView selectLocalRegist(HttpServletRequest httpServletRequest) throws Exception {
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");  // 지역 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList("");  // 기관 콤보박스 리스트 조회
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("local/localRegist"); // view 파일 경로
		
		modelAndView.addObject("orgNmList", orgNmList); // 기관 콤보박스 리턴
		modelAndView.addObject("searchingOrgId", searchingOrgId); // 기관 콤보박스 검색어 리턴    
        modelAndView.addObject("searchingLocalId", searchingLocalId); // 지역 콤보박스 검색어 리턴       
        modelAndView.addObject("sortColumn", sortColumn); // 정렬 컬럼
        modelAndView.addObject("sortType", sortType); // 정렬 방식
        modelAndView.addObject("page", page);
        modelAndView.addObject("range", range);
        modelAndView.addObject("rangeSize", rangeSize);
        
		
		return modelAndView;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectLocalDelIsOk
	 * @Description : 기관정보 삭제해도 되는지 사용자, 센서, 관수 체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/localDelIsOk.do")
	public HashMap<String, Object> deleteLocalDelIsOk(HttpServletRequest httpServletRequest) throws Exception {
		String localId = httpServletRequest.getParameter("localId"); // 기관ID
		boolean checkResult = true;
		try {
			checkResult = service.deleteLocalDelIsOk(localId);
		} catch(Exception e) {
			checkResult = false;
		}
		HashMap<String, Object> checkCnt = new HashMap<String, Object>();
		checkCnt.put("checkResult", checkResult);
		return checkCnt;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertLocalSave
	 * @Description : 지역 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/localSave.do")
	public HashMap<String, Object> insertLocalSave(HttpServletRequest request) throws Exception {
		/*
		HashMap<String, Object> mod = new HashMap<String, Object>();
		for(int i = 201; i < 500; i++) {
			String localId = service.selectLatestLocalId(); // local_id 자동 채번
			String localNm = request.getParameter("localNm"); // 지역명
			String registOrgId = request.getParameter("registOrgId"); // 기관ID
			String localAddressMain = request.getParameter("localAddressMain"); // 지역 주소 메인
			String localAddressSub = request.getParameter("localAddressSub"); // 지역 주소 서브
			String localNx = request.getParameter("localNx"); // X좌표
			String localNy = request.getParameter("localNy"); // Y좌표
			
			boolean saveResult = false;
			
	        saveResult = service.insertLocalSave(localId, i + "번째 지역", registOrgId, localAddressMain, localAddressSub, localNx, localNy);
	        
		    
		    
			mod.put("saveResult", saveResult);
		}
		*/
		
		String localId = service.selectLatestLocalId(); // local_id 자동 채번
		String localNm = request.getParameter("localNm"); // 지역명
		String registOrgId = request.getParameter("registOrgId"); // 기관ID
		String localAddressMain = request.getParameter("localAddressMain"); // 지역 주소 메인
		String localAddressSub = request.getParameter("localAddressSub"); // 지역 주소 서브
		String localNx = request.getParameter("localNx"); // X좌표
		String localNy = request.getParameter("localNy"); // Y좌표
		
		boolean saveResult = false;
		
        saveResult = service.insertLocalSave(localId, localNm, registOrgId, localAddressMain, localAddressSub, localNx, localNy);
        
	    HashMap<String, Object> mod = new HashMap<String, Object>();
	    
		mod.put("saveResult", saveResult);
		
		return mod;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectLocalModDetail
	 * @Description : 지역 수정조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/localDetail.do")
	public ModelAndView selectLocalDetail(HttpServletRequest httpServletRequest) throws Exception {
		String localId = httpServletRequest.getParameter("localIdParam");
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		
		localVO localModDetail = service.selectLocalModDetail(localId); // 지역 정보 조회
		//List<localVO> localFileList = service.selectLocalFileList(localId); // 지역 파일 조회
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(localId);  // 기관 콤보박스 리스트 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(localModDetail.getOrganizationId());
		
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("local/localDetail"); // view 파일 경로
		
		modelAndView.addObject("localModDetail", localModDetail);
		modelAndView.addObject("orgNmList", orgNmList);
		modelAndView.addObject("localNmList", localNmList);
		modelAndView.addObject("searchingOrgId", searchingOrgId);
		modelAndView.addObject("searchingLocalId", searchingLocalId);
		modelAndView.addObject("sortColumn", sortColumn);
		modelAndView.addObject("sortType", sortType);
		modelAndView.addObject("page", page);
	    modelAndView.addObject("range", range);
	    modelAndView.addObject("rangeSize", rangeSize);
		
		
		return modelAndView;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectLocalModDetail
	 * @Description : 지역 수정조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/localModDetail.do")
	public ModelAndView selectLocalModDetail(HttpServletRequest httpServletRequest) throws Exception {
		String localId = httpServletRequest.getParameter("localIdParam");
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		
		localVO localModDetail = service.selectLocalModDetail(localId); // 지역 정보 조회
		//List<localVO> localFileList = service.selectLocalFileList(localId); // 지역 파일 조회
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(localId);  // 기관 콤보박스 리스트 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(localModDetail.getOrganizationId());
		
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("local/localMod"); // view 파일 경로
		
		modelAndView.addObject("localModDetail", localModDetail);
		modelAndView.addObject("orgNmList", orgNmList);
		modelAndView.addObject("localNmList", localNmList);
		modelAndView.addObject("searchingOrgId", searchingOrgId);
		modelAndView.addObject("searchingLocalId", searchingLocalId);
		modelAndView.addObject("sortColumn", sortColumn);
		modelAndView.addObject("sortType", sortType);
		modelAndView.addObject("page", page);
	    modelAndView.addObject("range", range);
	    modelAndView.addObject("rangeSize", rangeSize);
	    
		return modelAndView;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertLocalMod
	 * @Description : 지역 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/localMod.do")
	public HashMap<String, Object> updateLocalMod(HttpServletRequest httpServletRequest) throws Exception {
		String orgIdMod = httpServletRequest.getParameter("orgIdMod"); // 기관ID
		String localIdMod = httpServletRequest.getParameter("localIdMod"); // 지역ID
		String localNmMod = httpServletRequest.getParameter("localNmMod"); // 지역명
		String localAddressMainMod = httpServletRequest.getParameter("localAddressMainMod"); // 지역 주소 메인
		String localAddressSubMod = httpServletRequest.getParameter("localAddressSubMod"); // 지역 주소 서브
		String localNxMod = httpServletRequest.getParameter("localNxMod"); // X좌표
		String localNyMod = httpServletRequest.getParameter("localNyMod"); // Y좌표
		
		
		boolean modResult = true;
		
			
		try {
			// 업로드 파일이 없으니 내용만 수정
			service.updateLocalModNoFile(orgIdMod, localIdMod, localNmMod, localAddressMainMod, localAddressSubMod, localNxMod, localNyMod);
		} catch(Exception e) {
			modResult = false;
		}
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("modResult", modResult);
		return result;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : sendMail
	 * @Description : 메일 발송
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 * @ 메일을 하루에 500개 넘게 전송하면 메일 전송 제한에 도달했습니다. 오류 메시지 발생 
	 */
	
	@RequestMapping(value="/mail")
	public void sendMail() throws Exception {
	    MimeMessage message = javaMailSender.createMimeMessage();
	    log.setLevel(Level.INFO); // 메일 발송 레벨 세팅
	    
	    try{
	        MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
	        
	        // 1. 메일 수신자 설정
	        //String[] receiveList = {"checkchuljea@naver.com", "chlee084@i-gn.kr"};
	        String[] receiveList = {"checkchuljea@naver.com"};
	        messageHelper.setTo(receiveList);

	        // 2. 메일 제목 설정
	        messageHelper.setSubject("첫번째 성우 메일 제목 테스트");

	        // 3. 메일 내용 설정
	        // HTML 적용됨
	        String content = "첫번째 성우 메일 내용 테스트";
	        messageHelper.setText(content,true);

	        // 4. 메일 전송
	        javaMailSender.send(message);
	    } catch(Exception e){
	    	log.info(e.toString()); // 에러를 콘솔에 출력
	    }
	}
	
	@RequestMapping(value="/localDelValidationCheck.do")
	public HashMap<String, Object> localValidationCheck(HttpServletRequest request) throws Exception {
    	String localIdVal = request.getParameter("localIdVal");
		boolean localDelValidationCheck = service.localDelValidationCheck(localIdVal);
	    HashMap<String, Object> validationResult = new HashMap<String, Object>();
	    validationResult.put("localDelValidationCheck", localDelValidationCheck);
		return validationResult;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteLocal
	 * @Description : 지역 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/localDel.do")
	public ModelAndView deleteLocal(HttpServletRequest httpServletRequest) throws Exception {
		String localIdDel = httpServletRequest.getParameter("localId");
		boolean delResult = true;
		try {
			service.deleteLocal(localIdDel);
		} catch(Exception e) {
			delResult = false;
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("local/localList"); // view 파일 경로
		
		modelAndView.addObject("delResult", delResult);
		
		return modelAndView;
		
	}
	
	@RequestMapping(value="/viewMapHtml")
	public ResponseEntity<Resource> displayViewMapHtml(@RequestParam("filename") String filename) {
		
		Resource resourceHtml = new FileSystemResource(filePath + filename + ".html");

		
		if(!resourceHtml.exists()) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		HttpHeaders header = new HttpHeaders();
		Path pathHtml = null;

		try{
			pathHtml = Paths.get(filePath + filename + ".html");			
			header.add("Content-type", Files.probeContentType(pathHtml));
			
		}catch(IOException e) {
			e.printStackTrace();
		}
				
		return new ResponseEntity<Resource>(resourceHtml, header, HttpStatus.OK);
	}
	
	
	
	/**
	 * @throws Exception 
	 * @Method Name : selectViewMap
	 * @Description : 권한지역 선택 팝업에 데이터 전송 
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/viewMap.do")
	public ModelAndView selectViewMap(HttpServletRequest httpServletRequest) throws Exception {
		String registOrgId = httpServletRequest.getParameter("registOrgId"); // 기관ID
		if(Util.isEmpty(registOrgId))
			registOrgId = "";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("local/viewMap");
		
		
		modelAndView.addObject("registOrgId", registOrgId);
		return modelAndView;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectViewMap
	 * @Description : 권한지역 선택 팝업에 데이터 전송 
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/viewMapLocalXY.do")
	public HashMap<String, Object> selectLocalXY(HttpServletRequest request) throws Exception {
    	String localId = request.getParameter("localId");
		 localVO LocalXYList = service.selectLocalXY(localId);
	    HashMap<String, Object> validationResult = new HashMap<String, Object>();
	    validationResult.put("LocalXYList", LocalXYList);
		return validationResult;
	}
	
	@RequestMapping("/excel.do")
    public ResponseEntity getUsersPointStats(HttpServletRequest httpServletRequest, HttpServletResponse response, boolean excelDownload) throws Exception{
		String orgId = httpServletRequest.getParameter("orgId");
		String localId = httpServletRequest.getParameter("localId");
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingOrgId");  // 지역 콤보박스 검색어
		String personInCharge = httpServletRequest.getParameter("personInCharge"); // 담당자 검색어
		
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		
        return ResponseEntity.ok(service.selectOrgExcel(response, searchingOrgId, searchingLocalId, personInCharge, new Pagination(), sortColumn, sortType));
    }
}
