package com.kh.portfolio.board.vo;

import javax.persistence.Entity;

import lombok.Data;

@Entity
@Data
public class FaqVO {

	private String f_number;  //faq번호
	private String f_title; //faq제목
	private String f_content; //faq내용
}
