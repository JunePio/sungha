package com.gn.sungha.sensor;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URLDecoder;
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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
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
import com.gn.sungha.irrigation.IrrigationVO;
import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;
import com.gn.sungha.userMng.UserMngVO;

/**
 * 성하 센서정보 컨트롤러
 * 
 *
 * 
 */

/**
 * @author gn
 *
 */
/**
 * @author gn
 *
 */
@RestController
@RequestMapping(value="/sensor")
public class SensorController {

	@Autowired
	private SensorService service;
	
	@Autowired
	private CommonNmList commonNmList; // 공통 - 기관정보 콤보박스 리스트와 지역 콤보박스 리스트 객체
	
	//@Value("${spring.servlet.multipart.location}")
	private String filePath = "C:\\sensor_file_store\\";
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSeonsorInfoList
	 * @Description : 기관정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorList.do")
	public ModelAndView selectSeonsorInfoList(HttpServletRequest httpServletRequest) throws Exception {
		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		String localId = httpServletRequest.getParameter("localId"); // 지역ID
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		
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
		modelAndView.setViewName("sensor/sensorList"); // view 파일 경로
		Pagination pagination = new Pagination(); // 페이징 객체 생성
		//pagination.setPage(Integer.parseInt(page));
		//pagination.setPage(Integer.parseInt(range));
		//pagination.setPage(Integer.parseInt(rangeSize));
		// 센서정보 개수 조회
		int totalCnt = service.selectSensorInfoListTotalCnt(searchingOrgId, searchingLocalId, searchingType, searchingContent); // 기관정보 리스트 개수 조회
		pagination.pageInfo(Integer.parseInt(page),  Integer.parseInt(range),  totalCnt); // 페이지 처리 메소드에 파라미터 값 입력
		// 센서정보 리스트 조회
		List<SensorVO> sensorInfoList = service.selectSensorInfoList(searchingOrgId, searchingLocalId, pagination, sortColumn, sortType, searchingType, searchingContent);
		for(SensorVO sensorInfo : sensorInfoList) { // 센서 설명이 길이를 초과할 경우 ...으로 표출
			if(sensorInfo.getSensorDetail() != null && sensorInfo.getSensorDetail().length() > 30) {
				sensorInfo.setSensorDetail(sensorInfo.getSensorDetail().substring(0, 30) + "...");
			}
		}
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(searchingOrgId);  // 기관 콤보박스 리스트 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(searchingOrgId); // 지역 콤보박스 리스트 조회
		
        modelAndView.addObject("sensorInfoList", sensorInfoList); // 센서정보 조회 리스트
        modelAndView.addObject("orgNmList", orgNmList);     // 기관정보 콤보박스 리스트
        modelAndView.addObject("localNmList", localNmList); // 지역정보 콤보박스 리스트
        modelAndView.addObject("orgId", orgId);
        modelAndView.addObject("localId", localId);
        modelAndView.addObject("searchingOrgId", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("searchingLocalId", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("searchingType", searchingType); // 센서명 or 센서ID 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색어 리턴
        modelAndView.addObject("pagination", pagination); // 게시판 페이징 정보 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 게시판 헤더 정렬컬럼 정보 리턴
        modelAndView.addObject("sortType", sortType); // 게시판 헤더 정렬타입 정보 리턴
        modelAndView.addObject("idx", idx);
		return modelAndView;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorInfoRegist
	 * @Description : 기관정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorRegist.do")
	public ModelAndView selectSensorInfoRegist(HttpServletRequest httpServletRequest) throws Exception {
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(searchingOrgId);  // 기관 콤보박스 리스트 조회
		String tempOrgId = orgNmList.get(0).getOrganizationId();
		List<localVO> localNmList = commonNmList.selectLocalNmList(tempOrgId); // 지역 콤보박스 리스트 조회
		
		List<IrrigationVO> irrigationComboList = service.selectIrrigationComboList(localNmList.get(0).getLocalId());
		
		HashMap<String, Object> detail = new HashMap<String, Object>();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("sensor/sensorRegist"); // view 파일 경로
		
		modelAndView.addObject("orgNmList", orgNmList);     // 기관정보 콤보박스 리스트
	    modelAndView.addObject("localNmList", localNmList); // 지역정보 콤보박스 리스트
	    modelAndView.addObject("irrigationComboList", irrigationComboList); // 관수ID, 관수명 콤보박스 리스트
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
	 * @Method Name : selectOrgInfoDetail
	 * @Description : 기관정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorDetail.do")
	public ModelAndView selectOrgInfoDetail(HttpServletRequest httpServletRequest) throws Exception {
		String sensorId = httpServletRequest.getParameter("sensorIdParam"); // 센서ID
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		SensorVO sensorInfoDetail = service.selectSensorInfoDetail(sensorId);
		List<SensorVO> sensorReplyList = service.selectSensorReplyList(sensorId);
		
		//File file = new File(filePath + sensorInfoDetail.getUuidName());
		//sensorInfoDetail.setFile(new FileInputStream(file));
		HashMap<String, Object> detail = new HashMap<String, Object>();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("sensor/sensorDetail"); // view 파일 경로
		
		modelAndView.addObject("sensorInfoDetail", sensorInfoDetail);
		modelAndView.addObject("sensorReplyList", sensorReplyList);
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
	@RequestMapping(value="/sensorSave.do")
	public HashMap<String, Object> insertSensorSave(HttpServletRequest request) throws Exception {
		String sensorId = request.getParameter("sensorId"); // 센서ID
		String usimId = request.getParameter("usimId"); // 유심코드
		String sensor = request.getParameter("sensor"); // 센서명
		String organizationId = request.getParameter("organizationId"); // 기관ID
		String localId = request.getParameter("localId"); // 지역ID
		String outYn = request.getParameter("outYn"); // 반출여부
		String sensorDetail = request.getParameter("sensorDetail"); // Y좌표
		String irrigationId = request.getParameter("irrigationId"); // 콤보박스에서 선택된 관수ID
		
        boolean saveResult = false;
        
        saveResult = service.insertSensorSave(sensorId, usimId, sensor, organizationId, localId, outYn, sensorDetail, irrigationId);
        
	    HashMap<String, Object> mod = new HashMap<String, Object>();
		mod.put("saveResult", saveResult);
		return mod;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorModDetail
	 * @Description : 사용자관리 수정조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorModDetail.do")
	public ModelAndView selectSensorModDetail(HttpServletRequest httpServletRequest) throws Exception {
		String sensorId = httpServletRequest.getParameter("sensorIdMod"); // 센서ID
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId");  // 지역 콤보박스 검색어
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		
		SensorVO sensorInfoModDetail = service.selectSensorModDetail(sensorId);
		
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(sensorId);  // 기관 콤보박스 리스트 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(sensorInfoModDetail.getOrganizationId());
		
		List<IrrigationVO> irrigationComboList = service.selectIrrigationComboList(sensorInfoModDetail.getLocalId());
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("sensor/sensorMod"); // view 파일 경로
		
		modelAndView.addObject("sensorInfoModDetail", sensorInfoModDetail);
		modelAndView.addObject("orgNmList", orgNmList);
		modelAndView.addObject("localNmList", localNmList);
		modelAndView.addObject("localNmListSize", localNmList.size());
		modelAndView.addObject("irrigationComboList", irrigationComboList); // 관수ID, 관수명 콤보박스 리스트
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
	 * @Method Name : insertOrgInfoMod
	 * @Description : 사용자관리 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorMod.do")
	public HashMap<String, Object> updateSensorInfoMod(HttpServletRequest httpServletRequest) throws Exception {
		String sensorId = httpServletRequest.getParameter("sensorId"); // 사용자ID
		String sensor = httpServletRequest.getParameter("sensor"); // 사용자명
		String usimId = httpServletRequest.getParameter("usimId"); // 사용자 레벨
		String orgId = httpServletRequest.getParameter("orgId"); // 연락처
		String localId = httpServletRequest.getParameter("localId"); // 이메일
		String sensorDetail = httpServletRequest.getParameter("sensorDetail"); // 기관ID
		String outYn = httpServletRequest.getParameter("outYn"); // 기관ID
		String irrigationId = httpServletRequest.getParameter("irrigationId"); // 관수ID
		
		boolean modResult = true;
		try {
			service.updateSensorInfoMod(sensorId, sensor, usimId, orgId, localId, sensorDetail, outYn, irrigationId);
		} catch(Exception e) {
			modResult = false;
		}
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("modResult", modResult);
		return result;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteSensorInfoDel
	 * @Description : 센서 정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorDel.do")
	public HashMap<String, Object> deleteSensorInfoDel(HttpServletRequest httpServletRequest) throws Exception {
		String sensorId = httpServletRequest.getParameter("sensorId"); // 기관ID
		boolean delResult = true;
		try {
			
			List<SensorVO> sensorReplyList = service.selectSensorReplyList(sensorId);
			
			for(SensorVO sensorReply : sensorReplyList) {
				service.deleteSensorReply(sensorReply.getReplyId());
			}
			
			service.deleteSensorInfoDel(sensorId);
			
		} catch(Exception e) {
			e.printStackTrace();
			delResult = false;
		}
		HashMap<String, Object> modDetail = new HashMap<String, Object>();
		modDetail.put("delResult", delResult);
		return modDetail;
		
	}
	
	@RequestMapping(value="/display.do")
	public ResponseEntity<Resource> display(@RequestParam("filename") String filename) {
		
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
	
	@RequestMapping("/excel.do")
    public ResponseEntity getUsersPointStats(HttpServletRequest httpServletRequest, HttpServletResponse response, boolean excelDownload) throws Exception{
		String searchingOrgId = httpServletRequest.getParameter("searchingOrgId"); // 기관ID
		String searchingLocalId = httpServletRequest.getParameter("searchingLocalId"); // 지역ID
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType"); // 정렬 타입
		
        return ResponseEntity.ok(service.selectSensorExcel(response, searchingOrgId, searchingLocalId, "", new Pagination(), sortColumn, sortType, searchingType, searchingContent));
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
		String sensorId = httpServletRequest.getParameter("sensorId"); // 기관ID
		if(Util.isEmpty(sensorId))
			sensorId = "";
		
		boolean dupCheckResult = service.selectDupCheck(sensorId);
		HashMap<String, Object> list = new HashMap<String, Object>();
		list.put("dupCheckResult", dupCheckResult);
		return list;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertSensorReplySave
	 * @Description : 센서 댓글 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorReplySave.do")
	public HashMap<String, Object> insertSensorReplySave(HttpServletRequest request, MultipartHttpServletRequest req) throws Exception {
		String writerId = request.getParameter("writerId"); // 작성자ID
		String title = request.getParameter("title"); // 제목
		String locationDetail = request.getParameter("locationDetail"); // 센위치설명
		String sensorId = request.getParameter("sensorIdParam"); // 센서ID
        
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
            
            if(multipartFileList.size()>0) { // 첨부파일이 있으면
            	
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
                    saveResult = service.insertSensorReplySave(writerId, title, locationDetail, sensorId);       // 서버에 댓글 정보 저장 먼저 하고
                    int replyId = service.getSensorReplyId(sensorId);                                            // 댓글ID 가져와서
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
            	saveResult = service.insertSensorReplySave(writerId, title, locationDetail, sensorId);       // 댓글 정보 저장
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
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteSensorReply
	 * @Description : 센서 정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorReplyDel.do")
	public HashMap<String, Object> deleteSensorReply(HttpServletRequest httpServletRequest) throws Exception {
		int replyId = Integer.parseInt(httpServletRequest.getParameter("replyId")); // 기관ID
		boolean delResult = true;
		try {
			service.deleteSensorReply(replyId);
			
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
	 * @Method Name : updateSensorReplyMod
	 * @Description : 사용자관리 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorReplyMod.do")
	public HashMap<String, Object> updateSensorReplyMod(HttpServletRequest httpServletRequest, MultipartHttpServletRequest req) throws Exception {
		int replyId = Integer.parseInt(httpServletRequest.getParameter("replyId")); // 댓글ID
		String title = httpServletRequest.getParameter("title"); // 제목
		String locationDetail = httpServletRequest.getParameter("locationDetail"); // 센서위치설명
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
				service.updateSensorReplyMod(replyId, title, locationDetail);
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
			
			service.deleteSensorReplyFile(replyId); // 기존 파일 삭제
			
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
	            
	            List<SensorVO> localFileList = service.selectReplyFileList(replyId);
	            
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
	                    	service.updateSensorReplyFileMod(replyId, finalUuidName, oriFileName, fileSize);
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
				service.updateSensorReplyMod(replyId, title, locationDetail);
			} catch(Exception e) {
				modResult = false;
			}
		}
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("modResult", modResult);
		return result;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSeonsorInfoList
	 * @Description : 기관정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationComboList.do")
	public HashMap<String, Object> selectIrrigationComboList(HttpServletRequest httpServletRequest) throws Exception {
		String localId = httpServletRequest.getParameter("localId"); // 지역ID
		
		if(Util.isEmpty(localId))
			localId = "";
		
		
		// 관수 목록 콤보박스 조회
		List<IrrigationVO> irrigationComboList = service.selectIrrigationComboList(localId);
		
        
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("irrigationComboList", irrigationComboList);
		result.put("irrigationComboListSize", irrigationComboList.size());
		return result;
	}
	
}
