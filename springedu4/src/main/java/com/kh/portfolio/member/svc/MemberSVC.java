package com.kh.portfolio.member.svc;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import com.kh.portfolio.member.vo.MemberVO;

public interface MemberSVC {
	// 회원 등록
	int joinMember(MemberVO memberVO);

	// 회원 수정
	int modifyMember(MemberVO memberVO);

	// 회원 전체조회
	List<MemberVO> listAllMember();

	// 회원 개별조회
	MemberVO listOneMember(String id);

	// 회원 탈퇴
	int outMember(String id, String pw);

	// 로그인
	MemberVO login(String id, String pw);

	// 아이디 찾기
	String findID(String name, String email);

	// 비밀번호 찾기
	String findPW(String id, String email);

	// 비밀번호 변경
	int changePW(String id, String prepw, String postpw);

	// 프로파일 이미지 조회
	byte[] findProfileImg(String id);

	// 아이디 중복체크
	MemberVO checkID(String id);

	// 이메일 중복체크
	MemberVO checkEmail(String email);

	// 자동로그인 체크한 경우에 사용자 테이블에 세션과 유효시간을 저장하기 위한 메서드
	public int keepLogin(String id, String sessionId, Date next);

	// 이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크한다.
	public MemberVO checkUserWithSessionKey(String sessionId);

	// 판매자 평점, 상품평점, 판매수량 1증가
	int reviewsellerevaluation(String m_number, String evaluation1, String evaluation2);

	// 판매수량 1증가
	int sellerquntityplus(String m_number);

	// 맴버 락
	int changelock(String id, String m_lock);

	// 관리자 권한체크
	MemberVO checkadmin(String id);

}