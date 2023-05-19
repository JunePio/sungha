package com.gn.sungha.notice;

import com.gn.sungha.common.Pagination;

import lombok.Data;

/**
 * @Class Name : NoticeVO.java
 * @Description : 공지사항 VO
 * @Modification Information
 * @ 수정일        수정자     수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.13  이창호      최초생성
 * @
 */

@Data
public class NoticeVO {
	private String rownum;
	private int boardId;
	private String writerId;
	private String title;

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	private String content;
	private String regDateTime;
	private String modDateTime;
	private String noticeGubun;
	
	private String searchingType;
	private String searchingContent;
	private int firstIndex;
	private int lastIndex;
	private String sortColumn;
	private String sortType;
	private Pagination pagination;

}
