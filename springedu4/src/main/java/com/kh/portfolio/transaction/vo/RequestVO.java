package com.kh.portfolio.transaction.vo;

import java.util.Date;

import com.kh.portfolio.member.vo.MemberVO;
import com.kh.portfolio.product.vo.ProductVO;

import lombok.Data;

@Data
public class RequestVO {
	
	private String r_number; //상품번호
	private ProductVO productVO; //판매자번호
	private String r_member; //판매자번호
	private MemberVO memberVO; //구매자
	private Date r_time; //구매요청시간
	private String r_content; //내용
	private String r_condition; //판매상태
	private String r_check; //
	private TransactionVO transactionVO;
}
