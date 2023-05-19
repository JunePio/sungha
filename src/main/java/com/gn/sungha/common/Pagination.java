package com.gn.sungha.common;

import lombok.Data;

@Data
public class Pagination {

	private int listSize = 10;  //초기값으로 목록개수를 10으로 셋팅

	private int rangeSize = 10; //초기값으로 페이지범위를 10으로 셋팅

	private int page;

	private int range;

	private int listCnt;

	private int pageCnt;

	private int startPage;

	private int endPage;
	
	private int startList;
	
	private int firstPage;
	
	private int lastPage;
	
	private int lastRange;

	private boolean prev = false;

	private boolean next = false;
	
	public void pageInfo(int page, int range, int listCnt) {

		this.page = page;

		this.range = range;

		this.listCnt = listCnt;

		//전체 페이지수 
		//this.pageCnt = (int) Math.ceil(listCnt/listSize);
		//시작 페이지
		//this.startPage = (range - 1) * rangeSize + 1;
		//끝 페이지
		//this.endPage = range * rangeSize;
		
		//전체 페이지수
		this.pageCnt = (int) Math.ceil(((listCnt-1)/listSize)+1);
		//시작 페이지
		this.startPage = ((page - 1) / listSize) * listSize + 1;
		//끝 페이지
		this.endPage = this.startPage + listSize - 1;
		//게시판 시작번호
		this.startList = (page - 1) * listSize;
		//게시판 처음 페이지
		this.firstPage = 1;
		//게시판 마지막 페이지
		this.lastPage = listCnt / 10;
		if(listCnt % 10 > 0) {
			this.lastPage++;
		}
		this.lastRange = this.lastPage / 10 + 1;
		//이전 버튼 상태
		this.prev = firstPage == 1 ? false : true;
		//다음 버튼 상태
		this.next = endPage > pageCnt ? false : true;
		if (this.endPage > this.pageCnt) {
			//this.startPage = this.pageCnt;
			this.endPage = this.pageCnt;
			this.next = false;
		}
	}
	
	
}
