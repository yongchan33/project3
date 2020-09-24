package com.kh.portfolio.member.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberVO {
	private String 	m_number;	//회원번호
	private String 		id;					//	ID	VARCHAR2(40 BYTE)	No		1	이메일 ex)admin@google.com
	private String 		pw;					//	PW	VARCHAR2(10 BYTE)	No		2	8~10자리, 특수문자 포함
	private String 		tel;				//	TEL	VARCHAR2(13 BYTE)	Yes		3	'-'포함 ex)010-1234-5678
	private String name;
	private String 		gender;			//	GENDER	CHAR(3 BYTE)	Yes		5	성별 ex)'남','녀'
	private String  address;
	private Date		birth;			//	BIRTH	DATE	Yes		7	생년월일
	private Timestamp cdate;			//	CDATE	TIMESTAMP(6)	Yes	"systimestamp "	8	생성일시
	private Timestamp udate;			////	UDATE	TIMESTAMP(6)	Yes		9	수정일시
	private int height;	//키
	private int weight;	//몸무게
	private String email;	//메일
	private String category1;//선호카테고리1
	private String category2;//선호카테고리2
	private String category3;//선호카테고리3
	private String m_grade1;//고객만족도
	private String m_grade2;//상품만족도
	private String quantitiy;//판매수량
	private String m_size;//사이즈
	private String m_lock;//잠금여부
	private String m_level;//레벨
	private MemberCategoryVO MemberCategoryVO; //
//	private String nickname;
}
