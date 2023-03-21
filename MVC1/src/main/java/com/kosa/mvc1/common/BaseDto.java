package com.kosa.mvc1.common;

public class BaseDto {
	protected int pg=0;
	protected int rnum=0;
	protected String searchOpt=""; 	// 검색어 선택 옵션(제목, 내용, ...)
	protected String searchDeyword="";	// 검색어 키워드
	
	

	public BaseDto() {
		// TODO Auto-generated constructor stub
	}

	public BaseDto(int pg, String searchOpt, String searchDeyword) {
		super();
		this.pg = pg;
		this.searchOpt = searchOpt;
		this.searchDeyword = searchDeyword;
	}

	public int getRnum() {
		return rnum;
	}
	
	
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	
	public int getPg() {
		return pg;
	}

	public void setPg(int pg) {
		this.pg = pg;
	}

	public String getSearchOpt() {
		return searchOpt;
	}

	public void setSearchOpt(String searchOpt) {
		this.searchOpt = searchOpt;
	}

	public String getSearchDeyword() {
		return searchDeyword;
	}

	public void setSearchDeyword(String searchDeyword) {
		this.searchDeyword = searchDeyword;
	}
	
	
}

