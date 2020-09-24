package com.kh.portfolio.transaction.controller;

import java.util.Optional;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.portfolio.log.svc.LogSVC;
import com.kh.portfolio.log.vo.LogVO;
import com.kh.portfolio.member.svc.MemberSVC;
import com.kh.portfolio.member.vo.MemberVO;
import com.kh.portfolio.product.svc.ProductSVC;
import com.kh.portfolio.product.vo.ProductVO;
import com.kh.portfolio.transaction.svc.TransactionSVC;
import com.kh.portfolio.transaction.vo.RequestVO;
import com.kh.portfolio.transaction.vo.ReviewVO;
import com.kh.portfolio.transaction.vo.TransactionVO;

@Controller
@RequestMapping("/transaction")
public class TransactionController {
	private static final Logger logger = LoggerFactory.getLogger(TransactionController.class);
	@Inject
	ProductSVC productSVC;
	@Inject
	LogSVC logSVC;
	@Inject
	MemberSVC memberSVC;
	@Inject
	TransactionSVC transactionSVC;

	// 거래요청양식
	@GetMapping("/transactionForm")
	public String transactionForm(RequestVO requestVO, Model model) {
		model.addAttribute("requestVO", requestVO);
		return "/transaction/transactionForm";
	}

	// 구매요청 수락
	@Transactional
	@PostMapping({ "/transaction", "/transaction/{requestnumber}" })
	public String transaction(TransactionVO transactionVO, HttpSession session, RequestVO requestVO, LogVO logVO,
			Model model, @PathVariable("requestnumber") String requestnumber, @RequestParam String t_content) {
		logger.info("transaction 도착");
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		session.removeAttribute("alarmcount");
		// 알림카운트
		int transresult = productSVC.gettransFindCriteria(1, m_number).getPageCriteria().getTotalRec();
		int reqresult = productSVC.getreqFindCriteria(1, m_number).getPageCriteria().getTotalRec();
		session.setAttribute("alarmcount", transresult + reqresult);
		// 알림카운트 끝
		String t_content1 = transactionVO.getT_content();
		String t_content2 = t_content;
		// 거래요청 수락 내용삽입
		int insertresult = transactionSVC.transaction(requestnumber, m_number, t_content);
		// 거래요청 상태변경('1' 대기 -> '2' 수락)
		int allowsult = transactionSVC.allowreqest(requestnumber, m_number);
		// 거래중으로 변경(판매중->거래중)
		int updateresult = transactionSVC.updatecondition(requestnumber, m_number);
		// 수락 시 동일상품 구매요청 거절처리
		int canclesamereq = transactionSVC.canclesamerequest(requestnumber);

		// 수락로그기록

		logVO.setL_action("5"); //
		logVO.setL_m_number(m_number);
		logSVC.addLog(logVO);
		return "redirect:/transaction/request_notice";

	}

	// 거래완료
	@Transactional
	@PostMapping("/transactionfinish")
	public String transactionfinish(TransactionVO transactionVO, HttpSession session, RequestVO requestVO, LogVO logVO,
			Model model, @RequestParam("p_number") String p_number) {
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		// 알림카운트
		session.removeAttribute("alarmcount");
		int transresult = productSVC.gettransFindCriteria(1, m_number).getPageCriteria().getTotalRec();
		int reqresult = productSVC.getreqFindCriteria(1, m_number).getPageCriteria().getTotalRec();
		session.setAttribute("alarmcount", transresult + reqresult);

		// 거래완료 상태로 변경
		int presult = transactionSVC.transactionfinish(p_number);
		// 거래 상태도 변경해야댐.transaction_condition '1' -> '2'
		int tresult = transactionSVC.finishtcondition(p_number, m_number);

		// 수락로그기록
		logVO.setL_action("5"); //
		logVO.setL_m_number(m_number);
		logSVC.addLog(logVO);
		return "redirect:/transaction/transaction_notice";

	}

