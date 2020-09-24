package com.kh.portfolio.board.dao;

import java.util.List;

import com.kh.portfolio.board.vo.FaqVO;
import com.kh.portfolio.product.vo.ProductVO;
import com.kh.portfolio.transaction.vo.ReviewVO;

public interface BoardDAO {

	//FAQ 목록
	List<FaqVO> faq();
	//리뷰 목록
	List<ProductVO> relist(int startRec, int endRec);
	//리뷰 작성
	int review(ReviewVO reviewVO);
	//내 최신 리뷰 목록
	List<ProductVO> myrelist(String m_number);
}
















