package com.gn.sungha.irrigation;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.gn.sungha.common.CommonNmList;
import com.gn.sungha.common.Pagination;
import com.gn.sungha.common.Util;
import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;
import com.gn.sungha.sensor.SensorVO;


/**
 * 관수 정보 컨트롤러
 * 
 *
 * 
 */

@RestController
@RequestMapping(value="/irrigation")
public class IrrigationController {

	@Autowired
	private IrrigationService service;
	
	@Autowired
	private CommonNmList commonNmList; // 공통 - 기관정보 콤보박스 리스트와 지역 콤보박스 리스트 객체
	
	//@Value("${spring.servlet.multipart.location}")
	private String filePath = "C:\\irrigation_file_store\\";
		
	/**
	 * @throws Exception 
	 * @Method Name : selectIrrigationList
	 * @Description : 관수 정보 리스트 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationList.do")
	public ModelAndView selectIrrigationList(HttpServletRequest httpServletRequest) throws Exception {
		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		String localId = httpServletRequest.getParameter("localId"); // 지역ID
		String searchingOrgId = httpServletRequest.getParameter("orgNm");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("localNm");  // 지역 콤보박스 검색어
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
		if(Util.isEmpty(orgId))
			orgId = "";
		if(Util.isEmpty(localId))
			localId = "";
		if(Util.isEmpty(searchingType))
			searchingType = "";
		if(Util.isEmpty(searchingContent))
			searchingContent = "";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("irrigation/irrigationList"); // view 파일 경로
		Pagination pagination = new Pagination(); // 페이징 객체 생성
		//pagination.setPage(Integer.parseInt(page));
		//pagination.setPage(Integer.parseInt(range));
		//pagination.setPage(Integer.parseInt(rangeSize));
		int totalCnt = service.selectIrrigationListTotalCnt(searchingOrgId, searchingLocalId, searchingType, searchingContent); // 기관정보 리스트 개수 조회
		pagination.pageInfo(Integer.parseInt(page),  Integer.parseInt(range),  totalCnt); // 페이지 처리 메소드에 파라미터 값 입력
		// 기관정보 리스트 조회
		List<IrrigationVO> irrigationList = service.selectIrrigationList(searchingOrgId, searchingLocalId, searchingType, searchingContent, pagination, sortColumn, sortType);
		
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(searchingOrgId);  // 기관 콤보박스 리스트 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(searchingOrgId); // 지역 콤보박스 리스트 조회
		
		
		
        modelAndView.addObject("irrigationList", irrigationList); // 관수정보 조회 리스트
        modelAndView.addObject("orgNmList", orgNmList);     // 기관정보 콤보박스 리스트
        modelAndView.addObject("localNmList", localNmList); // 지역정보 콤보박스 리스트
        modelAndView.addObject("orgId", orgId);
        modelAndView.addObject("localId", localId);
        modelAndView.addObject("orgNm", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("localNm", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("searchingType", searchingType); // 검색 타입 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색 내용 리턴
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
	 * @Method Name : selectIrrigationRegist
	 * @Description : 관수 등록 페이지 불러오기
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationRegist.do")
	public ModelAndView selectIrrigationRegist(HttpServletRequest httpServletRequest) throws Exception {
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingOrgId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 검색 타입
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색 내용
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		
		String irrigationId = httpServletRequest.getParameter("irrigationId"); // 관수ID
		
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(searchingOrgId);  // 기관 콤보박스 리스트 조회
		String tempOrgId = orgNmList.get(0).getOrganizationId();
		List<localVO> localNmList = commonNmList.selectLocalNmList(tempOrgId); // 지역 콤보박스 리스트 조회
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("irrigation/irrigationRegist"); // view 파일 경로
		
		modelAndView.addObject("orgNmList", orgNmList);     // 기관정보 콤보박스 리스트
        modelAndView.addObject("localNmList", localNmList); // 지역정보 콤보박스 리스트
        modelAndView.addObject("searchingOrgId", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("searchingLocalId", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("searchingType", searchingType); // 검색 타입 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색 내용 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 게시판 헤더 정렬컬럼 정보 리턴
        modelAndView.addObject("sortType", sortType); // 게시판 헤더 정렬타입 정보 리턴
        
		return modelAndView;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectIrrigationDetail
	 * @Description : 관수정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationDetail.do")
	public ModelAndView selectIrrigationDetail(HttpServletRequest httpServletRequest) throws Exception {
		String irrigationId = httpServletRequest.getParameter("irrigationIdParam"); // 센서ID
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		
		IrrigationVO irrigationInfoDetail = service.selectIrrigationDetail(irrigationId);
		List<IrrigationVO> irrigationReplyList = service.selectIrrigationReplyList(irrigationId);
		//List<IrrigationVO> irrigationHistoryList = service.selectIrrigationHistoryList(irrigationId);
		
		//File file = new File(filePath + irrigationInfoDetail.getUuidName());
		//irrigationInfoDetail.setFile(new FileInputStream(file));
		HashMap<String, Object> detail = new HashMap<String, Object>();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("irrigation/irrigationDetail"); // view 파일 경로
		
		modelAndView.addObject("irrigationInfoDetail", irrigationInfoDetail);
		//modelAndView.addObject("irrigationHistoryList", irrigationHistoryList);
		modelAndView.addObject("irrigationReplyList", irrigationReplyList);
		modelAndView.addObject("searchingOrgId", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("searchingLocalId", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("searchingType", searchingType); // 센서명 or 센서ID 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색어 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 정렬 컬럼
        modelAndView.addObject("sortType", sortType); // 정렬 방식
        
		return modelAndView;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertSensorSave
	 * @Description : 지역 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationSave.do")
	public HashMap<String, Object> insertIrrigationSave(HttpServletRequest request) throws Exception {
		String irrigationId = request.getParameter("irrigationId"); // 관수ID
		String irrigation = request.getParameter("irrigation"); // 관수명
		String irrigationState = request.getParameter("irrigationState"); // 관수상태	
		String organizationId = request.getParameter("organizationId"); // 기관ID
		String localId = request.getParameter("localId"); // 지역ID
		String irrigationDetail = request.getParameter("irrigationDetail"); // 관수위치설명
		
        boolean saveResult = false;
        
        saveResult = service.insertIrrigationSave(irrigationId, irrigation, irrigationState, organizationId, localId, irrigationDetail);
        
	    HashMap<String, Object> mod = new HashMap<String, Object>();
		mod.put("saveResult", saveResult);
		return mod;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateIrrigationStateOn
	 * @Description : 
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationStateChange.do")
	public HashMap<String, Object> updateIrrigationStateChange(HttpServletRequest request) throws Exception {
		String irrigationId = request.getParameter("irrigationId"); // 관수ID
		String state = request.getParameter("state"); // 관수ID
		String streamTime = request.getParameter("streamTime"); // 유량투입시간
		String userId = request.getParameter("userId"); // 수정자ID
		String irrigationDetail = request.getParameter("irrigationDetail"); // 관수위치설명
		
		
        boolean saveResult = false;
        
        saveResult = service.updateIrrigationStateChange(irrigationId, state, streamTime, userId, irrigationDetail);
        
	    HashMap<String, Object> mod = new HashMap<String, Object>();
		mod.put("saveResult", saveResult);
		return mod;
	}
	
	@RequestMapping("/excel.do")
    public ResponseEntity selectIrrigationExcel(HttpServletRequest httpServletRequest, HttpServletResponse response, boolean excelDownload) throws Exception{
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId"); // 기관ID
		String searchingLocalId = httpServletRequest.getParameter("localNm"); // 지역ID
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType"); // 정렬 타입
		
        return ResponseEntity.ok(service.selectIrrigationExcel(response, searchingOrgId, searchingLocalId, "", new Pagination(), sortColumn, sortType, searchingType, searchingContent));
    }

	
	/**
	 * @throws Exception 
	 * @Method Name : selectIrrigationDupCheck
	 * @Description : 관수아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationDupCheck.do")
	public HashMap<String, Object> selectIrrigationDupCheck(HttpServletRequest httpServletRequest) throws Exception {
		String irrigationId = httpServletRequest.getParameter("irrigationId"); // 기관ID
		if(Util.isEmpty(irrigationId))
			irrigationId = "";
		
		boolean dupCheckResult = service.selectDupCheck(irrigationId);
		HashMap<String, Object> list = new HashMap<String, Object>();
		list.put("dupCheckResult", dupCheckResult);
		return list;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectDupCheck
	 * @Description : 관수아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.23  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/dupCheck.do")
	public HashMap<String, Object> selectDupCheck(HttpServletRequest httpServletRequest) throws Exception {
		String irrigationId = httpServletRequest.getParameter("irrigationId");
		if(Util.isEmpty(irrigationId))
			irrigationId = "";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("irrigationList");
		boolean dupCheckResult = service.selectDupCheck(irrigationId);
		HashMap<String, Object> list = new HashMap<String, Object>();
		list.put("dupCheckResult", dupCheckResult);
		return list;
	}

	/**
	 * @throws Exception 
	 * @Method Name : selectIrrigationModDetail
	 * @Description : 사용자관리 수정조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationModDetail.do")
	public ModelAndView selectIrrigationModDetail(HttpServletRequest httpServletRequest) throws Exception {
		String irrigationId = httpServletRequest.getParameter("irrigationIdMod"); // 관수ID
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 관수명 or 관수ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		
		IrrigationVO irrigationInfoModDetail = service.selectIrrigationDetail(irrigationId);
		
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(searchingOrgId);  // 기관 콤보박스 리스트 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(irrigationInfoModDetail.getOrganizationId());
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("irrigation/irrigationMod"); // view 파일 경로
		
		modelAndView.addObject("irrigationInfoDetail", irrigationInfoModDetail);
		modelAndView.addObject("orgNmList", orgNmList);
		modelAndView.addObject("localNmList", localNmList);
		modelAndView.addObject("localNmListSize", localNmList.size());
		modelAndView.addObject("searchingOrgId", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("searchingLocalId", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("searchingType", searchingType); // 관수명 or 관수ID 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색어 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 정렬 컬럼
        modelAndView.addObject("sortType", sortType); // 정렬 방식
        
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
	@RequestMapping(value="/irrigationMod.do")
	public HashMap<String, Object> updateIrrigationInfoMod(HttpServletRequest request) throws Exception {
		String irrigationId = request.getParameter("irrigationId"); // 관수ID
		String irrigation = request.getParameter("irrigation"); // 관수명
		String irrigationState = request.getParameter("irrigationState"); // 관수상태	
		String organizationId = request.getParameter("organizationId"); // 기관ID
		String localId = request.getParameter("localId"); // 지역ID
		String irrigationDetail = request.getParameter("irrigationDetail"); // 관수위치설명
		
		boolean modResult = true;
		try {
			service.updateIrrigationInfoMod(irrigationId, irrigation, irrigationState, organizationId, localId, irrigationDetail);
		} catch(Exception e) {
			modResult = false;
		}
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("modResult", modResult);
		return result;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteIrrigationInfoDel
	 * @Description : 관수 정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationDel.do")
	public HashMap<String, Object> deleteIrrigationInfoDel(HttpServletRequest httpServletRequest) throws Exception {
		String irrigationId = httpServletRequest.getParameter("irrigationId"); // 기관ID
		boolean delResult = true;
		try {
			
			List<IrrigationVO> irrigationReplyList = service.selectIrrigationReplyList(irrigationId);
			
			for(IrrigationVO irrigationReply : irrigationReplyList) {
				service.deleteIrrigationReply(irrigationReply.getReplyId());
			}
			
			service.deleteIrrigationInfoDel(irrigationId);
			
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
	 * @Method Name : insertIrrigationReplySave
	 * @Description : 관수 댓글 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationReplySave.do")
	public HashMap<String, Object> insertIrrigationReplySave(HttpServletRequest request, MultipartHttpServletRequest req) throws Exception {
		String writerId = request.getParameter("writerId"); // 작성자ID
		String title = request.getParameter("title"); // 제목
		String locationDetail = request.getParameter("locationDetail"); // 센위치설명
		String irrigationId = request.getParameter("irrigationIdParam"); // 관수ID
        
        String uuid = "";
		String finalUuidName = "";
		String oriFileName = "";
		String imgExt = null;
		String htmlExt = null;
		long temp = 0;
		String fileSize = "";
		boolean saveResult = false;
		boolean fileSaveResult = false;
		
        List<MultipartFile> multipartFileList = new ArrayList<>();
        try{
            MultiValueMap<String, MultipartFile> files = req.getMultiFileMap();
            for (Map.Entry<String, List<MultipartFile>> entry : files.entrySet()) {
                List<MultipartFile> fileList = entry.getValue();
                for (MultipartFile file : fileList) {
                    if (file.isEmpty()) continue;
                    multipartFileList.add(file);
                }
            }
            
            if(multipartFileList.size()>0) { // 첨부파일이 있다면
            	
            	uuid = UUID.randomUUID().toString(); // 서버에 저장할 유니크한 파일이름 생성
                for(MultipartFile file: multipartFileList) {
                	oriFileName = file.getOriginalFilename(); // 원본파일 이름 저장
                	temp = file.getSize() / 1024; // 파일 사이즈를 KB로 환산
                	fileSize = String.valueOf(temp);
                	String ext = oriFileName.substring(oriFileName.lastIndexOf(".") + 1); // 확장자 저장
                	finalUuidName = uuid + "." + ext;
                	File folder = new File(filePath);
                	if (!folder.exists()) {
                		try{
                		    folder.mkdir(); //폴더 생성합니다.
                	        } 
                	        catch(Exception e){
                		    e.getStackTrace();
                		}        
                    }
                	
                    file.transferTo(new File(filePath + File.separator + finalUuidName)); // 서버에 파일 저장
                    saveResult = service.insertIrrigationReplySave(writerId, title, locationDetail, irrigationId);       // 서버에 댓글 정보 저장 먼저 하고
                    int replyId = service.getIrrigationReplyId(irrigationId);                                            // 댓글ID 가져와서
                    fileSaveResult = service.insertReplyFileSave(replyId, finalUuidName, oriFileName, fileSize); // 파일에 같이 저장 
                    
                }
                
                /*
                File inFile = new File(filePath + File.separator + uuid + "." + htmlExt);
                String resultLine = "";
                if(inFile.exists()) {
                	BufferedReader ib = new BufferedReader(new FileReader(inFile));
                	String line = "";
                	
                	while((line = ib.readLine()) != null) {
                		if(line.indexOf("<img src=") >= 0) {
                			String findImgNameResult = "";
                			String findImgName[] = line.split("\"", 3);
                			findImgName[1] = "\"/local/viewMapJpg?filename=" + uuid + "\"";
                			findImgNameResult = findImgNameResult + findImgName[0];
                			findImgNameResult = findImgNameResult + findImgName[1];
                			findImgNameResult = findImgNameResult + findImgName[2];
                			resultLine = resultLine + findImgNameResult + "\n";
                		} else {
                			resultLine = resultLine + line + "\n";
                		}
                		
                	}
                	
                	ib.close();
                	
                	BufferedWriter iw = new BufferedWriter(new FileWriter(inFile));
                	
                	iw.write(resultLine, 0, resultLine.length());
                	iw.flush();
                	iw.close();
                }
                */
            } else { // 첨부파일이 없으면
            	saveResult = service.insertIrrigationReplySave(writerId, title, locationDetail, irrigationId);       // 댓글 정보 저장
            	fileSaveResult = true;
            }
            }catch (Exception e){
            e.printStackTrace();
        }
        
        HashMap<String, Object> mod = new HashMap<String, Object>();
		
        
        if(saveResult == false || fileSaveResult == false) {
        	mod.put("saveResult", false);
        } else {
        	mod.put("saveResult", true);
        }
	    
		return mod;
	}
	
	@RequestMapping(value="/display.do")
	public ResponseEntity<Resource> display(@RequestParam("filename") String filename) {
		
		if(Util.isEmpty(filename)) {
			return null;
		} else {
			Resource resource = new FileSystemResource(filePath + filename);
			
			if(!resource.exists())
				return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
			HttpHeaders header = new HttpHeaders();
			Path path = null;
			try{
				path = Paths.get(filePath + filename);
				header.add("Content-type", Files.probeContentType(path));
			}catch(IOException e) {
				e.printStackTrace();
			}
			return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
		}
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteIrrigationReply
	 * @Description : 관수 정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationReplyDel.do")
	public HashMap<String, Object> deleteIrrigationReply(HttpServletRequest httpServletRequest) throws Exception {
		int replyId = Integer.parseInt(httpServletRequest.getParameter("replyId")); // 기관ID
		boolean delResult = true;
		try {
			service.deleteIrrigationReply(replyId);
			
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
	 * @Method Name : updateIrrigationReplyMod
	 * @Description : 사용자관리 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationReplyMod.do")
	public HashMap<String, Object> updateIrrigationReplyMod(HttpServletRequest httpServletRequest, MultipartHttpServletRequest req) throws Exception {
		int replyId = Integer.parseInt(httpServletRequest.getParameter("replyId")); // 댓글ID
		String title = httpServletRequest.getParameter("title"); // 제목
		String locationDetail = httpServletRequest.getParameter("locationDetail"); // 관수위치설명
		String fileUpload = httpServletRequest.getParameter("fileUpload"); // 업로드 파일
		
		String uuid = "";
		String finalUuidName = "";
		String oriFileName = "";
		boolean modResult = true;
		long temp = 0;
		String fileSize = "";
		String imgExt = "";
		String htmlExt = "";
		
		
		if(fileUpload.length() < 1) { // 업로드할 파일이 없는 경우
			
			modResult = true;
			try {
				// 업로드 파일이 없으니 내용만 수정
				service.updateIrrigationReplyMod(replyId, title, locationDetail);
			} catch(Exception e) {
				modResult = false;
			}
		}/* else if("YES".equals(deleteViewMapIsChecked)) {
			
			String srcFileName = null;
			List<String> uuidNames = new ArrayList<String>();
			
	        try{
	        	uuidNames = service.selectOriFileName(localIdMod);
	        	
	        	for(String uuidName : uuidNames) {
	        		srcFileName = URLDecoder.decode(uuidName,"UTF-8");
		            //UUID가 포함된 파일이름을 디코딩해줍니다.
		            File file = new File(filePath +File.separator + srcFileName);
		            boolean result = file.delete(); // 등록된 조감도 삭제
		            
		            File thumbnail = new File(file.getParent(),"s_"+file.getName());
		            //getParent() - 현재 File 객체가 나태내는 파일의 디렉토리의 부모 디렉토리의 이름 을 String으로 리턴해준다.
		            result = thumbnail.delete(); // 등록된 조감도 삭제
		            
		            uuid = ""; // UUID 초기화
		            oriFileName = ""; // 원본 파일 이름 초기화
		            fileSize = ""; // 파일 사이즈 초기화
	        	}
	            
	        	
	            // 업로드할 파일 정보를 포함해서 내용 수정
				service.updateLocalModFileDel(orgIdMod, localIdMod, localNmMod, localAddressMainMod, localAddressSubMod, localNxMod, localNyMod);
	            modResult = true;
	            
	        }catch (Exception e){
	            e.printStackTrace();
	            modResult = false;
	        }
			
		}*/ else { // 업로드할 파일이 있는 경우
			
			service.deleteIrrigationReplyFile(replyId); // 기존 파일 삭제
			
			List<MultipartFile> multipartFileList = new ArrayList<>();
	        try{
	            MultiValueMap<String, MultipartFile> files = req.getMultiFileMap();
	            for (Map.Entry<String, List<MultipartFile>> entry : files.entrySet()) {
	                List<MultipartFile> fileList = entry.getValue();
	                for (MultipartFile file : fileList) {
	                    if (file.isEmpty()) continue;
	                    multipartFileList.add(file);
	                }
	            }
	            
	            List<IrrigationVO> localFileList = service.selectReplyFileList(replyId);
	            
	            if(multipartFileList.size()>0) {
	            	uuid = UUID.randomUUID().toString();
	                for(MultipartFile file: multipartFileList) {
	                	oriFileName = file.getOriginalFilename();
	                	temp = file.getSize() / 1024; // 파일 사이즈를 구해서 1024로 나누어 KB를 구한다
	                	fileSize = String.valueOf(temp);
	                	String ext = oriFileName.substring(oriFileName.lastIndexOf(".") + 1); // 확장자를 구한다.
	                	finalUuidName = uuid + "." + ext;
	                    file.transferTo(new File(filePath + File.separator + finalUuidName));
	                    
	                    if(localFileList.size() > 0) {
	                    	service.updateIrrigationReplyFileMod(replyId, finalUuidName, oriFileName, fileSize);
	                    } else {
	                    	service.insertReplyFileSave(replyId, finalUuidName, oriFileName, fileSize);
	                    }
	                }
	                
	                
	                /*
	                if(!"".equals(htmlExt)) {
		                File inFile = new File(filePath + File.separator + uuid + "." + htmlExt);
		                String resultLine = "";
		                if(inFile.exists()) {
		                	BufferedReader ib = new BufferedReader(new FileReader(inFile));
		                	String line = null;
		                	
		                	while((line = ib.readLine()) != null) {
		                		if(line.indexOf("<img src=") >= 0) {
		                			String findImgNameResult = "";
		                			String findImgName[] = line.split("\"", 3);
		                			findImgName[1] = "\"/local/viewMapJpg?filename=" + uuid + "\"";
		                			findImgNameResult = findImgNameResult + findImgName[0];
		                			findImgNameResult = findImgNameResult + findImgName[1];
		                			findImgNameResult = findImgNameResult + findImgName[2];
		                			resultLine = resultLine + findImgNameResult + "\n";
		                		} else {
		                			resultLine = resultLine + line + "\n";
		                		}
		                		
		                	}
		                	
		                	ib.close();
		                	
		                	BufferedWriter iw = new BufferedWriter(new FileWriter(inFile));
		                	
		                	iw.write(resultLine, 0, resultLine.length());
		                	iw.flush();
		                	iw.close();
		                }
	                }
	                */
	                
	                
	            }
	            }catch (Exception e){
	            e.printStackTrace();
	        }
			
			modResult = true;
			try {
				// 업로드할 파일 정보를 포함해서 내용 수정
				service.updateIrrigationReplyMod(replyId, title, locationDetail);
			} catch(Exception e) {
				modResult = false;
			}
		}
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("modResult", modResult);
		return result;
	}
	
}
