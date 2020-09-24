package com.kh.portfolio.member.dao;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import com.kh.portfolio.member.vo.MemberVO;

@Repository
public class MemberDAOImplXML implements MemberDAO {
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImplXML.class);
	@Inject
	private SqlSession sqlSession;

	// 회원 등록
	@Override
	public int joinMember(MemberVO memberVO) {
//		logger.info("MemberDAOImplXML.joinMember(MemberVO memberVO) 호출됨");	
		return sqlSession.insert("mappers.MemberDAO-mapper.joinMember", memberVO);
	}

	// 회원 수정
	@Override
	public int modifyMember(MemberVO memberVO) {
//		logger.info("MemberDAOImplXML.modifyMember(MemberVO memberVO) 호출됨");	
		return sqlSession.update("mappers.MemberDAO-mapper.modifyMember", memberVO);
	}

	// 회원 전체조회
	@Override
	public List<MemberVO> listAllMember() {
//		logger.info("MemberDAOImplXML.listAllMember() 호출됨");
		return sqlSession.selectList("mappers.MemberDAO-mapper.listAllMember");
	}

	// 회원 개별조회
	@Override
	public MemberVO listOneMember(String id) {
//		logger.info("MemberDAOImplXML.listOneMember(String id) 호출됨");
		return sqlSession.selectOne("mappers.MemberDAO-mapper.listOneMember", id);
	}

	// 회원 탈퇴
	@Override
	public int outMember(String id, String pw) {
//		logger.info("MemberDAOImplXML.outMember(String id, String pw) 호출됨");
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("pw", pw);

		return sqlSession.delete("mappers.MemberDAO-mapper.outMember", map);
	}

	// 로그인
	@Override
	public MemberVO login(String id, String pw) {
//		logger.info("MemberDAOImplXML.login(String id, String pw) 호출됨");
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("pw", pw);
		return sqlSession.selectOne("mappers.MemberDAO-mapper.login", map);
	}

	// 아이디 찾기
	@Override
	public String findID(String name, String email) {
//		logger.info("MemberDAOImplXML.findID(String tel, Date birth) 호출됨");
		MemberVO memberVO = new MemberVO();
		memberVO.setName(name);
		memberVO.setEmail(email);
		return sqlSession.selectOne("mappers.MemberDAO-mapper.findID", memberVO);
	}

	// 비밀번호 찾기
	@Override
	public String findPW(String id, String email) {
//		logger.info("MemberDAOImplXML.findPW(String id, String tel, Date birth) 호출됨");
		MemberVO memberVO = new MemberVO();
		memberVO.setId(id);
		memberVO.setEmail(email);
		return sqlSession.selectOne("mappers.MemberDAO-mapper.findPW", memberVO);
	}

	// 비밀번호 변경
	@Override
	public int changePW(String id, String prepw, String postpw) {
//		logger.info("MemberDAOImplXML.changePW(String id, String pw) 호출됨");
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("prepw", prepw);
		map.put("postpw", postpw);
		return sqlSession.update("mappers.MemberDAO-mapper.changePW", map);
	}

	// 프로파일 이미지 조회
	@Override
	public byte[] findProfileImg(String id) {
		return null;
	}

	// 아이디 중복체크
	@Override
	public MemberVO checkID(String id) {
		return sqlSession.selectOne("mappers.MemberDAO-mapper.checkID", id);
	}

	// 이메일 중복체크
	@Override
	public MemberVO checkEmail(String email) {
		return sqlSession.selectOne("mappers.MemberDAO-mapper.checkEmail", email);
	}

	// 로그인유지
	// 자동로그인 체크한 경우에 사용자 테이블에 세션과 유효시간을 저장하기 위한 메서드
	public int keepLogin(String id, String sessionId, Date next) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("sessionId", sessionId);
		map.put("next", next);
		logger.info("DAOLOGIN" + id + sessionId + next);
		// Mapper.xml로 데이터를 전달할 때 한 객체밖에 전달 못함으로 map으로 묶어서 보내줌 단... 주의할 점은
		// Mapper.xml 안에서 #{} 이 안에 지정한 이름이랑 같아야함.. 자동으로 매핑될 수 있도록
		// 아래가 수행되면서, 사용자 테이블에 세션id와 유효시간이 저장됨
		return sqlSession.update("mappers.MemberDAO-mapper.keepLogin", map);

	}

	// 이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크한다.
	public MemberVO checkUserWithSessionKey(String sessionId) {
		// 유효시간이 남아있고(>now()) 전달받은 세션 id와 일치하는 사용자 정보를 꺼낸다.
		return sqlSession.selectOne("mappers.MemberDAO-mapper.checkUserWithSessionKey", sessionId);

	}

	// 리뷰작성 시 판매자 평점,판매량 반영
	@Override
	public int reviewsellerevaluation(String m_number, String evaluation1, String evaluation2) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("m_number", m_number);
		map.put("evaluation1", evaluation1);
		map.put("evaluation2", evaluation2);

		return sqlSession.update("mappers.MemberDAO-mapper.reviewsellerevaluation", map);
	}

	// 판매수량 1증가
	@Override
	public int sellerquntityplus(String m_number) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("m_number", m_number);
		return sqlSession.update("mappers.MemberDAO-mapper.sellerquntityplus", map);
	}

	// 맴버 상태 변경
	@Override
	public int changelock(String id, String m_lock) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("m_lock", m_lock);
		return sqlSession.update("mappers.MemberDAO-mapper.changelock", map);
	}

	// 관리자 권한 확인
	@Override
	public MemberVO checkadmin(String id) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		return sqlSession.selectOne("mappers.MemberDAO-mapper.checkadmin", map);
	}

}