	// 후기작성
	@Transactional
	@PostMapping("/review")
	public String review(ReviewVO reviewVO, LogVO logVO, Model model, HttpSession session,
			@RequestParam("p_number") String p_number) throws Exception {
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		// 알림카운트
		session.removeAttribute("alarmcount");
		int transresult = productSVC.gettransFindCriteria(1, m_number).getPageCriteria().getTotalRec();
		int reqresult = productSVC.getreqFindCriteria(1, m_number).getPageCriteria().getTotalRec();
		session.setAttribute("alarmcount", transresult + reqresult);
		reviewVO.setRe_m_number(m_number);
		ProductVO productVO = productSVC.productInfo(p_number);
		reviewVO.setProductVO(productVO);
		// 거래완료 상태로 변경
		int presult = transactionSVC.transactionfinish(p_number);
		// 거래 상태도 변경해야댐.transaction_condition '1' -> '2'
		int tresult = transactionSVC.finishtcondition(p_number, m_number);
		// 후기작성
		int result = transactionSVC.review(reviewVO);

		String evaluation1 = Integer.toString(reviewVO.getGrade1());
		String evaluation2 = Integer.toString(reviewVO.getGrade2());

		// 판매자 평점, 상품평점, 판매수량 1증가
		int evaluation = memberSVC.reviewsellerevaluation(reviewVO.getProductVO().getMemberVO().getM_number(),
				evaluation1, evaluation2);

		logVO.setL_action("8"); // 리뷰작성
		logVO.setL_m_number(m_number);
		logVO.setL_category(productVO.getMemberCategoryVO().getC_number());
		if (result == 1) {
			model.addAttribute("reviewVO", reviewVO);
			model.addAttribute("productVO", productVO);
			return "redirect:/transaction/transaction_notice";
		} else {
			model.addAttribute("svr_msg", "error");
			return "redirect:/transaction/transaction_notice";

		}

	}

	// 구매요청 거절, 트랜잭션
	@Transactional
	@PostMapping({ "/canclerequest", "/canclerequest/{requestnumber}" })
	public String canclerequest(TransactionVO transactionVO, Model model, HttpSession session, LogVO logVO,
			@PathVariable(value = "requestnumber", required = false) String requestnumber) {
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		session.removeAttribute("alarmcount");
		int transresult = productSVC.gettransFindCriteria(1, m_number).getPageCriteria().getTotalRec();
		int reqresult = productSVC.getreqFindCriteria(1, m_number).getPageCriteria().getTotalRec();
		session.setAttribute("alarmcount", transresult + reqresult);
		// 구매요청 거절(R_CONDTION '1'대기 -> '3' 거절)
		int result = transactionSVC.canclerequest(requestnumber);
		return "redirect:/transaction/request_notice";
	}

	// 구매요청페이지
	@GetMapping({ "/request_notice", "/request_notice/{reqPage}" })
	public String rlist(HttpSession session,
			@PathVariable(value = "reqPage", required = false) Optional<Integer> reqPage, Model model) {
		// 세션에서 id정보를 가져온다.
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		session.removeAttribute("alarmcount");

		int transresult = productSVC.gettransFindCriteria(1, m_number).getPageCriteria().getTotalRec();
		int reqresult = productSVC.getreqFindCriteria(1, m_number).getPageCriteria().getTotalRec();
		session.setAttribute("alarmcount", transresult + reqresult);
		// 구매요청정보 얻어옴.
		model.addAttribute("rlist", transactionSVC.rlist(reqPage.orElse(1), m_number));
		model.addAttribute("reqfindCriteria", productSVC.getreqFindCriteria(reqPage.orElse(1), m_number));

		return "/transaction/request_notice";
	}

