package com.kh.portfolio.board.svc;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kh.portfolio.board.dao.BoardDAO;
import com.kh.portfolio.board.vo.FaqVO;
import com.kh.portfolio.common.page.FindCriteria;
import com.kh.portfolio.common.page.PageCriteria;
import com.kh.portfolio.common.page.RecordCriteria;
import com.kh.portfolio.product.dao.ProductDAO;
import com.kh.portfolio.product.vo.ProductVO;
import com.kh.portfolio.transaction.vo.ReviewVO;

@Service
public class BoardSVCImpl implements BoardSVC {

	private static final Logger logger = LoggerFactory.getLogger(BoardSVCImpl.class);

	@Inject
	BoardDAO boardDAO;
	@Inject
	ProductDAO productDAO;
	@Inject
	RecordCriteria recordCriteria;
	@Inject
	PageCriteria pageCriteria;
	@Inject
	FindCriteria findCriteria;

	// FAQ목록
	@Override
	public List<FaqVO> faq() {
		List<FaqVO> list = null;

		list = boardDAO.faq();

		return list;
	}

	// 리뷰목록
	@Override
	public List<ProductVO> relist(int reqPage) {
		List<ProductVO> list = null;
		// 요청페이지
		recordCriteria.setReqPage(reqPage);
		// 한페이이지에보여줄 레코드수 셋팅
		recordCriteria.setRecNumPerPage(10);
		list = boardDAO.relist(recordCriteria.getStarRec(), recordCriteria.getEndRec());
		return list;
	}
	


	// 리뷰작성
	@Override
	public int review(ReviewVO reviewVO) {
		logger.info("reviewSVC호출");
		int result = 0;
		result = boardDAO.review(reviewVO);
		return result;
	}

	@Override
	public List<ProductVO> myrelist(String m_number) {
		List<ProductVO> list = null;
		list = boardDAO.myrelist(m_number);
		return list;
	}

}
