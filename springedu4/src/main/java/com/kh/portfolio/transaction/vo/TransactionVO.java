package com.kh.portfolio.transaction.vo;



import java.sql.Timestamp;

import com.kh.portfolio.member.vo.MemberVO;
import com.kh.portfolio.product.vo.ProductVO;

import lombok.Data;

@Data
public class TransactionVO {
	private String t_number;
	private RequestVO requestVO;
	private ProductVO productVO;
	private MemberVO memberVO; //구매자
	private String t_content;
	private String t_condition;
	private String t_check;
	private Timestamp t_time;
}
