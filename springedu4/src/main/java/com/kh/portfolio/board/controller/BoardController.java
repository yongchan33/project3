package com.kh.portfolio.board.controller;

import java.util.Optional;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.portfolio.board.svc.BoardSVC;
import com.kh.portfolio.member.svc.MemberSVC;
import com.kh.portfolio.member.vo.MemberVO;
import com.kh.portfolio.product.svc.ProductSVC;
import com.kh.portfolio.product.vo.ProductVO;
import com.kh.portfolio.transaction.svc.TransactionSVC;
import com.kh.portfolio.transaction.vo.ReviewVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Inject
	ProductSVC productSVC;

	@Inject
	MemberSVC memberSVC;
	@Inject
	TransactionSVC transactionSVC;
	@Inject
	BoardSVC boardSVC;
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	// faq 목록
	@GetMapping("/FAQ")
	public String list(Model model) {
		return "/board/FAQ";
	}

	// 리뷰목록
	@GetMapping({ "/reviewList", "/reviewList/{reqPage}" })
	public String relist(@PathVariable(value = "reqPage", required = false) Optional<Integer> reqPage, Model model) {
		model.addAttribute("relist", boardSVC.relist(reqPage.orElse(1)));
		model.addAttribute("findCriteria", productSVC.reviewgetFindCriteria(reqPage.orElse(1)));
		logger.info("relist=" + model);
		return "/board/reviewList";
	}

	// 리뷰작성지
	@GetMapping("/reviewForm")
	public String reviewForm(ProductVO productVO, HttpSession session, Model model) {

		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		session.getAttribute(m_number);
		model.addAttribute("productVO", productVO);

		logger.info("list" + model);

		return "/board/reviewForm";
	}
	//리뷰작성
	@PostMapping("/review")
	public String review(ReviewVO reviewVO, Model model, HttpSession session, @RequestParam("p_number") String p_number)
			throws Exception {
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		reviewVO.setRe_m_number(m_number);
		ProductVO productVO = productSVC.productInfo(p_number);
		int result = boardSVC.review(reviewVO);

		if (result == 1) {
			model.addAttribute("reviewVO", reviewVO);
			model.addAttribute("productVO", productVO);
			return "/board/reviewForm";
		} else {
			model.addAttribute("svr_msg", "error");
			return "/board/reviewForm";

		}

	}
}