	// 거래요청페이지
	@GetMapping({ "/transaction_notice", "/transaction_notice/{reqPage}" })
	public String tlist(HttpSession session,
			@PathVariable(value = "reqPage", required = false) Optional<Integer> reqPage, Model model) {
		// 세션에서 id정보를 가져온다.
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		session.removeAttribute("alarmcount");

		int transresult = productSVC.gettransFindCriteria(1, m_number).getPageCriteria().getTotalRec();
		int reqresult = productSVC.getreqFindCriteria(1, m_number).getPageCriteria().getTotalRec();
		logger.info("transresult+reqresult=" + transresult + reqresult);
		session.setAttribute("alarmcount", transresult + reqresult);

		model.addAttribute("tlist", transactionSVC.tlist(reqPage.orElse(1), m_number));
		model.addAttribute("transfindCriteria", productSVC.gettransFindCriteria(reqPage.orElse(1), m_number));

		return "/transaction/transaction_notice";
	}

	// 거래중 취소, 판매중으로 변경
	@Transactional
	@PostMapping({ "/deletetransaction", "/deletetransaction/{productnumber}" })
	public String deletetransaction(TransactionVO transactionVO, Model model, HttpSession session, LogVO logVO,
			@PathVariable(value = "productnumber", required = false) String productnumber) {
		// 1)db에서 회원정보 삭제
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		session.removeAttribute("alarmcount");

		int transresult = productSVC.gettransFindCriteria(1, m_number).getPageCriteria().getTotalRec();
		int reqresult = productSVC.getreqFindCriteria(1, m_number).getPageCriteria().getTotalRec();
		session.setAttribute("alarmcount", transresult + reqresult);
		// 판매상태 거래중 -> 판매중으로 변경
		int deleteresult = transactionSVC.deletetransaction(productnumber);
		// transaction 상태 변경 T_CONDITIION 1(대기중)>3(취소)
		int updateresult = transactionSVC.utctransaction(productnumber);
		return "redirect:/product/myproduct/1/3";
	}

	//후기작성양식
	@GetMapping("/reviewForm")
	public String reviewForm(ProductVO productVO, HttpSession session, Model model) {
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		model.addAttribute("productVO", productVO);

		logger.info("list" + model);

		return "/transaction/reviewForm";
	}

	//구매요청양식
	@GetMapping("/requestForm")
	public String requestForm(ProductVO productVO, HttpSession session, Model model) {

		return "/transaction/requestForm";
	}


	// 구매요청 처리
	@PostMapping("/request")
	public String request(RequestVO requestVO, LogVO logVO, Model model, HttpSession session,
			@RequestParam(value = "p_number") String p_number) throws Exception {
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		requestVO.setR_member(m_number);
		//중복요청 체크

		
			
		
		
		//구매요청
		int result = transactionSVC.request(requestVO);
		logVO.setL_action("4"); // 구매요청
		logVO.setL_m_number(m_number);
		logSVC.addLog(logVO);

		// 세션에서 id정보를 가져온다.

		logger.info("ㅇㅇㅇ" + requestVO.toString());
		if (result == 1) {
			model.addAttribute(requestVO.toString());
			return "redirect:/product/productInfo?p_number=" + p_number;
		} else {
			model.addAttribute("svr_msg", "error");
		}
		
		return "redirect:/product/productInfo?p_number=" + p_number;
	}

	//내거래리스트
	@GetMapping({ "/mytransaction", "/mytransaction/{reqPage}", "/mytransaction/{reqPage}/{trsstate}" })
	public String mytransaction(HttpSession session,
			@PathVariable(value = "reqPage", required = false) Optional<Integer> reqPage,
			@PathVariable(value = "trsstate", required = false) Optional<Integer> trsstate, Model model) {
		// 세션 내정보 받아옴.
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		// session.getAttribute(m_number);
		model.addAttribute("trsstate", trsstate.orElse(1)); // 유의미한지 보기
		model.addAttribute("mytransaction",
				transactionSVC.mytransaction(reqPage.orElse(1), m_number, trsstate.orElse(1)));
		model.addAttribute("mytransfindCriteria",
				productSVC.mytransFindCriteria(reqPage.orElse(1), m_number, trsstate.orElse(1)));

		return "/transaction/mytransaction";
	}

}
