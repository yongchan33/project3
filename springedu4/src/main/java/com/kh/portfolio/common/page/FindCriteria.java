package com.kh.portfolio.common.page;

import lombok.Data;

@Data
public class FindCriteria {
	private String searchType;			//검색유형
	private String keyword;					//검색어
	private String listCategory;			//카테고리
	private String gedner;			//성별
	
	private PageCriteria pageCriteria;	
	
	public void setPageCriteria(PageCriteria pageCriteria) {
		this.pageCriteria = pageCriteria;
	}
}