package com.kh.portfolio.member.svc;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import javax.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import com.kh.portfolio.member.dao.MemberDAO;
import com.kh.portfolio.member.vo.MemberVO;

@Service
public class MemberSVCImpl implements MemberSVC {
	private static final Logger logger = LoggerFactory.getLogger(MemberSVCImpl.class);
	@Inject
	@Qualifier("memberDAOImplXML")
	MemberDAO memberDAO;

	// 회원 등록
	@Override
	public int joinMember(MemberVO memberVO) {
		int result = 0;
		result = memberDAO.joinMember(memberVO);
		return result;
	}

	// 회원 수정
	@Override
	public int modifyMember(MemberVO memberVO) {
		int result = 0;

		result = memberDAO.modifyMember(memberVO);

		return result;
	}

	// 회원 전체조회
	@Override
	public List<MemberVO> listAllMember() {
		List<MemberVO> result = null;

		result = memberDAO.listAllMember();

		return result;
	}

	// 회원 개별조회
	@Override
	public MemberVO listOneMember(String id) {
		MemberVO memberVO = null;

		memberVO = memberDAO.listOneMember(id);

		return memberVO;
	}

	// 회원 탈퇴
	@Override
	public int outMember(String id, String pw) {
		int result = 0;

		result = memberDAO.outMember(id, pw);

		return result;
	}

	// 로그인
	@Override
	public MemberVO login(String id, String pw) {
		return null;
	}

	// 아이디 찾기
	@Override
	public String findID(String name, String email) {
		String id = null;
		id = memberDAO.findID(name, email);
		return id;
	}

	// 비밀번호 찾기
	@Override
	public String findPW(String id, String email) {
		String pw = null;
		pw = memberDAO.findPW(id, email);
		return pw;
	}

	// 비밀번호 변경
	@Override
	public int changePW(String id, String prepw, String postpw) {
		int result = 0;
		result = memberDAO.changePW(id, prepw, postpw);
		return result;
	}

	// 프로파일 이미지 조회
	@Override
	public byte[] findProfileImg(String id) {
		return null;
	}

	// 아이디 중복확인
	@Override
	public MemberVO checkID(String id) {
		MemberVO memberVO = null;

		memberVO = memberDAO.checkID(id);
		return memberVO;
	}
	// 자동로그인 체크한 경우에 사용자 테이블에 세션과 유효시간을 저장하기 위한 메서드
	@Override
	public int keepLogin(String id, String sessionId, Date next) {
		int result = 0;
		result = memberDAO.keepLogin(id, sessionId, next);
		return result;
	}
	// 이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크한다.
	@Override
	public MemberVO checkUserWithSessionKey(String sessionId) {
		return memberDAO.checkUserWithSessionKey(sessionId);
	}
	// 판매수량 1증가
	@Override
	public int reviewsellerevaluation(String m_number, String evaluation1, String evaluation2) {
		int result = 0;
		result = memberDAO.reviewsellerevaluation(m_number, evaluation1, evaluation2);
		return result;
	}

	@Override
	public int sellerquntityplus(String m_number) {
		int result = 0;
		result = memberDAO.sellerquntityplus(m_number);
		return result;
	}

//이메일 중복 체크
	@Override
	public MemberVO checkEmail(String email) {
		MemberVO memberVO = null;
		memberVO = memberDAO.checkEmail(email);
		return memberVO;
	}

	// 락변경
	@Override
	public int changelock(String id, String m_lock) {
		int result = 0;
		result = memberDAO.changelock(id, m_lock);
		return result;
	}
	// 관리자 권한체크
	@Override
	public MemberVO checkadmin(String id) {
		MemberVO memberVO = null;
		memberVO = memberDAO.checkadmin(id);
		return memberVO;
	}

}