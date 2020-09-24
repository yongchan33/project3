package com.kh.portfolio.transaction.svc;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kh.portfolio.common.page.FindCriteria;
import com.kh.portfolio.common.page.PageCriteria;
import com.kh.portfolio.common.page.RecordCriteria;
import com.kh.portfolio.product.svc.ProductSVCImpl;
import com.kh.portfolio.product.vo.ProductVO;
import com.kh.portfolio.transaction.dao.TransactionDAO;
import com.kh.portfolio.transaction.vo.RequestVO;
import com.kh.portfolio.transaction.vo.ReviewVO;
import com.kh.portfolio.transaction.vo.TransactionVO;

@Service
public class TransactionSVCImpl implements TransactionSVC {
	private static final Logger logger = LoggerFactory.getLogger(ProductSVCImpl.class);
	@Inject

	TransactionDAO transactionDAO;

	@Inject
	RecordCriteria recordCriteria;

	@Inject
	PageCriteria pageCriteria;

	@Inject
	FindCriteria findCriteria;

	@Override
	public int request(RequestVO requestVO) {
		int result = 0;
		result = transactionDAO.request(requestVO);
		return result;

	}

	@Override
	public FindCriteria getFindCriteria(int reqPage, String searchType, String keyword) {
		// 한페이지에 보여줄 레코드수
		recordCriteria.setRecNumPerPage(8);
		// 사용자의 요청페이지
		recordCriteria.setReqPage(reqPage);
		// 한페이지에보여줄 페이지수
		pageCriteria.setPageNumPerPage(10);
		// 레코드정보
		pageCriteria.setRc(recordCriteria);
		// 페이징계산
		pageCriteria.calculatePaging();
		// 검색어정보
		findCriteria.setPageCriteria(pageCriteria);
		findCriteria.setSearchType(searchType);
		findCriteria.setKeyword(keyword);

		// 게시글 총 레코드 건수
		findCriteria.getPageCriteria().setTotalRec(transactionDAO.totalRecordCount(searchType, keyword));

		return findCriteria;
	}

	// 구매요청리스트
	@Override
	public List<RequestVO> rlist(int reqPage, String m_number) {
		List<RequestVO> list = null;

		// 요청페이지
		recordCriteria.setReqPage(reqPage);
		// 한페이이지에보여줄 레코드수 셋팅
		recordCriteria.setRecNumPerPage(10);
		list = transactionDAO.rlist(recordCriteria.getStarRec(), recordCriteria.getEndRec(), m_number);

		return list;
	}

	// 거래요청리스트
	@Override
	public List<TransactionVO> tlist(int reqPage, String m_number) {
		List<TransactionVO> list = null;

		// 요청페이지
		recordCriteria.setReqPage(reqPage);
		// 한페이이지에보여줄 레코드수 셋팅
		recordCriteria.setRecNumPerPage(10);
		list = transactionDAO.tlist(recordCriteria.getStarRec(), recordCriteria.getEndRec(), m_number);

		return list;
	}

	@Override
	public int transaction(String requestnumber,String m_number,String t_content) {
		int result = 0;
		result = transactionDAO.transaction(requestnumber,m_number,t_content);
		return result;
	}

	// 상품 삭제
	@Override
	public int canclerequest(String requestnumber) {
		int result = 0;

		result = transactionDAO.canclerequest(requestnumber);

		return result;
	}

	// 거래 상태변경
	@Override
	public int updatecondition(String requestnumber,String m_number) {
		int result = 0;
		result = transactionDAO.updatecondition(requestnumber,m_number);
		return result;
	}

	// 거래취소 상태변경(거래중->판매중)
	@Override
	public int deletetransaction(String productnumber) {
		int result = 0;
		result = transactionDAO.deletetransaction(productnumber);
		return result;
	}

	// 거래상태변경(대기중'1'-> 거절'3')
	@Override
	public int utctransaction(String productnumber) {
		int result = 0;
		result = transactionDAO.utctransaction(productnumber);
		return result;
	}

	// 거래요청 상태변경('1' 대기 -> '2' 수락)
	@Override
	public int allowreqest(String requestnumber,String m_number) {
		int result = 0;
		result = transactionDAO.allowreqest(requestnumber,m_number);
		return result;
	}

	@Override
	public int review(ReviewVO reviewVO) {
		logger.info("reviewSVC호출");
		int result = 0;
		result = transactionDAO.review(reviewVO);
		return result;
	}

	@Override
	public int transactionfinish(String productnumber) {
		int result = 0;
		result = transactionDAO.transactionfinish(productnumber);
		return result;
	}

	@Override
	public int finishtcondition(String productnumber,String m_number) {
		int result = 0;
		result = transactionDAO.finishtcondition(productnumber,m_number);
		return result;
	}

	@Override
	public List<RequestVO> mytransaction(int reqPage, String m_number, int trsstate) {
		List<RequestVO> list = null;

		//요청페이지
		recordCriteria.setReqPage(reqPage);
		//한페이이지에보여줄 레코드수 셋팅
		recordCriteria.setRecNumPerPage(10);
		list = transactionDAO.mytransaction(recordCriteria.getStarRec(),
												 recordCriteria.getEndRec(),
												 m_number,
												 trsstate);

		return list;
	}

	
	
	@Override
	public int canclesamerequest(String requestnumber) {
		int result = 0;
		result = transactionDAO.canclesamerequest(requestnumber);
		return result;
	}

	@Override
	public RequestVO checkrequest(String m_number, String p_number) {
		RequestVO requestVO = null;
		// 게시글 입력처리
		requestVO = transactionDAO.checkrequest(m_number,p_number);

		return requestVO;
	}
	@Override
	public List<ProductVO> outmembercheck(String m_number) {
		List<ProductVO> list = null;
		list = transactionDAO.outmembercheck(m_number);
		return list;

}
}
