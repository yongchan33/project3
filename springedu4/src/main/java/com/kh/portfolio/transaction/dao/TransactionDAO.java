package com.kh.portfolio.transaction.dao;

import java.util.List;

import com.kh.portfolio.product.vo.ProductVO;
import com.kh.portfolio.transaction.vo.RequestVO;
import com.kh.portfolio.transaction.vo.ReviewVO;
import com.kh.portfolio.transaction.vo.TransactionVO;

public interface TransactionDAO {

	// 구매요청
	int request(RequestVO requestVO);

	// 요청 게시글 목록
	List<RequestVO> rlist(int startRec, int endRec, String m_number);

	// 요청 게시글 수
	int totalRecordCount(String searchType, String keyword);

	// 거래요청
	int transaction(String requestnumber, String m_number, String t_content);

	// 상태변경(판매중->거래중)
	int updatecondition(String requestnumber, String m_number);

	// 거래 게시글 목록
	List<TransactionVO> tlist(int startRec, int endRec, String m_number);

	// 게시글 목록
	List<RequestVO> mytransaction(int startRec, int endRec, String m_number, int trsstate);

	//후기작성
	int review(ReviewVO reviewVO);

	// 구매요청 거절
	int canclerequest(String requestnumber);

	// 거래취소
	int deletetransaction(String productnumber);

	// 거래상태변경(대기중'1'-> 거절'3')
	int utctransaction(String productnumber);

	// 거래요청 상태변경('1' 대기 -> '2' 수락)
	int allowreqest(String requestnumber, String m_number);

	// 거래완료 상태로 변경
	int transactionfinish(String productnumber);

	// 거래상태 완료로 변경('1' -> '2')
	int finishtcondition(String productnumber, String m_number);

	// 거래중인상품 요청거절
	int canclesamerequest(String requestnumber);
	
	// 구매요청 중복체크
	RequestVO checkrequest(String m_number,String p_number);

	// 회원탈퇴시 거래중 상품확인
	List<ProductVO> outmembercheck(String m_number);
}
