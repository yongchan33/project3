package com.kh.portfolio.member.controller;

import java.sql.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.WebUtils;

import com.kh.portfolio.common.page.FindCriteria;
import com.kh.portfolio.log.svc.LogSVC;
import com.kh.portfolio.log.vo.LogVO;
import com.kh.portfolio.member.svc.MemberSVC;
import com.kh.portfolio.member.vo.MemberVO;
import com.kh.portfolio.product.svc.ProductSVC;

@Controller

public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Inject
	MemberSVC memberSVC;

	@Inject
	ProductSVC productSVC;

	@Inject
	LogSVC logSVC;

	// 로그인 화면
	@GetMapping("/loginForm")
	public String loginForm() {

		return "/member/loginForm";
	}

	// 로그인 처리
	@PostMapping("/login")

	public String login(@RequestParam("id") String id, @RequestParam("pw") String pw,
			@RequestParam("reqURI") String reqURI,
			@RequestParam(value = "login_chk", required = false) String login_chk, HttpSession session,
			HttpServletResponse response, LogVO logVO, Model model) {

		if (login_chk != null) {
			System.out.println("checkbox is checked");
		} else {
			System.out.println("checkbox is not checked");
		}
		MemberVO memberVO = memberSVC.listOneMember(id);

		// 1)회원id가 없는경우
		if (memberVO == null) {
			model.addAttribute("svr_msg", "가입된 회원 정보가 없습니다.");
			return "/member/loginForm";
		} else {
			// 2)회원id가 존재할경우
			// 2-1) 비밀번호가 일치하는경우
			if(memberVO.getM_lock().equals("L")) {
				model.addAttribute("svr_msg", "잠긴 계정입니다. 관리자에게 문의해주세요.");
				return "/member/loginForm";
			}
			
			else if (memberVO.getPw().equals(pw)) {
				session.setAttribute("member", memberVO);
				// 알림 수 설정
				String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
				int transresult = productSVC.gettransFindCriteria(1, m_number).getPageCriteria().getTotalRec();
				int reqresult = productSVC.getreqFindCriteria(1, m_number).getPageCriteria().getTotalRec();
				session.setAttribute("alarmcount", transresult + reqresult);

				// 로그인로그기록
				// 로그기록 시작

				logVO.setL_action("1");
				logVO.setL_m_number(m_number);
				logSVC.addLog(logVO);

				// 로그기록 끝

				/*
				 * [ 세션 추가되는 부분 ]
				 */
				// 1. 로그인이 성공하면, 그 다음으로 로그인 폼에서 쿠키가 체크된 상태로 로그인 요청이 왔는지를 확인한다.
					if (login_chk != null) {// dto 클래스 안에 useCookie 항목에 폼에서 넘어온 쿠키사용
					// * 여부(true/false)가 들어있을 것임 // 쿠키 사용한다는게 체크되어 있으면... // 쿠키를 생성하고 현재 로그인되어 있을 때
					// * 생성되었던 세션의 id를 쿠키에 저장한다.
					Cookie cookie = new Cookie("loginCookie", ((MemberVO) session.getAttribute("member")).getId()); // 쿠키를
																													// 찾을
																													// 경로를
																													// 컨텍스트
																													// 경로로
																													// 변경해
																													// 주고...
					cookie.setPath("/");
					int amount = 60 * 60 * 24 * 7;
					cookie.setMaxAge(amount);// 단위는 (초)임으로 7일정도로 유효시간을 설정해 준다. // 쿠키를 적용해 준다.
					response.addCookie(cookie);
					Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));
					int result = memberSVC.keepLogin(memberVO.getId(),
							((MemberVO) session.getAttribute("member")).getId(), sessionLimit);

				}

			}
			
			
			else {
				// 2-2) 비밀번호가 틀린경우
				model.addAttribute("svr_msg", "비밀번호가 일치하지 않습니다.");
				return "/member/loginForm";
			}

		}

		return "redirect:/" + reqURI;
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response, LogVO logVO) {
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		logVO.setL_action("2");
		logVO.setL_m_number(m_number);
		logSVC.addLog(logVO);
		Object obj = session.getAttribute("member");
		if (obj != null) {
			MemberVO memberVO = (MemberVO) obj;
			// null이 아닐 경우 제거
			session.removeAttribute("member");
			session.invalidate();// 세션 전체를 날려버림
			// 쿠키를 가져와보고
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if (loginCookie != null) {
				// null이 아니면 존재하면!
				loginCookie.setPath("/");
				// 쿠키는 없앨 때 유효시간을 0으로 설정하는 것 !!! invalidate같은거 없음.
				loginCookie.setMaxAge(0);
				// 쿠키 설정을 적용한다.
				response.addCookie(loginCookie);
				// 사용자 테이블에서도 유효기간을 현재시간으로 다시 세팅해줘야함.
				Date date = new Date(System.currentTimeMillis());
				memberSVC.keepLogin(memberVO.getId(), session.getId(), date);
			}
		}
		return "redirect:/";
	}

}
