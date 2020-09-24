package com.kh.portfolio.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.portfolio.board.svc.BoardSVC;
import com.kh.portfolio.common.PasswordGeneratorSVC;
import com.kh.portfolio.common.mail.MailService;
import com.kh.portfolio.member.svc.MemberSVC;
import com.kh.portfolio.member.vo.MemberVO;
import com.kh.portfolio.product.svc.ProductSVC;
import com.kh.portfolio.product.vo.ProductVO;
import com.kh.portfolio.transaction.svc.TransactionSVC;

@Controller
@RequestMapping("/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Inject
	MemberSVC memberSVC;
	@Inject
	PasswordGeneratorSVC passwordGeneratorSVC;
	@Inject
	MailService mailService;
	@Inject
	ProductSVC productSVC;
	@Inject
	TransactionSVC transactionSVC;
	@Inject
	BoardSVC boardSVC;

	String sessionid;

	// 회원가입 화면
	@GetMapping("/joinForm")
	public String joinForm() {
		return "/member/joinForm";
	}

	// 회원가입처리
	@PostMapping("/join")
	public String join(MemberVO memberVO, Model model) {
		try {
			String c_num = memberVO.getMemberCategoryVO().getC_number();
			String str1 = c_num;
			String[] categorys = str1.split(",");
			for (int i = 0; i < categorys.length; i++) {
				System.out.println(categorys[i]);
				if (categorys.length == 1) {
					memberVO.setCategory1(categorys[0].trim());
				} else if (categorys.length == 2) {
					memberVO.setCategory1(categorys[0].trim());
					memberVO.setCategory2(categorys[1].trim());
				}

				else if (categorys.length == 3) {
					memberVO.setCategory1(categorys[0].trim());
					memberVO.setCategory2(categorys[1].trim());
					memberVO.setCategory3(categorys[2].trim());
				}

			}
		} catch (Exception e) {

			e.printStackTrace();
		}
		int height = memberVO.getHeight();
		int weight = memberVO.getWeight();
		String gender = memberVO.getGender();

		if (gender.equals("여")) {
			if (70 <= weight) {
				if (height >= 160) {
					memberVO.setM_size("XL");
				} else if (height >= 140) {
					memberVO.setM_size("L");
				} else {
					memberVO.setM_size("XXL");
				}
			} else if (60 <= weight) {
				if (height >= 160) {
					memberVO.setM_size("L");
				} else if (height >= 140) {
					memberVO.setM_size("M");
				} else {
					memberVO.setM_size("XL");
				}
			} else if (46 <= weight) {
				if (height >= 170) {
					memberVO.setM_size("XL");
				} else if (height >= 140) {
					memberVO.setM_size("S");
				} else {
					memberVO.setM_size("L");
				}
			} else if (40 < weight) {
				if (height >= 170) {
					memberVO.setM_size("L");
				} else if (height >= 140) {
					memberVO.setM_size("S");
				} else {
					memberVO.setM_size("M");
				}
			} else if (40 >= weight) {
				if (height >= 170) {
					memberVO.setM_size("M");
				} else {
					memberVO.setM_size("S");

				}
			}
		} else if (gender.equals("남")) {
			if (90 <= weight) {
				if (height >= 170) {
					memberVO.setM_size("XL");
				} else if (height >= 160) {
					memberVO.setM_size("L");
				} else {
					memberVO.setM_size("XXL");
				}
			} else if (70 <= weight) {
				if (height >= 170) {
					memberVO.setM_size("L");
				} else if (height >= 160) {
					memberVO.setM_size("M");
				} else {
					memberVO.setM_size("XL");
				}
			} else if (65 <= weight) {
				if (height >= 180) {
					memberVO.setM_size("XL");
				} else if (height >= 160) {
					memberVO.setM_size("M");
				} else {
					memberVO.setM_size("L");
				}
			} else if (60 < weight) {
				if (height >= 180) {
					memberVO.setM_size("L");
				} else if (height >= 160) {
					memberVO.setM_size("S");
				} else {
					memberVO.setM_size("M");
				}
			} else if (60 >= weight) {
				if (height >= 180) {
					memberVO.setM_size("M");
				} else {
					memberVO.setM_size("S");
				}
			}
		}

		int result = memberSVC.joinMember(memberVO);
		if (result == 1) {
			return "/member/loginForm";
		} else {
			model.addAttribute("svr_msg", "error");
			return "/member/joinForm";
		}
	}

	// 내정보
	@GetMapping({ "/myInfo", "/myInfo/{reqPage}" })
	public String mypage(HttpSession session, Model model) {
		String id = ((MemberVO) session.getAttribute("member")).getId();
		// 프로덕트 리스트 필요.
		// member 아이디 / 이름 /평점(후기내역에서포함) / 연락처 / 이메일 / 주소
		MemberVO memberVO = memberSVC.listOneMember(id);
		if (!memberVO.getQuantitiy().equals('0')) {
			// 평점계산
			double grade1 = Double.parseDouble(memberVO.getM_grade1()) / Double.parseDouble(memberVO.getQuantitiy());
			double grade2 = Double.parseDouble(memberVO.getM_grade2()) / Double.parseDouble(memberVO.getQuantitiy());
			logger.info("grade1/" + grade1);
			if (Double.isNaN(grade1)) {
				model.addAttribute("grade1", 0); // 유의미한지 보기
				model.addAttribute("grade2", 0); // 유의미한지 보기
			} else {
				model.addAttribute("grade1", grade1); // 유의미한지 보기
				model.addAttribute("grade2", grade2); // 유의미한지 보기
			}
		}

		// 내상품 판매 리스트,페이징
		// 세션 내정보 받아옴.
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		// 판매중상품 스크롤
		model.addAttribute("myproduct", productSVC.myallproduct(m_number));
		// 리뷰평가 리스트
		model.addAttribute("myrelist", boardSVC.myrelist(m_number));
		model.addAttribute("member", memberVO);

		return "/member/myInfo";
	}

	// 유저정보
	@GetMapping({ "/userInfo", "/userInfo/{id}" })
	public String userpage(HttpSession session, Model model, @PathVariable(value = "id", required = false) String id) {
		// 프로덕트 리스트 필요.
		// member 아이디 / 이름 /평점(후기내역에서포함) / 연락처 / 이메일 / 주소
		MemberVO memberVO = memberSVC.listOneMember(id);
		String m_number = memberVO.getM_number();
		if (!memberVO.getQuantitiy().equals('0')) {
			// 평점계산
			double grade1 = Double.parseDouble(memberVO.getM_grade1()) / Double.parseDouble(memberVO.getQuantitiy());
			double grade2 = Double.parseDouble(memberVO.getM_grade2()) / Double.parseDouble(memberVO.getQuantitiy());
			if (Double.isNaN(grade1)) {
				model.addAttribute("grade1", 0); // 유의미한지 보기
				model.addAttribute("grade2", 0); // 유의미한지 보기
			} else {
				model.addAttribute("grade1", grade1); // 유의미한지 보기
				model.addAttribute("grade2", grade2); // 유의미한지 보기
			}
		}

		// 판매중상품 스크롤
		model.addAttribute("myproduct", productSVC.myallproduct(m_number));

		// 리뷰평가 리스트
		model.addAttribute("myrelist", boardSVC.myrelist(m_number));
		model.addAttribute("member", memberVO);

		return "/member/userInfo";
	}

	// 회원정보수정 화면
	@GetMapping("/modifyForm")
	public String modifyForm() {
		return "/member/modifyForm";
	}

	// 회원정보수정 처리
	@PostMapping("/modify")
	public String modify(MemberVO memberVO, Model model, HttpSession session) {
		try {
			String c_num = memberVO.getMemberCategoryVO().getC_number();
			String str1 = c_num;
			String[] categorys = str1.split(",");
			for (int i = 0; i < categorys.length; i++) {
				System.out.println(categorys[i]);
				if (categorys.length == 1) {
					memberVO.setCategory1(categorys[0].trim());
				} else if (categorys.length == 2) {
					memberVO.setCategory1(categorys[0].trim());
					memberVO.setCategory2(categorys[1].trim());
				}

				else if (categorys.length == 3) {
					memberVO.setCategory1(categorys[0].trim());
					memberVO.setCategory2(categorys[1].trim());
					memberVO.setCategory3(categorys[2].trim());
				}

			}
			System.out.println("카테고리1" + memberVO.getCategory1());
			System.out.println("카테고리2" + memberVO.getCategory2());
			System.out.println("카테고리3" + memberVO.getCategory3());
		} catch (Exception e) {

			e.printStackTrace();
		}
		int height = memberVO.getHeight();
		int weight = memberVO.getWeight();
		String gender = memberVO.getGender();

		if (gender.equals("여")) {
			if (70 <= weight) {
				if (height >= 160) {
					memberVO.setM_size("XL");
				} else if (height >= 140) {
					memberVO.setM_size("L");
				} else {
					memberVO.setM_size("XXL");
				}
			} else if (60 <= weight) {
				if (height >= 160) {
					memberVO.setM_size("L");
				} else if (height >= 140) {
					memberVO.setM_size("M");
				} else {
					memberVO.setM_size("XL");
				}
			} else if (46 <= weight) {
				if (height >= 170) {
					memberVO.setM_size("XL");
				} else if (height >= 140) {
					memberVO.setM_size("S");
				} else {
					memberVO.setM_size("L");
				}
			} else if (40 < weight) {
				if (height >= 170) {
					memberVO.setM_size("L");
				} else if (height >= 140) {
					memberVO.setM_size("S");
				} else {
					memberVO.setM_size("M");
				}
			} else if (40 >= weight) {
				if (height >= 170) {
					memberVO.setM_size("M");
				} else {
					memberVO.setM_size("S");

				}
			}
		} else if (gender.equals("남")) {
			if (90 <= weight) {
				if (height >= 170) {
					memberVO.setM_size("XL");
				} else if (height >= 160) {
					memberVO.setM_size("L");
				} else {
					memberVO.setM_size("XXL");
				}
			} else if (70 <= weight) {
				if (height >= 170) {
					memberVO.setM_size("L");
				} else if (height >= 160) {
					memberVO.setM_size("M");
				} else {
					memberVO.setM_size("XL");
				}
			} else if (65 <= weight) {
				if (height >= 180) {
					memberVO.setM_size("XL");
				} else if (height >= 160) {
					memberVO.setM_size("M");
				} else {
					memberVO.setM_size("L");
				}
			} else if (60 < weight) {
				if (height >= 180) {
					memberVO.setM_size("L");
				} else if (height >= 160) {
					memberVO.setM_size("S");
				} else {
					memberVO.setM_size("M");
				}
			} else if (60 >= weight) {
				if (height >= 180) {
					memberVO.setM_size("M");
				} else {
					memberVO.setM_size("S");
				}
			}
		}
		int result = memberSVC.modifyMember(memberVO);
		// 세션에서 id정보를 가져온다.
		String id = ((MemberVO) session.getAttribute("member")).getId();
		// 수정된 회원 정보를 다시 읽어온다.
		session.setAttribute("member", memberSVC.listOneMember(id));
		return "redirect:/member/modifyForm";
	}

	// 비밀번호 변경 화면
	@GetMapping("/changePWForm")
	public String changePWForm() {
		return "/member/changePWForm";
	}

	// 비밀번호 변경 처리
	@PostMapping("/changePW")
	public String changePW(@RequestParam("id") String id, @RequestParam("prepw") String prepw,
			@RequestParam("postpw") String postpw, Model model) {
		int result = memberSVC.changePW(id, prepw, postpw);
		// 비밀번호가 일치하지 않을경우
		if (result == 1) {
			logger.info("result="+result);
			model.addAttribute("changemsg", "비밀번호 변경완료.");
			
		}
		return "redirect:/member/changePWForm";
	}

	// 회원탈퇴 화면
	@GetMapping("/outMemberForm")
	public String outMemberForm() {
		return "/member/outMemberForm";
	}

	// 회원탈퇴 처리
		@PostMapping("/outMember")
		public String outMember(@RequestParam("id") String id, @RequestParam("pw") String pw, HttpSession session,
				Model model) {
			String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
			List<ProductVO> list = null;
			list = transactionSVC.outmembercheck(m_number);
			logger.info("list"+list);
			if(list != null) {
				
				model.addAttribute("svr_msg", "거래중인 상품이 있습니다. 거래완료 후 회원탈퇴가 가능합니다.");
				return "/member/outMemberForm";
			}
			
			int result = memberSVC.outMember(id, pw);
			if (result != 1) {
				model.addAttribute("svr_msg", "비밀번호가 일치하지 않습니다.");
				return "/member/outMemberForm";
			} else {
				// 2) 세션정보 제거
				session.invalidate();
			}
			return "redirect:/";
		}

	// 아이디 찾기 화면
	@GetMapping("/findIDForm")
	public String findIDForm() {
		return "/member/findIDForm";
	}

	// 아이디 찾기(Restfull 처리, 응답포맷:JSON)
	@PostMapping(value = "/id", produces = "application/json")
	@ResponseBody
	public ResponseEntity<Map> findID(@RequestBody MemberVO memberVO) {
		ResponseEntity<Map> res = null;
		String findID = null;
		findID = memberSVC.findID(memberVO.getName(), memberVO.getEmail());
		Map<String, Object> map = new HashMap<>();
		// 아이디를 찾았으면
		if (findID != null) {
			map.put("rtcode", "00");
			map.put("result", findID);
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200
		} else {
			map.put("rtcode", "01");
			map.put("result", "찾고자 하는 아이디가 없습니다.");
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200
		}
		return res;
	}

	// 비밀번호 찾기 화면
	@GetMapping("/findPWForm")
	public String findPWForm() {
		return "/member/findPWForm";
	}

	// 비밀번호 찾기(Restfull 처리, 응답포맷:JSON)
	@PostMapping(value = "/pw", produces = "application/json")
	@ResponseBody
	public ResponseEntity<Map> findPW(@RequestBody MemberVO memberVO) {
		ResponseEntity<Map> res = null;
		String findPW = null;
		// 문자열 birth를 java.sql.Date타입으로 변환
		memberVO.setBirth(java.sql.Date.valueOf(memberVO.getBirth().toString()));
		findPW = memberSVC.findPW(memberVO.getId(), memberVO.getEmail());
		Map<String, Object> map = new HashMap<>();
		// 비밀번호를 찾았으면
		if (findPW != null) {
			map.put("rtcode", "00");
			map.put("result", findPW);
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200
		} else {
			map.put("rtcode", "01");
			map.put("result", "찾고자 하는 아이디가 없습니다.");
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200
		}
		return res;
	}

	// 임시비밀번호생성(Restfull 처리, 응답포맷:JSON)
	@PostMapping(value = "/pwmail", produces = "application/json")
	@ResponseBody
	public ResponseEntity<Map> findPWMail(@RequestBody MemberVO memberVO, HttpServletRequest request,
			HttpServletResponse response) {
		ResponseEntity<Map> res = null;
		String findPW = null;
		// 문자열 birth를 java.sql.Date타입으로 변환

		findPW = memberSVC.findPW(memberVO.getId(), memberVO.getEmail());
		Map<String, Object> map = new HashMap<>();
		// 1)비밀번호를 찾았으면
		if (findPW != null) {
			// 2)임시비번호 생성
			String tmpPassword = passwordGeneratorSVC.geneterPassword(6);
			// 3)임시밀번호로 비밀번호변경
			memberSVC.changePW(memberVO.getId(), findPW, tmpPassword);
			// 4)메일전송
			String mailTitle = "신규 비밀번호 발송";
			// 로긴주소
			StringBuffer url = new StringBuffer();
			url.append("http://" + request.getServerName());
			url.append(":" + request.getServerPort());
			url.append(request.getContextPath());
			url.append("/loginForm?id=" + memberVO.getEmail());
			// 메일본문내용
			StringBuffer sb = new StringBuffer();
			sb.append("<html><body>");
			sb.append("<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>");
			sb.append("<h1>" + "신규비밀번호" + "<h1><br>");
			sb.append("아래 비밀번호로 로그인 하셔서 비밀번호를 변경하세요.<br><br>");
			sb.append("<b>비밀번호 : </b>");
			sb.append(tmpPassword + "<br><br>");
			sb.append("<a href='" + url.toString() + "'>로그인</a>");
			sb.append("</body></html>");
			mailService.sendMail(memberVO.getEmail(), mailTitle, sb.toString());
//			logger.info("메일을 발송하였습니다.!!");
			map.put("rtcode", "00");
			map.put("result", "임시비밀번호가 메일로 전송되었습니다");
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200

		} else {

			map.put("rtcode", "01");
			map.put("result", "비밀번호를 찾을 수  없습니다.");
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200
		}
		return res;
	}

	// 이메일인증(Restfull 처리, 응답포맷:JSON)
	@PostMapping(value = "/checkmail", produces = "application/json")
	@ResponseBody
	public ResponseEntity<Map> checkmail(@RequestBody String email, HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("호출됨!이메일");
		System.out.println(email);

		ResponseEntity<Map> res = null;
		MemberVO memberVO = memberSVC.checkEmail(email);
		Map<String, Object> map = new HashMap<>();
		if (memberVO == null) {
			// 2)임시비번호 생성
			String emailcheck = passwordGeneratorSVC.geneterPassword(6);
			System.out.println("인증번호" + emailcheck);
			String mailTitle = "인증번호 발송";
			// 4)메일전송
			// 로긴주소
			StringBuffer url = new StringBuffer();
			url.append("http://" + request.getServerName());
			url.append(":" + request.getServerPort());
			url.append(request.getContextPath());
			url.append("/loginForm?id=" + email);
			// 메일본문내용
			StringBuffer sb = new StringBuffer();
			sb.append("<html><body>");
			sb.append("<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>");
			sb.append("<h1>" + "인증번호" + "<h1><br>");
			sb.append("<br><br>");
			sb.append("<b>인증번호 : </b>");
			sb.append(emailcheck + "<br><br>");
			sb.append("<a href='" + url.toString() + "'>로그인</a>");
			sb.append("</body></html>");
			mailService.sendMail(email, mailTitle, sb.toString());
//				logger.info("메일을 발송하였습니다.!!");
			map.put("rtcode", "00");
			map.put("result", emailcheck);
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200
		} else {
			map.put("rtcode", "01");
			map.put("result", "중복입니다. 이메일을 다시 체크 해주세요.");
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200

		}

		return res;
	}

	// 아이디 비밀번호찾기 / 이메일인증(Restfull 처리, 응답포맷:JSON)
	@PostMapping(value = "/findcheckmail", produces = "application/json")
	@ResponseBody
	public ResponseEntity<Map> findcheckmail(@RequestBody String email, HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("호출됨!이메일");
		System.out.println(email);

		ResponseEntity<Map> res = null;
		MemberVO memberVO = memberSVC.checkEmail(email);
		Map<String, Object> map = new HashMap<>();
		if (memberVO == null) {
			map.put("rtcode", "01");
			map.put("result", "존재하지 않는 이메일 입니다. 이메일을 다시 확인해주세요.");
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200

		} else {

			// 2)임시비번호 생성
			String emailcheck = passwordGeneratorSVC.geneterPassword(6);
			System.out.println("인증번호" + emailcheck);
			String mailTitle = "인증번호 발송";
			// 4)메일전송
			// 로긴주소
			StringBuffer url = new StringBuffer();
			url.append("http://" + request.getServerName());
			url.append(":" + request.getServerPort());
			url.append(request.getContextPath());
			url.append("/loginForm?id=" + email);
			// 메일본문내용
			StringBuffer sb = new StringBuffer();
			sb.append("<html><body>");
			sb.append("<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>");
			sb.append("<h1>" + "인증번호" + "<h1><br>");
			sb.append("<br><br>");
			sb.append("<b>인증번호 : </b>");
			sb.append(emailcheck + "<br><br>");
			sb.append("<a href='" + url.toString() + "'>로그인</a>");
			sb.append("</body></html>");
			mailService.sendMail(email, mailTitle, sb.toString());
//					logger.info("메일을 발송하였습니다.!!");
			map.put("rtcode", "00");
			map.put("result", emailcheck);
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200

		}

		return res;
	}

	// 아이디 중복체크
	@PostMapping(value = "/checkid", produces = "application/json")
	@ResponseBody
	public ResponseEntity<Map> checkID(@RequestBody String checkid) {
		ResponseEntity<Map> res = null;
		int checkID = 0;
		MemberVO memberVO = memberSVC.checkID(checkid);
		Map<String, Object> map = new HashMap<>();
		if (memberVO == null) {
			map.put("rtcode", "00");
			map.put("result", "사용가능");
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200
		} else {
			map.put("rtcode", "01");
			map.put("result", "중복입니다. 아이디를 다시 체크 해주세요.");
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200
		}
		return res;
	}

	// 관리자페이지
	@GetMapping("/adminPage")
	public String listAllMember(Model model, HttpSession session) {
		List<MemberVO> list = null;
		list = memberSVC.listAllMember();
		for (int i = 0; i < list.size(); i++) {

			double grade1 = Double.parseDouble(list.get(i).getM_grade1())
					/ Double.parseDouble(list.get(i).getQuantitiy());
			double grade2 = Double.parseDouble(list.get(i).getM_grade2())
					/ Double.parseDouble(list.get(i).getQuantitiy());
			if (Double.isNaN(grade1)) {
				list.get(i).setM_grade1("0");
				list.get(i).setM_grade2("0");
			} else {
				list.get(i).setM_grade1(Double.toString(grade1));
				list.get(i).setM_grade2(Double.toString(grade2));
			}
		}
		model.addAttribute("memberlist", list);
		logger.info("model", model);
		String id = ((MemberVO) session.getAttribute("member")).getId();
		sessionid = id;
		return "/member/adminPage";
	}

	// 계정 상태 변경
	@ResponseBody
	@PostMapping(value = "/changestatus", produces = "application/json")
	public ResponseEntity<Map> memberlock(@RequestBody MemberVO memberVO,
			HttpServletRequest request, HttpServletResponse response) {

		ResponseEntity<Map> res = null;
		Map<String, Object> map = new HashMap<>();
		int checkadmin = 0; // 관리자 체크 (0=관리자x, 1=관리자)
		int cnt = 0;

		String m_lock = memberVO.getM_lock();
		String id = memberVO.getId();
		logger.info("m_lock=" + m_lock + "/" + id);
		// 관리자 권한 체크

		MemberVO memberVO2 = null;

		try {
			memberVO2 = memberSVC.checkadmin(sessionid);
			logger.info("memberVO2.getId()=" + sessionid + "checkadmin" + checkadmin);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// 관리자의 경우
		if (memberVO2 != null) {
			// 계정활성화,비활성화
			cnt = memberSVC.changelock(id, m_lock);
		}

		// 성공
		if (cnt == 1) {
			map.put("rtcode", "01");
			if (m_lock.equals("U")) {
				map.put("result", id + "계정 활성화완료.");
			} else if (m_lock.equals("L")) {
				map.put("result", id + "계정 비활성화완료.");
			}

			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200
		} else if (cnt == 0) {
			map.put("rtcode", "00");
			map.put("result", "권한 부족. 관리자로 로그인 해주세요.");
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200
		}
		return res;

	}

}