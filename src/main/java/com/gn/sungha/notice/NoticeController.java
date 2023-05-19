package com.gn.sungha.notice;

import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gn.sungha.common.Pagination;
import com.gn.sungha.common.Util;

/**
 * @Class Name : NoticeController.java
 * @Description : 공지사항 Controller
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.13  CHLEE      최초생성
 * @version 1.0 
 */

@RestController
@RequestMapping(value="/notice")
public class NoticeController {
	
	@Autowired
	private NoticeService service;
	
	/**
	 * @throws Exception 
	 * @Method Name : selectNoticeList
	 * @Description : 공지사항 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.13  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/noticeList.do")
	
	public ModelAndView selectNoticeList(HttpServletRequest httpServletRequest) throws Exception {
		
		String title = httpServletRequest.getParameter("title"); // 제목
		String content = httpServletRequest.getParameter("content"); // 내용
		String searchingType = httpServletRequest.getParameter("searchingType"); // 제목 or 내용 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어

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
		if(Util.isEmpty(range))
			range = "1";
		if(Util.isEmpty(title))
			title = "";
		if(Util.isEmpty(content))
			content = "";
		if(Util.isEmpty(searchingType))
			searchingType = "";
		if(Util.isEmpty(searchingContent))
			searchingContent = "";
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("notice/noticeList"); // view 파일 경로
		Pagination pagination = new Pagination(); // 페이징 객체 생성
//		pagination.setPage(Integer.parseInt(page));
//		pagination.setPage(Integer.parseInt(range));
//		pagination.setPage(Integer.parseInt(rangeSize));
		// 공지사항 개수 조회
		int totalCnt = service.selectNoticeListTotalCnt(searchingType, searchingContent); // 공지사항 리스트 개수 조회
		pagination.pageInfo(Integer.parseInt(page),  Integer.parseInt(range),  totalCnt); // 페이지 처리 메소드에 파라미터 값 입력
		// 공지사항 리스트 조회
		List<NoticeVO> noticeList = service.selectNoticeList(searchingType, searchingContent, pagination, sortColumn, sortType);
		
		modelAndView.addObject("noticeList", noticeList); // 공지사항 조회 리스트
	    modelAndView.addObject("searchingType", searchingType); // 센서명 or 센서ID 리턴
	    modelAndView.addObject("searchingContent", searchingContent); // 검색어 리턴
	    
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
	 * @Method Name : selectBoarDetail
	 * @Description : 공지사항 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/noticeDetail.do")
	public ModelAndView selectBoarDetail(HttpServletRequest httpServletRequest) throws Exception {
		int boardId = Integer.parseInt(httpServletRequest.getParameter("boardIdParam")); // 게시글ID
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식

		NoticeVO noticeDetail = service.selectNoticeDetail(boardId);
//		System.out.println("컨트롤러_noticeDetail_콘텐츠값:"+noticeDetail.getContent());
		String content = noticeDetail.getContent();
		String regex = "\n";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(content);
		// 줄바꿈을 <br> 태그로 바꾸기
		String replacedContent = matcher.replaceAll("<br>");
//		content.replaceAll("\\r?\\n","<br>");
		noticeDetail.setContent(replacedContent);
//		System.out.println("컨트롤러_noticeDetail_콘텐츠2값:"+replacedContent);

		HashMap<String, Object> detail = new HashMap<String, Object>();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("notice/noticeDetail"); // view 파일 경로
		
		modelAndView.addObject("noticeDetail", noticeDetail);
        modelAndView.addObject("searchingType", searchingType); // 제목 or 내용 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색어 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 정렬 컬럼
        modelAndView.addObject("sortType", sortType); // 정렬 방식
        
		return modelAndView;
		
	}
	
	
	/**
	 * @throws Exception 
	 * @Method Name : selectNoticeRegist
	 * @Description : 공지사항 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/noticeRegist.do")
	public ModelAndView selectNoticeRegist(HttpServletRequest httpServletRequest) throws Exception {
		
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		String writerId = httpServletRequest.getParameter("writerId");  // 작성자
//		System.out.println("작성자값:"+writerId);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("notice/noticeRegist"); // view 파일 경로
        modelAndView.addObject("searchingType", searchingType); // 센서명 or 센서ID 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색어 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 정렬 컬럼
        modelAndView.addObject("sortType", sortType); // 정렬 방식
		modelAndView.addObject("writerId", writerId); // 작성자
		
		return modelAndView;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertNoticeSave
	 * @Description : 공지사항 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/noticeSave.do")
	public HashMap<String, Object> insertNoticeSave(HttpServletRequest request) throws Exception {
		String writerId = request.getParameter("writerId"); // 작성자ID
		String title = request.getParameter("title"); // 제목
		String content = request.getParameter("content"); // 내용
		String regDateTime = request.getParameter("regDateTime"); // 등록일시
		String modDateTime = request.getParameter("modDateTime"); // 수정일시
		String noticeGubun = request.getParameter("noticeGubun"); // 문의종류
        
        boolean saveResult = service.insertNoticeSave(writerId, title, content, regDateTime, modDateTime, noticeGubun);
	    HashMap<String, Object> result = new HashMap<String, Object>();
	    result.put("saveResult", saveResult);
		return result;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectBoarDetail
	 * @Description : 공지사항 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/noticeModDetail.do")
	public ModelAndView selectBoardModDetail(HttpServletRequest httpServletRequest) throws Exception {
		int boardId = Integer.parseInt(httpServletRequest.getParameter("boardIdParam")); // 게시글ID
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식

		NoticeVO noticeDetail = service.selectNoticeDetail(boardId);
		HashMap<String, Object> detail = new HashMap<String, Object>();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("notice/noticeMod"); // view 파일 경로
		
		modelAndView.addObject("noticeDetail", noticeDetail);
        modelAndView.addObject("searchingType", searchingType); // 제목 or 내용 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색어 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 정렬 컬럼
        modelAndView.addObject("sortType", sortType); // 정렬 방식
        
		return modelAndView;
		
	}	
	
	/**
	 * @throws Exception 
	 * @Method Name : updateNoticeMod
	 * @Description : 공지사항 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/noticeMod.do")
	public HashMap<String, Object> updateNoticeMod(HttpServletRequest httpServletRequest) throws Exception {
		
		int boardId = Integer.parseInt(httpServletRequest.getParameter("boardId")); // 게시글ID
		String writerId = httpServletRequest.getParameter("writerId"); // 작성자
		String title = httpServletRequest.getParameter("title"); // 제목
		String content = httpServletRequest.getParameter("content"); // 내용
		String regDateTime = httpServletRequest.getParameter("regDateTime"); // 등록일자
		String modDateTime = httpServletRequest.getParameter("modDateTime"); // 수정일자
		String noticeGubun = httpServletRequest.getParameter("noticeGubun"); // 문의종류
		
		boolean modResult = true;
		try {
			modResult = service.updateNoticeMod(boardId, writerId, title, content, regDateTime, modDateTime, noticeGubun);		
		} catch(Exception e) {
			modResult = false;
		}
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("modResult", modResult);
		return result;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteNoticeDel
	 * @Description : 공지사항 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/noticeDel.do")
	public HashMap<String, Object> deleteNoticeDel(HttpServletRequest httpServletRequest) throws Exception {
		int boardId = Integer.parseInt(httpServletRequest.getParameter("boardId")); // 기관ID
		boolean delResult = true;
		try {
					
			service.deleteNoticeDel(boardId);
			
		} catch(Exception e) {
			e.printStackTrace();
			delResult = false;
		}
		HashMap<String, Object> modDetail = new HashMap<String, Object>();
		modDetail.put("delResult", delResult);
		return modDetail;
		
	}


}
