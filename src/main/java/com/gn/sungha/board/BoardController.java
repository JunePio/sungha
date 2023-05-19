package com.gn.sungha.board;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.gn.sungha.notice.NoticeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gn.sungha.common.Pagination;
import com.gn.sungha.common.Util;
import com.gn.sungha.board.BoardService;
import com.gn.sungha.board.BoardVO;

/**
 * @Class Name : BoardController.java
 * @Description : Q&A게시판 Controller
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.09  CHLEE      최초생성
 * @version 1.0 
 */

@RestController
@RequestMapping(value="/board")
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	/**
	 * @throws Exception 
	 * @Method Name : selectBoardList
	 * @Description : Q&A 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/boardList.do")
	public ModelAndView selectBoardList(HttpServletRequest httpServletRequest) throws Exception {
	
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
		if(Util.isEmpty(title))
			title = "";
		if(Util.isEmpty(content))
			content = "";
		if(Util.isEmpty(searchingType))
			searchingType = "";
		if(Util.isEmpty(searchingContent))
			searchingContent = "";
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("board/boardList"); // view 파일 경로
		Pagination pagination = new Pagination(); // 페이징 객체 생성
//		pagination.setPage(Integer.parseInt(page));
//		pagination.setPage(Integer.parseInt(range));
//		pagination.setPage(Integer.parseInt(rangeSize));
		// Q&A 개수 조회
		int totalCnt = service.selectBoardListTotalCnt(searchingType, searchingContent); // Q&A 리스트 개수 조회
		pagination.pageInfo(Integer.parseInt(page),  Integer.parseInt(range),  totalCnt); // 페이지 처리 메소드에 파라미터 값 입력
		// Q&A 리스트 조회
		List<BoardVO> boardList = service.selectBoardList(searchingType, searchingContent, pagination, sortColumn, sortType);

		modelAndView.addObject("boardList", boardList); // Q&A게시판 조회 리스트
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
	 * @Description : Q&A 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/boardDetail.do")
	public ModelAndView selectBoardDetail(HttpServletRequest httpServletRequest) throws Exception {
		int boardId = Integer.parseInt(httpServletRequest.getParameter("boardIdParam")); // 게시글ID
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식

		BoardVO boardDetail = service.selectBoardDetail(boardId);
		List<BoardVO> boardReplyList = service.selectBoardReplyList(boardId);

		HashMap<String, Object> detail = new HashMap<String, Object>();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("board/boardDetail"); // view 파일 경로
		
		modelAndView.addObject("boardDetail", boardDetail);
		modelAndView.addObject("boardReplyList", boardReplyList);
        modelAndView.addObject("searchingType", searchingType); // 제목 or 내용 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색어 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 정렬 컬럼
        modelAndView.addObject("sortType", sortType); // 정렬 방식
        
		return modelAndView;
		
	}
	
	
	/**
	 * @throws Exception 
	 * @Method Name : insertBoardSave
	 * @Description : Q&A 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/boardRegist.do")
	public ModelAndView selectBoardRegist(HttpServletRequest httpServletRequest) throws Exception {
		
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식
		String writerId = httpServletRequest.getParameter("writerId");  // 작성자
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("board/boardRegist"); // view 파일 경로
        modelAndView.addObject("searchingType", searchingType); // 센서명 or 센서ID 리턴
        modelAndView.addObject("searchingContent", searchingContent); // 검색어 리턴
        modelAndView.addObject("sortColumn", sortColumn); // 정렬 컬럼
        modelAndView.addObject("sortType", sortType); // 정렬 방식
		modelAndView.addObject("writerId", writerId); // 작성자
		
		return modelAndView;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : BoardModify
	 * @Description : Q&A 수정이동
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.05.17   이준영      최초생성
	 * @
	 */
