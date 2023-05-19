package com.gn.sungha.board;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gn.sungha.board.BoardMapper;
import com.gn.sungha.common.Pagination;
import com.gn.sungha.board.BoardVO;

/**
 * @Class Name : BoardService.java
 * @Description : Q&A Service
 * @param : 
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.09  CHLEE      최초생성
 * @version 1.0 
 */

@Service
public class BoardService {
	
	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private final ObjectMapper objectMapper = new ObjectMapper();
	
	/**
	 * @Method Name : selectBoardList
	 * @Description : Q&A 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	public List<BoardVO> selectBoardList(String searchingType, String searchingContent, Pagination pagination, String sortColumn, String sortType) throws Exception {
		
		BoardVO param = new BoardVO();
		param.setSearchingType(searchingType);
		param.setSearchingContent(searchingContent);
		param.setSortColumn(sortColumn);
		param.setSortType(sortType);
		param.setPagination(pagination);
		
		
		//List<BoardVO> list = mapper.selectBoardList(searchingType, searchingContent, pagination.getStartList(), pagination.getListSize(), sortColumn, sortType);
		List<BoardVO> list = mapper.selectBoardList(param);
		return list;
	}
	
	/**
	 * @Method Name : selectBoardListTotalCnt
	 * @Description : Q&A 총갯수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	public int selectBoardListTotalCnt(String searchingType, String searchingContent) throws Exception {
		int listCnt = mapper.selectBoardListTotalCnt(searchingType, searchingContent);
		return listCnt;
	}

	/**
	 * @Method Name : selectBoardDetail
	 * @Description : Q&A 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	public BoardVO selectBoardDetail(int boardId) throws Exception {
		BoardVO param = new BoardVO();
		BoardVO detail = new BoardVO();
		try {
			
			param.setBoardId(boardId);
			
			detail = mapper.selectBoardDetail(boardId);

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return detail;
	}
	
	/**
	 * @Method Name : insertBoardSave
	 * @Description : Q&A 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	public boolean insertBoardSave(String writerId, String title, String content,
			String regDateTime, String modDateTime, String qaGubun) throws Exception {
		try {		
			mapper.insertBoardSave(writerId, title, content, regDateTime, modDateTime, qaGubun);
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * @Method Name : updateBoardMod
	 * @Description : Q&A 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	public boolean updateBoardMod(int boardId, String writerId, String title, String content, String regDateTime, String modDateTime, String qaGubun) throws Exception {

		try {
			mapper.updateBoardMod(boardId, writerId, title, content, regDateTime, modDateTime, qaGubun);
		} catch(Exception e) {
			return false;
		}
		
		return true;
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
	public void deleteBoardDel(int boardId) throws Exception {
		try {
			mapper.deleteBoard(boardId); // 해당 Q&A 삭제
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectBoardReplyList
	 * @Description : Q&A 댓글 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ @ 2023.02.09  이창호      최초생성
	 * @
	 */
	
	public List<BoardVO> selectBoardReplyList(int boardId) throws Exception {
		List<BoardVO> list = mapper.selectBoardReplyList(boardId);
		return list;
	}
	
	
	/**
	 * @throws Exception 
	 * @Method Name : insertBoardReplySave
	 * @Description : Q&A 댓글 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ @ 2023.02.09  이창호      최초생성
	 * @
	 */
	public boolean insertBoardReplySave(String writerId, String content, String regDateTime, String modDateTime, int boardId) throws Exception {
		try {		
			
			BoardVO param = new BoardVO();
			param.setWriterId(writerId);
			param.setContent(content);
			param.setRegDateTime(regDateTime);
			param.setModDateTime(modDateTime);
			param.setBoardId(boardId);
					
			mapper.insertBoardReply(param);
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : getBoardReplyId
	 * @Description : Q&A 댓글ID 가져오기
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ @ 2023.02.09  이창호      최초생성
	 * @
	 */
	public int getBoardReplyId(int boardId) throws Exception {
		int replyId = 0;
		try {		
			replyId =  mapper.getBoardReplyId(boardId);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return replyId;
	}

	/**
	 * @throws Exception 
	 * @Method Name : updateBoardReplyMod
	 * @Description :  Q&A 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	public boolean updateBoardReplyMod(int replyId, String writerId, String content, String regDateTime, String modDateTime) throws Exception {

		try {
			BoardVO param = new BoardVO();
			param.setReplyId(replyId);
			param.setWriterId(writerId);
			param.setContent(content);
			param.setRegDateTime(regDateTime);
			param.setModDateTime(modDateTime);
			
			mapper.updateBoardReplyMod(param);
		} catch(Exception e) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteBoardReply
	 * @Description : Q&A 댓글삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean deleteBoardReply(int replyId) throws Exception {
		
		boolean delResult = true;
		
		try {
			mapper.deleteBoardReply(replyId);
		} catch(Exception e) {
			e.printStackTrace();
			delResult = false;
		}
		
		return delResult;
	}
	
}
