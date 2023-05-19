package com.gn.sungha.notice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.gn.sungha.local.localVO;

/**
 * @Class Name : NoticeMapper.java
 * @Description : 공지사항 Mapper
 * @param : 
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.13  CHLEE      최초생성
 * @version 1.0 
 */

@Mapper
public interface NoticeMapper {
	/**
	 * @Mapper Name : selectNoticeList
	 * @Description : 공지사항 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.13  이창호      최초생성
	 * @
	 */
	List<NoticeVO> selectNoticeList(NoticeVO param) throws Exception;
	/**
	 * @Mapper Name : selectNoticeListTotalCnt
	 * @Description : 공지사항 조회 총갯수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	
	int selectNoticeListTotalCnt(
			@Param("searchingType") String searchingType,
			@Param("searchingContent") String searchingContent) throws Exception;
	
	/**
	 * @Mapper Name : selectNoticeDetail
	 * @Description : 공지사항 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	NoticeVO selectNoticeDetail(int boardId) throws Exception;
	
	/**
	 * @Mapper Name : insertNotice
	 * @Description : 공지사항 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	void insertNoticeSave(
			@Param("writerId") String writerId,
			@Param("title") String title,
			@Param("content") String content,
			@Param("regDateTime") String regDateTime,
			@Param("modDateTime") String modDateTime,
			@Param("noticeGubun") String noticeGubun) throws Exception;
	
	/**
	 * @Mapper Name : updateNoticeMod
	 * @Description :  공지사항 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	void updateNoticeMod(NoticeVO param) throws Exception;
	
	/**
	 * @Mapper Name : deleteNoticeDel
	 * @Description : 공지사항 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	void deleteNotice(@Param("boardId") int boardId) throws Exception;

}
