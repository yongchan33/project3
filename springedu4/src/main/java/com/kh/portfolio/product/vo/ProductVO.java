package com.kh.portfolio.product.vo;

import java.sql.Timestamp;

import com.kh.portfolio.member.vo.MemberCategoryVO;
import com.kh.portfolio.member.vo.MemberVO;
import com.kh.portfolio.transaction.vo.ReviewVO;

import lombok.Data;

@Data
public class ProductVO {

	
	private String p_number; //1	
	private String p_name;//나이키모자	
	private String p_purchase_price; //40000	
	private String p_sale_price; //20000	
	private String p_brand; //나이키	
	private String p_condition; //3
	private String p_size; //	3  
	private String p_transaction; //	1	
	private String p_address; // 울산	
	private String p_xrow; // x좌표
	private String p_ycol; // y좌표
	private String p_img_path; //이미지
	private String p_content; //이미지
	private Timestamp p_time;
	private  MemberVO memberVO; //판매자번호
	private String p_sale_condition; //상품판매상태
	private MemberCategoryVO memberCategoryVO; // 카테고리
	private String gdsThumbImg; // 썸네일
	private ReviewVO reviewVO;
	
	
	
}
