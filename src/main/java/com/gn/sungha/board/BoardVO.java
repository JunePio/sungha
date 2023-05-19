package com.gn.sungha.board;

import java.io.FileInputStream;
import org.springframework.core.io.Resource;

import com.gn.sungha.board.BoardVO;
import com.gn.sungha.common.Pagination;

import lombok.Data;
import lombok.Getter;

/**
 * @Class Name : BoardVO.java
 * @Description : Q&A VO
 * @Modification Information
 * @ 수정일        수정자     수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.09  이창호      최초생성
 * @
 */

@Data
public class BoardVO {
	private String rownum;
	private int boardId;
	private String writerId;
	private String title;
	private String content;
	private String regDateTime;
	private String modDateTime;
	private String qaGubun;
	private int replyId;
	private String state;
	private int firstIndex;
	private int lastIndex;
	private String sortColumn;
	private String sortType;
	private Pagination pagination;
	
	private String searchingType;
	private String searchingContent;
	

}
