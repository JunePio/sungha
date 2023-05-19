package com.gn.sungha.irrigationInfo;

import java.io.IOException;
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
import com.gn.sungha.irrigationInfo.IrrigationInfoVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;

/**
 * @Class Name : IrrigationInfoController.java
 * @Description : 관수정보 Controller
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.08  CHLEE      최초생성
 * @version 1.0
 */

@RestController
@RequestMapping(value="/irrigation")

public class IrrigationInfoController {
	
	@Autowired
	private IrrigationInfoService service;
	
	/**
	 * @throws Exception 
	 * @Method Name : selectIrrigationInfoList
	 * @Description : 관수정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.08  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationInfoList.do")
	public ModelAndView selectIrrigationInfoList(HttpServletRequest httpServletRequest) throws Exception {
		String irrigationId = httpServletRequest.getParameter("irrigationId");
		String irrigation = httpServletRequest.getParameter("irrigation");
		String organizationId = httpServletRequest.getParameter("organizationId");
		
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		String idx = httpServletRequest.getParameter("idx");
		
		if(Util.isEmpty(sortColumn))
			sortColumn = "1";
		if(Util.isEmpty(sortType))
			sortType = "asc";
		if(Util.isEmpty(page))
			page = "1";
		if(Util.isEmpty(range))
			range = "1";
		if(Util.isEmpty(irrigationId))
			irrigationId = "";
		if(Util.isEmpty(irrigation))
			irrigation = "";
		if(Util.isEmpty(organizationId))
			organizationId = "";
			
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("irrigation/irrigationInfoList"); // view 파일 경로
		Pagination pagination = new Pagination(); // 페이징 객체 생성
		int totalCnt = service.selectIrrigationInfoListTotalCnt(irrigationId, irrigation, organizationId); // 기관정보 리스트 개수 조회
		pagination.pageInfo(Integer.parseInt(page),  Integer.parseInt(range),  totalCnt); // 페이지 처리 메소드에 파라미터 값 입력
		// 관수정보 조회
		List<IrrigationInfoVO> list = service.selectIrrigationInfoList(irrigationId, irrigation, organizationId, pagination, sortColumn, sortType);       

		modelAndView.addObject("list", list); // 관수정보 조회 리스트
		modelAndView.addObject("irrigationId", irrigationId); // 관수ID
		modelAndView.addObject("irrigation", irrigation); // 관수명
		modelAndView.addObject("organizationId", organizationId); // 현장ID	
		modelAndView.addObject("pagination", pagination); // 게시판 페이징 정보 리턴
		modelAndView.addObject("sortColumn", sortColumn); // 게시판 헤더 정렬컬럼 정보 리턴
        modelAndView.addObject("sortType", sortType); // 게시판 헤더 정렬타입 정보 리턴
        modelAndView.addObject("idx", idx);
        return modelAndView;
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
	/*
	@RequestMapping(value="/dupCheck.do")
	public HashMap<String, Object> selectDupCheck(HttpServletRequest httpServletRequest) throws Exception {
		String irrigationId = httpServletRequest.getParameter("irrigationId");
		if(Util.isEmpty(irrigationId))
			irrigationId = "";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("irrigationInfoList");
		boolean dupCheckResult = service.selectDupCheck(irrigationId);
		HashMap<String, Object> list = new HashMap<String, Object>();
		list.put("dupCheckResult", dupCheckResult);
		return list;
	}*/
	
