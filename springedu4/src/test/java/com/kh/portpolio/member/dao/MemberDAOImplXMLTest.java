package com.kh.portpolio.member.dao;

import java.sql.Date;
import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.kh.portfolio.member.dao.MemberDAO;
import com.kh.portfolio.member.vo.MemberVO;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/*.xml"})
public class MemberDAOImplXMLTest {

	private final static Logger logger
		= LoggerFactory.getLogger(MemberDAOImplXMLTest.class);
	
	@Inject
	//@Qualifier : spring 컨테이너에 동일타입의 bean이 존재할경우 명시적으로 참조하고자하는 bean을 지정할때사용
	//spring컨테이너에서 관리되는 bean이름은 특별히 지정해주지 않으면 클래스명을 기본값으로 갖는다(첫글자는 소문자)
	@Qualifier("memberDAOImplXML")
	MemberDAO memberDAO;	

	@Test			//테스트 대상에서 포함할때
	@DisplayName("회원등록")
	
	void joinMember() {
		MemberVO memberVO = new MemberVO();
		memberVO.setM_number("MEMBERS.nextval");
		memberVO.setId("test111");
		memberVO.setPw("test1234");
		memberVO.setTel("010-1234-5678");
		memberVO.setName("관리자");
		memberVO.setGender("남");
		memberVO.setAddress("부산");
		memberVO.setBirth(java.sql.Date.valueOf("2000-01-02"));
		memberVO.setHeight(170);
		memberVO.setWeight(50);
		memberVO.setEmail("1404jsh@Naver.com");
		memberVO.setCategory1("팬츠");
		memberVO.setCategory2("스커트");
		memberVO.setCategory3("원피스");
		int cnt = memberDAO.joinMember(memberVO);
		
		logger.info("cnt:"+cnt);
	}
	
	@Test
	@DisplayName("회원수정")
	@Disabled
	void modifyMember() {
		
		MemberVO memberVO = new MemberVO();
		memberVO.setId("test511");
		memberVO.setPw("test4444");
		memberVO.setTel("010-1234-5678");
		memberVO.setName("관리자4");
		memberVO.setGender("여");
		memberVO.setAddress("경기");
		memberVO.setBirth(java.sql.Date.valueOf("2000-01-03"));
		
		int cnt = memberDAO.modifyMember(memberVO);
		
		Assertions.assertEquals(1,cnt);
		logger.info("cnt:"+cnt);
	}
	
	@Test
	@DisplayName("회원전체조회")
	@Disabled
	void listAllMember() {
		
		List<MemberVO> list = memberDAO.listAllMember();
		
		for(MemberVO memberVO : list) {
			logger.info(memberVO.toString());
		}
	}
	
	@Test
	@DisplayName("회원조회(개인)")
	@Disabled
	void listOneMember() {
		String id = "test511";
		MemberVO memberVO = memberDAO.listOneMember(id);
		logger.info(memberVO.toString());
	}
	
	@Test
	@DisplayName("회원 탈퇴")
	@Disabled
	void outMember() {
		String id = "test12345";
		String pw = "test1234";
		int result = memberDAO.outMember(id, pw);
		Assertions.assertEquals(1, result);
	}
	
	@Test
	@DisplayName("로그인")
	@Disabled
	void login() {
		String id = "test511";
		String pw = "test1234";
		MemberVO memberVO = memberDAO.login(id, pw);
		logger.info(memberVO.toString());
	}	
	
	/*
	 * @Test
	 * 
	 * @DisplayName("아이디 찾기")
	 * 
	 * void findID() { String tel = "010-3206-3801"; //String birth = "2000-03-01";
	 * Date birth = java.sql.Date.valueOf("2020-08-01"); String id =
	 * memberDAO.findID(tel, birth); Assertions.assertEquals("test511", id);
	 * 
	 * }
	 * 
	 * @Test
	 * 
	 * @DisplayName("비밀번호 찾기")
	 * 
	 * @Disabled void findPW() { String id = "test@test.com"; String tel =
	 * "010-3206-3801"; //String birth = "2000-03-01"; Date birth =
	 * java.sql.Date.valueOf("2000-08-01"); String pw =
	 * memberDAO.findPW(id,tel,birth); Assertions.assertEquals("test4444", pw);
	 * 
	 * }
	 * 
	 * @Test
	 * 
	 * @DisplayName("비밀번호변경")
	 * 
	 * @Disabled void changePW() { String id = "test511"; String postpw =
	 * "test1234"; String prepw = "test4444"; int result = memberDAO.changePW(id,
	 * prepw,postpw); // Assertions.assertEquals(1,result);
	 * 
	 * Assertions.assertEquals(postpw,memberDAO.listOneMember(id).getPw()); }
	 */
}
