package com.gn.sungha.board;

import java.io.File;
import java.net.URLDecoder;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.gn.sungha.board.BoardVO;
import com.gn.sungha.local.localVO;

/**
 * @Class Name : BoardMapper.java
 * @Description : Q&A Mapper
 * @param : 
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.09  CHLEE      최초생성
 * @version 1.0 
 */

@Mapper
public interface BoardMapper {
	/**
	 * @Mapper Name : selectBoardList
	 * @Description : Q&A 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	/*
	List<BoardVO> selectBoardList(
			@Param("searchingType") String searchingType,
			@Param("searchingContent") String searchingContent,		
			@Param("startList") int firstIndex,
			@Param("listSize") int lastIndex,
			@Param("sortColumn") String sortColumn,
			@Param("sortType") String sortType) throws Exception;
	*/
	List<BoardVO> selectBoardList(BoardVO param) throws Exception;
	/**
	 * @Mapper Name : selectBoardListTotalCnt
	 * @Description : Q&A 조회 총갯수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	
	int selectBoardListTotalCnt(
			@Param("searchingType") String searchingType,
			@Param("searchingContent") String searchingContent) throws Exception;
	
	/**
	 * @Mapper Name : selectBoardDetail
	 * @Description : Q&A 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	BoardVO selectBoardDetail(int boardId) throws Exception;
	
	/**
	 * @Mapper Name : insertBoard
	 * @Description : Q&A 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	void insertBoardSave(
			@Param("writerId") String writerId,
			@Param("title") String title,
			@Param("content") String content,
			@Param("regDateTime") String regDateTime,
			@Param("modDateTime") String modDateTime,
			@Param("qaGubun") String qaGubun) throws Exception;
	
	/**
	 * @Mapper Name : updateBoardMod
	 * @Description :  Q&A 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	void updateBoardMod(@Param("boardId") int boardId, 
			@Param("writerId") String writerId,
			@Param("title") String title,
			@Param("content") String content,
			@Param("regDateTime") String regDateTime,
			@Param("modDateTime") String modDateTime,
			@Param("qaGubun") String qaGubun) throws Exception;
	
	/**
	 * @Mapper Name : deleteBoardDel
	 * @Description : Q&A 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	void deleteBoard(@Param("boardId") int boardId) throws Exception;
	
	/**
	 * @Method Name : selectBoardReplyList
	 * @Description : Q&A 댓글 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	List<BoardVO> selectBoardReplyList(@Param("boardId") int boardId) throws Exception;
	
	/**
	 * @Mapper Name : insertBoardReply
	 * @Description : Q&A 댓글저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	void insertBoardReply(BoardVO param) throws Exception;
	
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
	int getBoardReplyId(@Param("boardId") int boardId) throws Exception;
	
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
	boolean updateBoardReplyMod(BoardVO param) throws Exception;
	
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
	boolean deleteBoardReply(int replyId) throws Exception;
	

}