	/**
	 * @throws Exception 
	 * @Method Name : selectIrrigationInfoSave
	 * @Description : 관수정보 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.22  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationInfoSave.do")
	public HashMap<String, Object> selectIrrigationInfoSave(HttpServletRequest httpServletRequest) throws Exception {
		String irrigationId = httpServletRequest.getParameter("irrigationId");
		String irrigation = httpServletRequest.getParameter("irrigation");
		String streamTime = httpServletRequest.getParameter("streamTime");
		String streamFlow = httpServletRequest.getParameter("streamFlow");
		String nutrientTime = httpServletRequest.getParameter("nutrientTime");
		String nutrientSolution = httpServletRequest.getParameter("nutrientSolution");
		String organizationId = httpServletRequest.getParameter("organizationId");
		
		boolean saveResult = service.selectIrrigationInfoSave(irrigationId, irrigation, streamTime, streamFlow, nutrientTime, nutrientSolution, organizationId);
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("saveResult", saveResult);
		return result;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectirrigationInfoDetail
	 * @Description : 관수정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.28  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationInfoDetail.do")
	public HashMap<String, Object> selectIrrigationInfoDetail(HttpServletRequest httpServletRequest) throws Exception {
		String irrigationId = httpServletRequest.getParameter("irrigationId");
		IrrigationInfoVO irrigationInfoDetail = service.selectIrrigationInfoDetail(irrigationId);
		HashMap<String, Object> detail = new HashMap<String, Object>();
        detail.put("irrigationInfoDetail", irrigationInfoDetail);
		return detail;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectIrrigationInfoModDetail
	 * @Description : 관수정보 수정조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationInfoModDetail.do")
	public HashMap<String, Object> selectIrrigationInfoModDetail(HttpServletRequest httpServletRequest) throws Exception {
		String irrigationId = httpServletRequest.getParameter("irrigationId");
		IrrigationInfoVO irrigationInfoModDetail = service.selectIrrigationInfoModDetail(irrigationId);
		HashMap<String, Object> modDetail = new HashMap<String, Object>();
		modDetail.put("irrigationInfoModDetail", irrigationInfoModDetail);
		return modDetail;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateIrrigationInfoMod
	 * @Description : 관수정보 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.28  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/irrigationInfoMod.do")
	public HashMap<String, Object> updateIrrigationInfoMod(HttpServletRequest httpServletRequest) throws Exception {
		String irrigationIdDetail = httpServletRequest.getParameter("irrigationIdDetail");
		String irrigationId = httpServletRequest.getParameter("irrigationId");
		String irrigation = httpServletRequest.getParameter("irrigation");
		String streamTime = httpServletRequest.getParameter("streamTime");
		String streamFlow = httpServletRequest.getParameter("streamFlow");
		String nutrientTime = httpServletRequest.getParameter("nutrientTime");
		String nutrientSolution = httpServletRequest.getParameter("nutrientSolution");
		String organizationId = httpServletRequest.getParameter("organizationId");
		
		
		boolean modResult = true;
		try {
			service.updateIrrigationInfoMod(irrigationIdDetail, irrigationId, irrigation, streamTime, streamFlow, nutrientTime, nutrientSolution, organizationId);
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
	@RequestMapping(value="/irrigationInfoDel.do")
	public HashMap<String, Object> selectIrrigationInfoDel(HttpServletRequest httpServletRequest) throws Exception {
		String irrigationId = httpServletRequest.getParameter("irrigationId");
		boolean delResult = true;
		try {
			service.deleteIrrigationInfoDel(irrigationId);
		} catch(Exception e) {
			delResult = false;
		}
		HashMap<String, Object> modDetail = new HashMap<String, Object>();
		modDetail.put("delResult", delResult);
		return modDetail;
		
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
		String irrigationId = httpServletRequest.getParameter("irrigationId");
		String irrigation = httpServletRequest.getParameter("irrigation");
		String organizationId = httpServletRequest.getParameter("organizationId");
		
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		
		String page = httpServletRequest.getParameter("page");
		String range = httpServletRequest.getParameter("range");
		String rangeSize = httpServletRequest.getParameter("rangeSize");
		String idx = httpServletRequest.getParameter("idx");
		
        return ResponseEntity.ok(service.getUsersPointStats(response, excelDownload, irrigationId, irrigation,organizationId, new Pagination(), "1", "asc"));
    }
    
}
