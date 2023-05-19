package com.gn.sungha.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gn.sungha.common.Pagination;
import com.gn.sungha.local.localVO;

/**
 * @Class Name : NoticeService.java
 * @Description : 공지사항 Service
 * @param : 
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.13  CHLEE      최초생성
 * @version 1.0 
 */

@Service
public class NoticeService {
	
	@Autowired
	private NoticeMapper mapper;
	
	@Autowired
	private final ObjectMapper objectMapper = new ObjectMapper();
	
	/**
	 * @Method Name : selectNoticeList
	 * @Description : 공지사항 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.13  이창호      최초생성
	 * @
	 */
	
	public List<NoticeVO> selectNoticeList(String searchingType, String searchingContent, Pagination pagination, String sortColumn, String sortType) throws Exception {
		
		NoticeVO param = new NoticeVO();
		
		param.setSearchingType(searchingType);
		param.setSearchingContent(searchingContent);
		param.setSortColumn(sortColumn);
		param.setSortType(sortType);
		param.setPagination(pagination);
		
		List<NoticeVO> list = mapper.selectNoticeList(param);
		return list;
	}
	
	/**
	 * @Method Name : selectNoticeListTotalCnt
	 * @Description : 공지사항 총갯수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.13  이창호      최초생성
	 * @
	 */
	public int selectNoticeListTotalCnt(String searchingType, String searchingContent) throws Exception {
		int listCnt = mapper.selectNoticeListTotalCnt(searchingType, searchingContent);
		return listCnt;
	}
	
	/**
	 * @Method Name : selectNoticeDetail
	 * @Description : 공지사항 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	public NoticeVO selectNoticeDetail(int boardId) throws Exception {
		NoticeVO param = new NoticeVO();
		NoticeVO detail = new NoticeVO();
		try {
			
			param.setBoardId(boardId);
			
			detail = mapper.selectNoticeDetail(boardId);

		} catch(Exception e) {
			e.printStackTrace();
		}
//		System.out.println("서비스_detail_콘텐츠값:"+detail.getContent());
		return detail;
	}
	
	/**
	 * @Method Name : insertNoticeSave
	 * @Description : 공지사항 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	public boolean insertNoticeSave(String writerId, String title, String content,
			String regDateTime, String modDateTime, String noticeGubun) throws Exception {
		try {		
			mapper.insertNoticeSave(writerId, title, content, regDateTime, modDateTime, noticeGubun);
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * @Method Name : updateNoticeMod
	 * @Description : 공지사항 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.09  이창호      최초생성
	 * @
	 */
	public boolean updateNoticeMod(int boardId, String writerId, String title, String content, String regDateTime, String modDateTime, String noticeGubun) throws Exception {
		
		NoticeVO param = new NoticeVO();
		param.setBoardId(boardId);
		param.setTitle(title);
		param.setContent(content);
		param.setNoticeGubun(noticeGubun);

		try {
			mapper.updateNoticeMod(param);
		} catch(Exception e) {
			return false;
		}
		
		return true;
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
	public void deleteNoticeDel(int boardId) throws Exception {
		try {
			mapper.deleteNotice(boardId); // 해당 공지사항 삭제
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
