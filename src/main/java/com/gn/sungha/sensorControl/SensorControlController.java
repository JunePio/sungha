package com.gn.sungha.sensorControl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gn.sungha.common.CommonNmList;
import com.gn.sungha.common.Pagination;
import com.gn.sungha.common.Util;
import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;
import com.gn.sungha.sensorControl.SensorControlService;
import com.gn.sungha.sensorControl.SensorControlVO;

/**
 * 성하 센서정보 컨트롤러
 * 
 *
 *  
 */

@RestController
@RequestMapping(value="/sensorControl")
public class SensorControlController {

	@Autowired
	private SensorControlService service;
	
	@Autowired
	private CommonNmList commonNmList; // 공통 - 기관정보 콤보박스 리스트와 지역 콤보박스 리스트 객체
	
	//@Value("${spring.servlet.multipart.location}")
	private String filePath = "C:\\sensorControl_file_store\\";;

	private final static Logger log = Logger.getGlobal(); // 메일 발송시 에러 로그 체크
	
	@Autowired
	private JavaMailSender javaMailSender; // 메일 발송 객체
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSeonsorControlList
	 * @Description : 센서 설정 리스트 조회
	 * @Modification Controlrmation
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorControlList.do")
	public ModelAndView selectSeonsorControlList(HttpServletRequest httpServletRequest) throws Exception {
		String orgId = httpServletRequest.getParameter("orgId"); // 기관ID
		String localId = httpServletRequest.getParameter("localId"); // 지역ID
		String searchingOrgId = httpServletRequest.getParameter("orgNm");      // 기관 콤보박스 검색어
		String searchingLocalId = httpServletRequest.getParameter("localNm");  // 지역 콤보박스 검색어
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
		modelAndView.setViewName("sensorControl/sensorControlList"); // view 파일 경로
		Pagination pagination = new Pagination(); // 페이징 객체 생성
		//pagination.setPage(Integer.parseInt(page));
		//pagination.setPage(Integer.parseInt(range));
		//pagination.setPage(Integer.parseInt(rangeSize));
		// 센서정보 개수 조회
		int totalCnt = service.selectSensorControlListTotalCnt(searchingOrgId, searchingLocalId, searchingType, searchingContent); // 기관정보 리스트 개수 조회
		pagination.pageInfo(Integer.parseInt(page),  Integer.parseInt(range),  totalCnt); // 페이지 처리 메소드에 파라미터 값 입력
		// 센서정보 리스트 조회
		List<SensorControlVO> sensorControlList = service.selectSensorControlList(searchingOrgId, searchingLocalId, pagination, sortColumn, sortType, searchingType, searchingContent);
		
		List<organizationInfoVO> orgNmList = commonNmList.selectOrgNmList(searchingOrgId);  // 기관 콤보박스 리스트 조회
		List<localVO> localNmList = commonNmList.selectLocalNmList(searchingOrgId); // 지역 콤보박스 리스트 조회
		
        modelAndView.addObject("sensorControlList", sensorControlList); // 센서정보 조회 리스트
        modelAndView.addObject("orgNmList", orgNmList);     // 기관정보 콤보박스 리스트
        modelAndView.addObject("localNmList", localNmList); // 지역정보 콤보박스 리스트
        modelAndView.addObject("orgId", orgId);
        modelAndView.addObject("localId", localId);
        modelAndView.addObject("orgNm", searchingOrgId);     // 기관 콤보박스 검색어 리턴
        modelAndView.addObject("localNm", searchingLocalId); // 지역 콤보박스 검색어 리턴
        modelAndView.addObject("searchingType", searchingType); // 센서명 or 센서ID 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색어 리턴
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
	 * @Method Name : selectOrgControlDetail
	 * @Description : 기관정보 상세조회
	 * @Modification Controlrmation
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorControlDetail.do")
	public ModelAndView selectOrgControlDetail(HttpServletRequest httpServletRequest) throws Exception {
		String sensorId = httpServletRequest.getParameter("sensorIdParam"); // 센서ID
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		
		SensorControlVO sensorControlDetail = service.selectSensorControlDetail(sensorId);
		//File file = new File(filePath + sensorControlDetail.getUuidName());
		//sensorControlDetail.setFile(new FileInputStream(file));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("sensorControl/sensorControlDetail"); // view 파일 경로
		
		modelAndView.addObject("sensorControlDetail", sensorControlDetail);
		modelAndView.addObject("page", page);
        modelAndView.addObject("range", range);
        modelAndView.addObject("rangeSize", rangeSize);
        
		return modelAndView;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertSensorSave
	 * @Description : 지역 저장
	 * @Modification Controlrmation
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorControlSave.do")
	public HashMap<String, Object> insertSensorSave(HttpServletRequest request) throws Exception {
		String sensorId = request.getParameter("sensorId"); // 지역명
		String chipId = request.getParameter("chipId"); // 기관ID
		String sensor = request.getParameter("sensor"); // 지역 주소 메인
		String organizationId = request.getParameter("organizationId"); // 지역 주소 서브
		String localId = request.getParameter("localId"); // X좌표
		String sensorDetail = request.getParameter("sensorDetail"); // Y좌표
		
        boolean saveResult = false;
        
        saveResult = service.insertSensorSave(sensorId, chipId, sensor, organizationId, localId, sensorDetail);
        
	    HashMap<String, Object> mod = new HashMap<String, Object>();
		mod.put("saveResult", saveResult);
		return mod;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorModDetail
	 * @Description : 사용자관리 수정조회
	 * @Modification Controlrmation
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorControlModDetail.do")
	public HashMap<String, Object> selectSensorModDetail(HttpServletRequest httpServletRequest) throws Exception {
		String sensorId = httpServletRequest.getParameter("sensorId"); // 센서ID
		SensorControlVO sensorControlModDetail = service.selectSensorModDetail(sensorId);
		HashMap<String, Object> modDetail = new HashMap<String, Object>();
		modDetail.put("sensorControlModDetail", sensorControlModDetail);
		return modDetail;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateSensorControlMod
	 * @Description : 센서 설정 수정
	 * @Modification Controlrmation
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.20  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorControlMod.do")
	public HashMap<String, Object> updateSensorControlMod(HttpServletRequest httpServletRequest) throws Exception {
		String sensorId = httpServletRequest.getParameter("sensorId"); // 센서ID
		String alarmYn = httpServletRequest.getParameter("alarmYn"); // 알람 여부
		String num = httpServletRequest.getParameter("num"); // 순번
		
		String batteryMin = httpServletRequest.getParameter("batteryMin"); // 배터리 최저값
		String batteryMax = httpServletRequest.getParameter("batteryMax"); // 배터리 최고값
		String temperatureMin = httpServletRequest.getParameter("temperatureMin"); // 온도 최저값
		String temperatureMax = httpServletRequest.getParameter("temperatureMax"); // 온더 최고값
		String humidityMin = httpServletRequest.getParameter("humidityMin"); // 습도 최저값
		String humidityMax = httpServletRequest.getParameter("humidityMax"); // 습도 최고값		
		String pHMin = httpServletRequest.getParameter("pHMin"); // pH 최저값
		String pHMax = httpServletRequest.getParameter("pHMax"); // pH 최고값
		String ECMin = httpServletRequest.getParameter("ECMin"); // EC 최저값
		String ECMax = httpServletRequest.getParameter("ECMax"); // EC 최고값
		String NMin = httpServletRequest.getParameter("NMin"); // N 최저값
		String NMax = httpServletRequest.getParameter("NMax"); // N 최고값
		String PMin = httpServletRequest.getParameter("PMin"); // P 최저값
		String PMax = httpServletRequest.getParameter("PMax"); // P 최고값
		String KMin = httpServletRequest.getParameter("KMin"); // K 최저값
		String KMax = httpServletRequest.getParameter("KMax"); // K 최고값
		
		boolean modResult = true;
		try {
			service.updateSensorControlMod(sensorId, alarmYn, num, batteryMin, batteryMax, temperatureMin, temperatureMax, humidityMin, humidityMax, pHMin, pHMax, ECMin, ECMax,
					NMin, NMax, PMin, PMax, KMin, KMax);
		} catch(Exception e) {
			modResult = false;
		}
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("modResult", modResult);
		return result;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOrgControlDel
	 * @Description : 기관정보 삭제
	 * @Modification Controlrmation
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/sensorControlDel.do")
	public HashMap<String, Object> deleteSensorControlDel(HttpServletRequest httpServletRequest) throws Exception {
		String sensorId = httpServletRequest.getParameter("sensorId"); // 기관ID
		boolean delResult = true;
		try {
			service.deleteSensorControlDel(sensorId);
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
		List<SensorControlVO> sensorControls = service.selectSensorControlDetailForMail(); // 센서 설정 조회
		MimeMessage message = javaMailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		String content = "";
		
		 // 1. 메일 수신자 설정
        //String[] receiveList = {"checkchuljea@naver.com", "seun1986@i-gn.kr", "chlee084@i-gn.kr"};
        String[] receiveList = {"checkchuljea@naver.com"};
        messageHelper.setTo(receiveList);

        // 2. 메일 제목 설정
        messageHelper.setSubject("센서 계측값 확인 알림!!!");
        log.setLevel(Level.INFO); // 메일 발송 레벨 세팅
        
        int i = 0;
        
		for(SensorControlVO sensorControl : sensorControls) {
	    	String sensorId = sensorControl.getSensorId();
	    	SensorControlVO sensor = service.selectSensorDetailForMail(sensorId);
	    	if("N".equals(sensorControl.getAlarmYn()) || "".equals(sensorControl.getAlarmYn())) { // 알람 설정이 OFF나 NULL로 되어 있으면 메일 발송하지 않는다.
	    		continue;
	    	}
	    	
	    	content = content + "<p><p><h1>기관명 : (" + sensorControls.get(i).getOrganization() + ")</h1>";
	        content = content + "<h1>지역명 : (" + sensorControls.get(i).getLocal() + ")</h1>";
	    	
	    	try{
	    		
		        // 3. 메일 내용 설정
		        // HTML 적용됨
	    		
		        content = content + "<h2>센서명 : (" + sensorControl.getSensor() + ") 센서 계측값 확인 알림</h2>디바이스에서 계측한 정보에 대하여 확인 안내드립니다.<p><p>";
		        content = content + "<table border='1'>"
					        		+ "<th>항목</th>"
					        		+ "<th>설정 값</th>"
					        		+ "<th>계측 값</th>"
					        		+ "<th>항목</th>"
					        		+ "<th>설정 값</th>"
					        		+ "<th>계측 값</th>"
					        		+ "<tr>";
		        
		        // 배터리
		        if(Float.parseFloat(sensor.getBatcaprema()) < Float.parseFloat(sensorControl.getBatcapremaValueMin()) || Float.parseFloat(sensor.getBatcaprema()) > Float.parseFloat(sensorControl.getBatcapremaValueMax())) {
		        	content = content   + "		<td style='background-color:pink;'>"
						        		+ "			<span>배터리(%)</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensorControl.getBatcapremaValueMin() + "~" + sensorControl.getBatcapremaValueMax() + "%</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensor.getBatcaprema() + "%</span>"
						        		+ "		</td>";
		        } else {
		        	content = content   + "		<td>"
						        		+ "			<span>배터리(%)</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensorControl.getBatcapremaValueMin() + "~" + sensorControl.getBatcapremaValueMax() + "%</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensor.getBatcaprema() + "%</span>"
						        		+ "		</td>";
		        }
				
		        // 온도
		        if(Float.parseFloat(sensor.getTemp()) < Float.parseFloat(sensorControl.getTempValueMin()) || Float.parseFloat(sensor.getTemp()) > Float.parseFloat(sensorControl.getTempValueMax())) {
		        	content = content	+ "		<td style='background-color:pink;'>"
						        		+ "			<span>온도(ºC)</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensorControl.getTempValueMin() + "~" + sensorControl.getTempValueMax() + "ºC</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensor.getTemp() + "ºC</span>"
						        		+ "		</td>";
		        } else {
		        	content = content	+ "		<td>"
						        		+ "			<span>온도(ºC)</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensorControl.getTempValueMin() + "~" + sensorControl.getTempValueMax() + "ºC</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensor.getTemp() + "ºC</span>"
						        		+ "		</td>";
		        }
				
				content = content	+ "</tr>"
					        		+ "<tr>";
				
				// 습도
				if(Float.parseFloat(sensor.getHumi()) < Float.parseFloat(sensorControl.getHumiValueMin()) || Float.parseFloat(sensor.getHumi()) > Float.parseFloat(sensorControl.getHumiValueMax())) {
					content = content   + "		<td style='background-color:pink;'>"
						        		+ "			<span>습도(%)</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensorControl.getHumiValueMin() + "~" + sensorControl.getHumiValueMax() + "%</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensor.getHumi() + "%</span>"
						        		+ "		</td>";
				} else {
					content = content   + "		<td>"
						        		+ "			<span>습도(%)</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensorControl.getHumiValueMin() + "~" + sensorControl.getHumiValueMax() + "%</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensor.getHumi() + "%</span>"
						        		+ "		</td>";
				}
				
				// pH
				if(Float.parseFloat(sensor.getPh()) < Float.parseFloat(sensorControl.getPhValueMin()) || Float.parseFloat(sensor.getPh()) > Float.parseFloat(sensorControl.getPhValueMax())) {
					content = content   + "		<td style='background-color:pink;'>"
						        		+ "			<span>PH</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensorControl.getPhValueMin() + "~" + sensorControl.getPhValueMax() + "PH</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensor.getPh() + "PH</span>"
						        		+ "		</td>";
				} else {
					content = content   + "		<td>"
						        		+ "			<span>PH</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensorControl.getPhValueMin() + "~" + sensorControl.getPhValueMax() + "PH</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensor.getPh() + "PH</span>"
						        		+ "		</td>";
				}
				
				
				content = content 	+ "</tr>"
					        		+ "<tr>";
				
				// EC
				if(Float.parseFloat(sensor.getConduc()) < Float.parseFloat(sensorControl.getConducValueMin()) || Float.parseFloat(sensor.getConduc()) > Float.parseFloat(sensorControl.getConducValueMax())) {
					content = content	+ "		<td style='background-color:pink;'>"
						        		+ "			<span>EC (ds/m)</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensorControl.getConducValueMin() + "~" + sensorControl.getConducValueMax() + "ds/m</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensor.getConduc() + " ds/m</span>"
						        		+ "		</td>";
				} else {
					content = content	+ "		<td>"
						        		+ "			<span>EC (ds/m)</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensorControl.getConducValueMin() + "~" + sensorControl.getConducValueMax() + "ds/m</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensor.getConduc() + " ds/m</span>"
						        		+ "		</td>";
				}
				
				// N
				if(Float.parseFloat(sensor.getNitro()) < Float.parseFloat(sensorControl.getNitroValueMin()) || Float.parseFloat(sensor.getNitro()) > Float.parseFloat(sensorControl.getNitroValueMax())) {
					content = content	+ "		<td style='background-color:pink;'>"
						        		+ "			<span>N (mg/kg)</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensorControl.getNitroValueMin() + "~" + sensorControl.getNitroValueMax() + " mg/kg</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensor.getNitro() + " mg/kg</span>"
						        		+ "		</td>";
				} else {
					content = content	+ "		<td>"
						        		+ "			<span>N (mg/kg)</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensorControl.getNitroValueMin() + "~" + sensorControl.getNitroValueMax() + " mg/kg</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensor.getNitro() + " mg/kg</span>"
						        		+ "		</td>";
				}
				
				content = content   + "</tr>"
					        		+ "<tr>";
				
				// K
				if(Float.parseFloat(sensor.getPota()) < Float.parseFloat(sensorControl.getPotaValueMin()) || Float.parseFloat(sensor.getPota()) > Float.parseFloat(sensorControl.getPotaValueMax())) {
					content = content   + "		<td style='background-color:pink;'>"
						        		+ "			<span>K (cmol/kg)</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensorControl.getPotaValueMin() + "~" + sensorControl.getPotaValueMax() + " cmol/kg</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensor.getPota() + " cmol/kg</span>"
						        		+ "		</td>";
				} else {
					content = content   + "		<td>"
						        		+ "			<span>K (cmol/kg)</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensorControl.getPotaValueMin() + "~" + sensorControl.getPotaValueMax() + " cmol/kg</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensor.getPota() + " cmol/kg</span>"
						        		+ "		</td>";
				}
				
				// P
				if(Float.parseFloat(sensor.getPhos()) < Float.parseFloat(sensorControl.getPhosValueMin()) || Float.parseFloat(sensor.getPhos()) > Float.parseFloat(sensorControl.getPhosValueMax())) {
					content = content   + "		<td style='background-color:pink;'>"
						        		+ "			<span>P (mg/kg)</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensorControl.getPhosValueMin() + "~" + sensorControl.getPhosValueMax() + " mg/kg</span>"
						        		+ "		</td>"
						        		+ "		<td style='background-color:pink;'>"
						        		+ "			<span>" + sensor.getPhos() + " mg/kg</span>"
						        		+ "		</td>";
				} else {
					content = content   + "		<td>"
						        		+ "			<span>P (mg/kg)</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensorControl.getPhosValueMin() + "~" + sensorControl.getPhosValueMax() + " mg/kg</span>"
						        		+ "		</td>"
						        		+ "		<td>"
						        		+ "			<span>" + sensor.getPhos() + " mg/kg</span>"
						        		+ "		</td>";
				}

				content = content	+ "</tr>"
					        		+ "</table><div></div><br><br>";
		        
		        
		    } catch(Exception e){
		    	log.info(e.toString()); // 에러를 콘솔에 출력
		    }
	    	
	    	i++;
	    }
		content = content + "<a href='http://182.162.141.59:7071/'>시스템 바로가기</a><p><p>";
        content = content + "본 메일은 발신전용이며, 문의에 대한 회신은 처리되지 않습니다.";
		messageHelper.setText(content,true);
		
		// 4. 메일 전송
		javaMailSender.send(message);
	    
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
}
