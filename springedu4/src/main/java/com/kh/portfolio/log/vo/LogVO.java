package com.kh.portfolio.log.vo;

import java.sql.Timestamp;

import com.kh.portfolio.member.vo.MemberVO;

import lombok.Data;

@Data
public class LogVO {
	private String l_number;
	private String l_action;
	private Timestamp l_time; 
	private String l_m_number;
	private String l_category; 
	private  MemberVO memberVO;

}