//	@RequestMapping(value="/boardModDetail.do")
//	public ModelAndView selectBoardBoardSave(HttpServletRequest request) throws Exception {
//		String writerId = request.getParameter("writerId"); // 작성자ID
//		String title = request.getParameter("title"); // 제목
//		String content = request.getParameter("content"); // 내용
//		String regDateTime = request.getParameter("regDateTime"); // 등록일시
//		String modDateTime = request.getParameter("modDateTime"); // 수정일시
//		String qaGubun = request.getParameter("qaGubun"); // 문의종류
//
//        boolean saveResult = service.insertBoardSave(writerId, title, content, regDateTime, modDateTime, qaGubun);
//	    HashMap<String, Object> result = new HashMap<String, Object>();
//	    result.put("saveResult", saveResult);
//		return result;
//	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertBoardSave
	 * @Description : Q&A 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/boardMod.do")
	public HashMap<String, Object> updateBoardMod(HttpServletRequest httpServletRequest) throws Exception {
		
		int boardId = Integer.parseInt(httpServletRequest.getParameter("boardId")); // 게시글ID
		String writerId = httpServletRequest.getParameter("writerId"); // 작성자
		String title = httpServletRequest.getParameter("title"); // 제목
		String content = httpServletRequest.getParameter("content"); // 내용
		String regDateTime = httpServletRequest.getParameter("regDateTime"); // 등록일자
		String modDateTime = httpServletRequest.getParameter("modDateTime"); // 수정일자
		String qaGubun = httpServletRequest.getParameter("qaGubun"); // 문의종류
		
		boolean modResult = true;
		try {
			service.updateBoardMod(boardId, writerId, title, content, regDateTime, modDateTime, qaGubun);		
		} catch(Exception e) {
			modResult = false;
		}
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("modResult", modResult);
		return result;
	}

	/**
	 * @throws Exception
	 * @Method Name : insertBoardSave
	 * @Description : Q&A 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/boardModDetail.do")
	public ModelAndView selectBoardModDetail(HttpServletRequest httpServletRequest) throws Exception {
		int boardId = Integer.parseInt(httpServletRequest.getParameter("boardId")); // 게시글ID
		String searchingType = httpServletRequest.getParameter("searchingType"); // 센서명 or 센서ID 검색어
		String searchingContent = httpServletRequest.getParameter("searchingContent"); // 검색어
		String sortColumn = httpServletRequest.getParameter("sortColumn"); // 정렬 컬럼
		String sortType = httpServletRequest.getParameter("sortType");  // 정렬 방식

		BoardVO noticeDetail = service.selectBoardDetail(boardId);
//		HashMap<String, Object> detail = new HashMap<String, Object>();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("board/boardMod"); // view 파일 경로

		modelAndView.addObject("noticeDetail", noticeDetail);
		modelAndView.addObject("searchingType", searchingType); // 제목 or 내용 리턴
		modelAndView.addObject("searchingContent", searchingContent); // 검색어 리턴
		modelAndView.addObject("sortColumn", sortColumn); // 정렬 컬럼
		modelAndView.addObject("sortType", sortType); // 정렬 방식

		return modelAndView;

	}

	/**
	 * @throws Exception 
	 * @Method Name : deleteBoardDel
	 * @Description : Q&A 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/boardDel.do")
	public HashMap<String, Object> deleteBoardDel(HttpServletRequest httpServletRequest) throws Exception {
		int boardId = Integer.parseInt(httpServletRequest.getParameter("boardId")); // 기관ID
		boolean delResult = true;
		try {
			
			List<BoardVO> boardReplyList = service.selectBoardReplyList(boardId);
			
			for(BoardVO boardReply : boardReplyList) {
				service.deleteBoardReply(boardReply.getReplyId());
			}
			
			service.deleteBoardDel(boardId);
			
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
	 * @Method Name : insertBoardReplySave
	 * @Description : Q&A 댓글 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/boardReplySave.do")
	public HashMap<String, Object> insertBoardReplySave(HttpServletRequest request) throws Exception {
		String writerId = request.getParameter("writerId"); // 작성자ID
		String content = request.getParameter("content"); // 내용
		String regDateTime = request.getParameter("regDateTime"); // 등록일시
		String modDateTime = request.getParameter("modDateTime"); // 수정일시
		int boardId = Integer.parseInt(request.getParameter("boardId")); // 게시판ID
		
		boolean saveResult = false;
		
	try {
		saveResult = service.insertBoardReplySave(writerId, content, regDateTime, modDateTime, boardId);       // 서버에 댓글 정보 저장 먼저 하고
        int replyId = service.getBoardReplyId(boardId); 	
	}catch (Exception e){
        e.printStackTrace();
    }
	
	HashMap<String, Object> mod = new HashMap<String, Object>();
    
    if(saveResult == false) {
    	mod.put("saveResult", false);
    } else {
    	mod.put("saveResult", true);
    }
    
	return mod;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateBoardReplyMod
	 * @Description : Q&A 댓글 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/boardReplyMod.do")
	public boolean updateBoardReplyMod(HttpServletRequest httpServletRequest) throws Exception {
		int replyId = Integer.parseInt(httpServletRequest.getParameter("replyId")); // 댓글ID
		String writerId = (httpServletRequest.getParameter("writerId")); // 작성자ID
		String content = (httpServletRequest.getParameter("content")); // 내용
		String regdDateTime = (httpServletRequest.getParameter("regdDateTime")); // 등록일시
		String modDateTime = (httpServletRequest.getParameter("modDateTime")); // 수정일시
		//int boardId = Integer.parseInt(httpServletRequest.getParameter("boardId")); // 게시글ID
		
		boolean modResult = true;

		try {
			// 내용 수정
			service.updateBoardReplyMod(replyId, writerId, content, regdDateTime, modDateTime);
		} catch(Exception e) {
			modResult = false;
		}
		
		return modResult;

	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteBoardReply
	 * @Description : Q&A 댓글 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	@RequestMapping(value="/boardReplyDel.do")
	public HashMap<String, Object> deleteBoardReply(HttpServletRequest httpServletRequest) throws Exception {
		int replyId = Integer.parseInt(httpServletRequest.getParameter("replyId")); // 기관ID
		boolean delResult = true;
		try {
			
			List<BoardVO> boardReplyList = service.selectBoardReplyList(replyId);
			
			for(BoardVO boardReply : boardReplyList) {
				service.deleteBoardReply(boardReply.getReplyId());
			}
			
			service.deleteBoardReply(replyId);
			
		} catch(Exception e) {
			e.printStackTrace();
			delResult = false;
		}
		HashMap<String, Object> modDetail = new HashMap<String, Object>();
		modDetail.put("delResult", delResult);
		return modDetail;
	}
	
}

