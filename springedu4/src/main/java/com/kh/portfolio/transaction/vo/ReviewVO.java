package com.kh.portfolio.transaction.vo;

import com.kh.portfolio.member.vo.MemberVO;
import com.kh.portfolio.product.vo.ProductVO;

import lombok.Data;
@Data
public class ReviewVO {
	private String re_number;
	private MemberVO memberVO;//re_m_number; 
	private String re_m_number;
	private int grade1;
	private int grade2;
	private String re_content;
	private ProductVO productVO;     
	private RequestVO requestVO;//re_img_path,
	private String re_p_number;
	private String re_time;
}
