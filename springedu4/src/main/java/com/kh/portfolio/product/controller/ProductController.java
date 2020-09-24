package com.kh.portfolio.product.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

import javax.annotation.Resource;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.portfolio.common.util.UploadFileUtils;
import com.kh.portfolio.log.svc.LogSVC;
import com.kh.portfolio.log.vo.LogVO;
import com.kh.portfolio.member.svc.MemberSVC;
import com.kh.portfolio.member.vo.MemberVO;
import com.kh.portfolio.product.svc.ProductSVC;
import com.kh.portfolio.product.vo.BasketVO;
import com.kh.portfolio.product.vo.CodeDecodeVO;
import com.kh.portfolio.product.vo.ProductVO;
import com.kh.portfolio.transaction.svc.TransactionSVC;
import com.kh.portfolio.transaction.vo.RequestVO;

@Controller
@RequestMapping("/product")
public class ProductController {

	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

	@Inject
	ProductSVC productSVC;

	@Inject
	MemberSVC memberSVC;
	@Inject
	TransactionSVC transactionSVC;

	@Inject
	LogSVC logSVC;

	@Resource(name = "uploadPath")
	private String uploadPath;

	// int c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26,c27=0;
	int[] i_array = new int[30]; // 초기값 0

	@ModelAttribute("codeDecodeList")
	public List<CodeDecodeVO> getCode() {
		List<CodeDecodeVO> codeDecodeList = new ArrayList<>();
		codeDecodeList.add(new CodeDecodeVO("TC", "제목+내용"));
		codeDecodeList.add(new CodeDecodeVO("T", "제목"));
		codeDecodeList.add(new CodeDecodeVO("C", "내용"));
		codeDecodeList.add(new CodeDecodeVO("I", "아이디"));
		codeDecodeList.add(new CodeDecodeVO("A", "전체"));

		return codeDecodeList;
	}

	// 판매하기 페이지 화면
	@GetMapping("/productPage")
	public String productPage() {

		return "/product/productPage";
	}


	// 수정하기 화면
	@GetMapping({ "/modifyproductPage", "/modifyproductPage/{modifynumber}" })
	public String modifyproductPage(@PathVariable(value = "modifynumber", required = false) String modifynumber,
			Model model) {
		ProductVO productVO = productSVC.getproduct(modifynumber);
		model.addAttribute("productVO", productVO);
		logger.info("productVO=" + productVO.toString());
		return "/product/modifyproductPage";
	}

	// 수정처리
	@PostMapping({ "/modifyproduct", "/modifyproduct/{modifynumber}" })
	public String modifyproductInfo(ProductVO productVO, Model model, MultipartFile file, HttpSession session,
			LogVO logVO, @PathVariable(value = "modifynumber", required = false) String modifynumber) throws Exception {
//				logger.info("MemberController.join(MemberVO memberVO)호출됨!");
//				logger.info(memberVO.toString());

		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		ProductVO preproductVO = productSVC.getproduct(modifynumber);
		if (file != null) {
			try {
				fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(),
						ymdPath);
				productVO.setP_img_path(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
				productVO.setGdsThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator
						+ "s_" + fileName);
			} catch (IOException e) {
				logger.info("이미지파일 비었음");

				String imgfilename = preproductVO.getP_img_path();
				productVO.setP_img_path(imgfilename);
				e.printStackTrace();
			} catch (Exception e) {
				logger.info("이미지파일 비었음");

				String imgfilename = preproductVO.getP_img_path();
				productVO.setP_img_path(imgfilename);
				e.printStackTrace();
			}
		}
		logger.info("productVO.getP_xrow()=" + productVO.getP_xrow());
		if (productVO.getP_xrow().equals("") && productVO.getP_ycol().equals("")) {
			productVO.setP_address(preproductVO.getP_address());
			productVO.setP_xrow(preproductVO.getP_xrow());
			productVO.setP_ycol(preproductVO.getP_ycol());
		}

		productVO.setP_transaction("1");
		MemberVO memberVO = new MemberVO();// 세션에서 id정보를 가져온다.
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		productVO.setMemberVO(memberVO);
		productVO.getMemberVO().setM_number(m_number);
		String c_num = productVO.getMemberCategoryVO().getC_number().replace(",", "").trim();
		if (c_num == "") {
			c_num = preproductVO.getMemberCategoryVO().getC_number();
		}
		System.out.println(c_num);
		productVO.getMemberCategoryVO().setC_number(c_num);
		logVO.setL_action("3"); // 판매등록
		logVO.setL_m_number(m_number);
		logSVC.addLog(logVO);
		int result = productSVC.modifyproductInfo(productVO, modifynumber);
		System.out.println(productVO.toString());
		System.out.println("테스트");
		if (result == 1) {
			return "redirect:/product/myproduct";
		} else {
			model.addAttribute("svr_msg", "error");
			return "redirect:/product/myproduct";
		}
	}

	// 등록상품 제거
	@PostMapping({ "/deleteproductPage", "/deleteproductPage/{productnumber}" })
	public String deleteproduct(ProductVO productVO, Model model, MultipartFile file, HttpSession session, LogVO logVO,
			@PathVariable(value = "productnumber", required = false) String productnumber) {
		// 1)db에서 회원정보 삭제
		logger.info("productnumber=" + productnumber);
		int result = productSVC.deleteproduct(productnumber);
		logger.info("result=" + result);
		return "redirect:/product/myproduct";
	}

	// 상품등록
	@PostMapping("/product")
	public String productInfo(ProductVO productVO, Model model, MultipartFile file, HttpSession session, LogVO logVO)
			throws Exception {
//			logger.info("MemberController.join(MemberVO memberVO)호출됨!");
//			logger.info(memberVO.toString());

		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if (file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		productVO.setP_img_path(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		productVO.setGdsThumbImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		productVO.setP_transaction("1");
		MemberVO memberVO = new MemberVO();// 세션에서 id정보를 가져온다.
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		productVO.setMemberVO(memberVO);
		productVO.getMemberVO().setM_number(m_number);
		String c_num = productVO.getMemberCategoryVO().getC_number().replace(",", "").trim();

		System.out.println(c_num);
		productVO.getMemberCategoryVO().setC_number(c_num);
		// ,P_SALE_PRICE,P_BRAND,P_CONDITION,P_SIZE,P_TRANSACTION,P_ADDRESS,P_IMG_PATH,GDSTHUMBIMG,P_M_NUMBER,CATEGORY
		logVO.setL_action("3"); // 판매등록
		logVO.setL_m_number(m_number);
		logSVC.addLog(logVO);
		int result = productSVC.productInfo(productVO);
		System.out.println(productVO.toString());
		System.out.println("테스트");
		if (result == 1) {
			return "redirect:/product/womanlist";
		} else {
			model.addAttribute("svr_msg", "error");
			return "redirect:/product/womanlist";
		}
	}

	// 여성게시글 목록
	@GetMapping({ "/womanlist", "/womanlist/{reqPage}/{mlist}", "/womanlist/{reqPage}/{mlist}/{listCategory}",
			"/womanlist/{reqPage}/{mlist}/{searchType}/{keyword}",
			"/womanlist/{reqPage}/{mlist}/{listCategory}/{searchType}/{keyword}" })
	public String womanlist(@PathVariable(value = "reqPage", required = false) Optional<Integer> reqPage,
			@PathVariable(value = "searchType", required = false) String searchType,
			@PathVariable(value = "keyword", required = false) String keyword,
			@PathVariable(value = "listCategory", required = false) String listCategory,
			@PathVariable(value = "mlist", required = false) Optional<Integer> mlist, Model model,
			HttpSession session) {
		String gender = "W";
		// url경로상에 reqPage값이 존재하지않으면 1로 설정함.
		// model.addAttribute("list", productSVC.list(reqPage.orElse(1)));
		// model.addAttribute("pageCriteria",
		// productSVC.getPageCriteria(reqPage.orElse(1)));

		// model.addAttribute("list",
		// productSVC.list(reqPage.orElse(1),searchType,keyword));
		// model.addAttribute("findCriteria",
		// productSVC.getFindCriteria(reqPage.orElse(1),searchType,keyword));
		if (listCategory != null) {
			model.addAttribute("listCategory", listCategory);
		}
		List<ProductVO> basketchecklist = null;
		//관심상품 목록 얻어오기
		try {
			String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
			// 관심상품 목록 체크
			logger.info("m_number=" + m_number);
			basketchecklist = productSVC.basketchecklist(m_number);
			logger.info("basketchecklist=" + basketchecklist.toString());
			model.addAttribute("basketchecklist", basketchecklist);
		} catch (Exception e) {

			e.printStackTrace();
		}
		model.addAttribute("reqPagecategory", reqPage.orElse(1)); // 유의미한지 보기
		model.addAttribute("reqmlist", mlist.orElse(1)); // 유의미한지 보기
		model.addAttribute("list",
				productSVC.list(reqPage.orElse(1), listCategory, searchType, keyword, gender, mlist.orElse(1)));
		model.addAttribute("findCriteria", productSVC.getFindCriteria(reqPage.orElse(1), listCategory, searchType,
				keyword, gender, mlist.orElse(1)));

		logger.info("여기까지?");
		
		// 추천상품10개

		return "/product/womanListForm";

	}

	// 추천게시글 목록
	@GetMapping({ "/recommandlist/{gendercategory}" })
	public String womanlist(@PathVariable(value = "gendercategory", required = false) String gendercategory,
			Model model, HttpSession session) {

		String id = ((MemberVO) session.getAttribute("member")).getId();
		List<ProductVO> basketchecklist = null;
		//관심상품 목록 얻어오기
		try {
			String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
			// 관심상품 목록 체크
			basketchecklist = productSVC.basketchecklist(m_number);
			model.addAttribute("basketchecklist", basketchecklist);
		} catch (Exception e) {

			e.printStackTrace();
		}
		MemberVO memberVO = memberSVC.listOneMember(id);
		logger.info("memberVO=" + memberVO.toString());
		// 해당사용자 성별,사이즈,선호카테고리
		String mygender = memberVO.getGender();
		String mysize = memberVO.getM_size();
		int mycategory1 = Integer.parseInt(memberVO.getCategory1());
		int mycategory2 = Integer.parseInt(memberVO.getCategory2());
		int mycategory3 = Integer.parseInt(memberVO.getCategory3());
		// 선호카테고리별로 10점식부여
		if (mycategory1 == 11 || mycategory2 == 11 || mycategory3 == 11) {
			i_array[11] = i_array[11] + 10;
		}
		if (mycategory1 == 12 || mycategory2 == 12 || mycategory3 == 12) {
			i_array[12] = i_array[12] + 10;
		}
		if (mycategory1 == 13 || mycategory2 == 13 || mycategory3 == 13) {
			i_array[13] = i_array[13] + 10;
		}
		if (mycategory1 == 14 || mycategory2 == 14 || mycategory3 == 14) {
			i_array[14] = i_array[14] + 10;
		}
		if (mycategory1 == 15 || mycategory2 == 15 || mycategory3 == 15) {
			i_array[15] = i_array[15] + 10;
		}
		if (mycategory1 == 16 || mycategory2 == 16 || mycategory3 == 16) {
			i_array[16] = i_array[16] + 10;
		}
		if (mycategory1 == 17 || mycategory2 == 17 || mycategory3 == 17) {
			i_array[17] = i_array[17] + 10;
		}
		if (mycategory1 == 18 || mycategory2 == 18 || mycategory3 == 18) {
			i_array[18] = i_array[18] + 10;
		}
		if (mycategory1 == 19 || mycategory2 == 19 || mycategory3 == 19) {
			i_array[19] = i_array[19] + 10;
		}
		if (mycategory1 == 20 || mycategory2 == 20 || mycategory3 == 20) {
			i_array[20] = i_array[20] + 10;
		}
		if (mycategory1 == 21 || mycategory2 == 21 || mycategory3 == 21) {
			i_array[21] = i_array[21] + 10;
		}
		if (mycategory1 == 22 || mycategory2 == 22 || mycategory3 == 22) {
			i_array[22] = i_array[22] + 10;
		}
		if (mycategory1 == 23 || mycategory2 == 23 || mycategory3 == 23) {
			i_array[23] = i_array[23] + 10;
		}
		if (mycategory1 == 24 || mycategory2 == 24 || mycategory3 == 24) {
			i_array[24] = i_array[24] + 10;
		}
		if (mycategory1 == 25 || mycategory2 == 25 || mycategory3 == 25) {
			i_array[25] = i_array[25] + 10;
		}
		if (mycategory1 == 26 || mycategory2 == 26 || mycategory3 == 26) {
			i_array[26] = i_array[26] + 10;
		}
		if (mycategory1 == 27 || mycategory2 == 27 || mycategory3 == 27) {
			i_array[27] = i_array[27] + 10;
		}

		// 해당사용자 조회로그기록
		List<LogVO> loglist = null;
		loglist = logSVC.listAllLog(memberVO.getM_number());
		for (int i = 0; i < loglist.size(); i++) {
			if (Integer.parseInt(loglist.get(i).getL_category()) == 11) {
				i_array[11] = i_array[11] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 12) {
				i_array[12] = i_array[12] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 13) {
				i_array[13] = i_array[13] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 14) {
				i_array[14] = i_array[14] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 15) {
				i_array[15] = i_array[15] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 16) {
				i_array[16] = i_array[16] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 17) {
				i_array[17] = i_array[17] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 18) {
				i_array[18] = i_array[18] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 19) {
				i_array[19] = i_array[19] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 20) {
				i_array[20] = i_array[20] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 21) {
				i_array[21] = i_array[21] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 22) {
				i_array[22] = i_array[22] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 23) {
				i_array[23] = i_array[23] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 24) {
				i_array[24] = i_array[24] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 25) {
				i_array[25] = i_array[25] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 26) {
				i_array[26] = i_array[26] + 1;
			}
			if (Integer.parseInt(loglist.get(i).getL_category()) == 27) {
				i_array[27] = i_array[27] + 1;
			}
		}

		// 추천리스트 만들기(성별,사이즈,나이)
		String regender = mygender; // 같은성별
		String resize = mysize.trim(); // +- 1사이즈

		int rebestcategory1 = 0;
		int rebestcategory2 = 0;
		int rebestcategory3 = 0;
		String strtmp = "";

		int max1 = 0;
		int max2 = 0;
		int max3 = 0;
		// 가장점수높은 카테고리3가지 출력
		for (int i = 0; i < i_array.length; i++) {
			if (i_array[i] >= max1) {
				max1 = i_array[i];
				rebestcategory1 = i;
				i_array[i] = 0;
			}
		}
		for (int i = 0; i < i_array.length; i++) {
			if (i_array[i] >= max2) {
				max2 = i_array[i];
				rebestcategory2 = i;
				i_array[i] = 0;
			}
		}
		for (int i = 0; i < i_array.length; i++) {
			if (i_array[i] >= max3) {
				max3 = i_array[i];
				rebestcategory3 = i;
				i_array[i] = 0;
			}
		}

		// 랜덤확률로 우선순위 변경
		// 기존1 1순위 사이즈 (50%확률)
		// 3순위 선호카테고리(1,2,3)
		// 변경2 1순위 사이즈 (20%확률)
		// 3순위 선호카테고리(2,1,3)
		// 변경3 1순위 사이즈 (20%확률)
		// 3순위 선호카테고리(3,1,2)
		// 변경4 1순위 선호카테고리(3,1,2) (10%확률)
		Random rand = new Random();
		String renum = "";
		int randnum = rand.nextInt(10) + 1;
		if (randnum <= 5) {
			renum = "1";
		} else if (randnum <= 7) {
			renum = "2";
		} else if (randnum <= 9) {
			renum = "3";
		} else {
			renum = "4";
		}
		// }
		String recate1 = Integer.toString(rebestcategory1);
		String recate2 = Integer.toString(rebestcategory2);
		String recate3 = Integer.toString(rebestcategory3);

		logger.info(regender+"/"+resize+"/"+recate1+"/"+recate2+"/"+recate3+"/"+renum);
		// 추천상품10개
		model.addAttribute("gendercategory", gendercategory);
		model.addAttribute("recommandlist",
				productSVC.recommandlist(regender, resize, recate1, recate2, recate3, "4"));
		//추천상품 랜덤부여(데이터 많아야 적용됨)
		/*
		 * model.addAttribute("recommandlist", productSVC.recommandlist(regender,
		 * resize, recate1, recate2, recate3, randnum));
		 */
		return "/product/recommandListForm";

	}

	// 남성게시글 목록
	@GetMapping({ "/manlist", "/manlist/{reqPage}/{mlist}", "/manlist/{reqPage}/{mlist}/{listCategory}",
			"/manlist/{reqPage}/{mlist}/{searchType}/{keyword}",
			"/manlist/{reqPage}/{mlist}/{listCategory}/{searchType}/{keyword}" })
	public String manlist(@PathVariable(value = "reqPage", required = false) Optional<Integer> reqPage,
			@PathVariable(value = "searchType", required = false) String searchType,
			@PathVariable(value = "keyword", required = false) String keyword,
			@PathVariable(value = "listCategory", required = false) String listCategory,
			@PathVariable(value = "mlist", required = false) Optional<Integer> mlist, Model model,
			HttpSession session) {
		String gender = "M";
//url경로상에 reqPage값이 존재하지않으면 1로 설정함.
//model.addAttribute("list", productSVC.list(reqPage.orElse(1)));
//model.addAttribute("pageCriteria", productSVC.getPageCriteria(reqPage.orElse(1)));
		logger.info("카테고리" + listCategory);
//model.addAttribute("list", productSVC.list(reqPage.orElse(1),searchType,keyword));
//model.addAttribute("findCriteria", productSVC.getFindCriteria(reqPage.orElse(1),searchType,keyword));
		if (listCategory != null) {
			model.addAttribute("listCategory", listCategory);
		}
		List<ProductVO> basketchecklist = null;
		//관심상품 목록 얻어오기
		try {
			String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
			// 관심상품 목록 체크
			logger.info("m_number=" + m_number);
			basketchecklist = productSVC.basketchecklist(m_number);
			logger.info("basketchecklist=" + basketchecklist.toString());
			model.addAttribute("basketchecklist", basketchecklist);
		} catch (Exception e) {

			e.printStackTrace();
		}
		
		
		
		model.addAttribute("reqPagecategory", reqPage.orElse(1)); // 유의미한지 보기
		model.addAttribute("reqmlist", mlist.orElse(1)); // 유의미한지 보기
		model.addAttribute("list",
				productSVC.list(reqPage.orElse(1), listCategory, searchType, keyword, gender, mlist.orElse(1)));
		model.addAttribute("findCriteria", productSVC.getFindCriteria(reqPage.orElse(1), listCategory, searchType,
				keyword, gender, mlist.orElse(1)));
		logger.info("gender" + gender);
		return "/product/manListForm";

	}

	// 판매정보 확인
	@GetMapping("/productInfo")
	public void getproductInfo(@RequestParam("p_number") String p_number, Model model, HttpSession session, LogVO logVO)
			throws Exception {
		String checkheart = "0";
		String requestoverlap ="T";
		
		
		try {
			String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		
			// 관심상품 목록 체크
			logger.info("m_number=" + m_number + "/" + p_number);
			BasketVO basketVO = productSVC.pbasketcheck(p_number, m_number);
			logger.info("basketVO=" + basketVO.toString());
			if (basketVO.getB_number() != "") {
				checkheart = "1";
			}
			model.addAttribute("checkheart", checkheart);
			
		} catch (Exception e) {

			e.printStackTrace();
		}
		
		
		try {
			String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
			RequestVO checkrequest = transactionSVC.checkrequest(m_number,p_number);
			if(checkrequest==null) {
				requestoverlap="T";
			}else {
				requestoverlap="F";
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		ProductVO productVO = productSVC.productInfo(p_number);

		logger.info("리스트=" + productSVC.productInfo(p_number).toString());

		// 로그기록 시작

		try {
			String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
			logVO.setL_action("3");
			logVO.setL_m_number(m_number);
			logVO.setL_category(productVO.getMemberCategoryVO().getC_number());
			int result = logSVC.addLog(logVO);
			logger.info("결과=" + result);

		} catch (Exception e) {
			

			e.printStackTrace();
		}

		// 로그기록 끝

		String category = productVO.getMemberCategoryVO().getC_number();
		// 카테고리
		if (category.equals("11")) {
			productVO.getMemberCategoryVO().setC_number("(여)아우터");
		} else if (category.equals("12")) {
			productVO.getMemberCategoryVO().setC_number("(여)반팔/긴팔/민소매");
		} else if (category.equals("13")) {
			productVO.getMemberCategoryVO().setC_number("(여)원피스");
		} else if (category.equals("14")) {
			productVO.getMemberCategoryVO().setC_number("(여)블라우스/셔츠");
		} else if (category.equals("15")) {
			productVO.getMemberCategoryVO().setC_number("(여)니트/가디건");
		} else if (category.equals("16")) {
			productVO.getMemberCategoryVO().setC_number("(여)후드/맨투맨");
		} else if (category.equals("17")) {
			productVO.getMemberCategoryVO().setC_number("(여)팬츠");
		} else if (category.equals("18")) {
			productVO.getMemberCategoryVO().setC_number("(여)스커트");
		} else if (category.equals("19")) {
			productVO.getMemberCategoryVO().setC_number("(여)수트");
		} else if (category.equals("21")) {
			productVO.getMemberCategoryVO().setC_number("(남)아우트");
		} else if (category.equals("22")) {
			productVO.getMemberCategoryVO().setC_number("(남)반팔/긴소매/민소매");
		} else if (category.equals("23")) {
			productVO.getMemberCategoryVO().setC_number("(남)니트/가디건");
		} else if (category.equals("24")) {
			productVO.getMemberCategoryVO().setC_number("(남)셔츠");
		} else if (category.equals("25")) {
			productVO.getMemberCategoryVO().setC_number("(남)후드/맨투맨");
		} else if (category.equals("26")) {
			productVO.getMemberCategoryVO().setC_number("(남)셔츠");
		} else if (category.equals("27")) {
			productVO.getMemberCategoryVO().setC_number("(남)수트");
		}
		// 제품상태
		String p_condition = productVO.getP_condition();
		if (p_condition.equals("5")) {
			productVO.setP_condition("SS");
		} else if (p_condition.equals("4")) {
			productVO.setP_condition("S");
		} else if (p_condition.equals("3")) {
			productVO.setP_condition("A");
		} else if (p_condition.equals("2")) {
			productVO.setP_condition("B");
		} else if (p_condition.equals("1")) {
			productVO.setP_condition("C");
		}
		// 사이즈
		if (productVO.getP_size().trim().equals("5")) {
			productVO.setP_size("XXL");
		} else if (productVO.getP_size().trim().equals("4")) {
			productVO.setP_size("XL");
		} else if (productVO.getP_size().trim().equals("3")) {
			productVO.setP_size("L");
		} else if (productVO.getP_size().trim().equals("2")) {
			productVO.setP_size("M");
		} else if (productVO.getP_size().trim().equals("1")) {
			productVO.setP_size("S");
		}
		// 거래방식
		String p_transaction = productVO.getP_transaction();
		if (p_transaction.equals("1")) {
			productVO.setP_transaction("직거래");
		} else if (p_transaction.equals("2")) {
			productVO.setP_transaction("택배");
		}
		model.addAttribute("requestoverlap", requestoverlap);
		logger.info("requestoverlap/"+requestoverlap);
		model.addAttribute("productVO", productVO);
	}

	// 지도로보기
	@GetMapping("/maplist")
	public String MapForm(ProductVO productVO, Model model) {
		List<ProductVO> list = null;
		list = productSVC.maplist();
		List<String> imglist = new ArrayList<>(list.size());

		for (int i = 0; i < list.size(); i++) {

			imglist.add(list.get(i).getP_img_path().toString().replace("\\", "\\/").replace("\\", ""));
			System.out.println("맞냐이거" + imglist.get(i));
			list.get(i).setP_img_path(imglist.get(i));
		}
		System.out.println("변환경로" + imglist);
		model.addAttribute("maplist", list);

		return "/product/mapListForm";
	}

	// 관심상품 리스트
	@GetMapping({ "/basketlist", "/basketlist/{reqPage}","/basketlist/{reqPage}/{gendercategory}"})
	public String basketlist(ProductVO productVO, Model model,HttpSession session,
			@PathVariable(value = "gendercategory", required = false) String gendercategory,
			@PathVariable(value = "reqPage", required = false) Optional<Integer> reqPage) {
		List<ProductVO> list = null;
		List<ProductVO> basketchecklist = null;
		//관심상품 목록 얻어오기
		try {
			String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
			// 관심상품 목록 체크
			basketchecklist = productSVC.basketchecklist(m_number);
			model.addAttribute("basketchecklist", basketchecklist);
		} catch (Exception e) {

			e.printStackTrace();
		}
		// 세션 내정보 받아옴.
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		// 관심상품 리스트 m_number 조회 리스트 받아오기.
		list = productSVC.basketlist(reqPage.orElse(1),m_number);
		model.addAttribute("basketlist", list);
		model.addAttribute("findCriteria",productSVC.basketFindCriteria(reqPage.orElse(1), m_number));
		return "/product/basketListForm";
	}

	// 내상품보기
	@GetMapping({ "/myproduct", "/myproduct/{reqPage}", "/myproduct/{reqPage}/{trsstate}" })
	public String myproduct(HttpSession session,

			@PathVariable(value = "reqPage", required = false) Optional<Integer> reqPage,
			@PathVariable(value = "trsstate", required = false) Optional<Integer> trsstate, Model model) {
		// 세션 내정보 받아옴.
		String m_number = ((MemberVO) session.getAttribute("member")).getM_number();
		model.addAttribute("trsstate", trsstate.orElse(1)); // 유의미한지 보기
		model.addAttribute("myproduct", productSVC.myproduct(reqPage.orElse(1), m_number, trsstate.orElse(1)));
		model.addAttribute("myfindCriteria",
				productSVC.mygetFindCriteria(reqPage.orElse(1), m_number, trsstate.orElse(1)));

		return "/product/myproduct";
	}

	// 관심상품등록
	@PostMapping(value = "/basketin", produces = "application/json")
	@ResponseBody
	public ResponseEntity<Map> basketin(@RequestBody String basketproduct, HttpServletRequest request,
			HttpServletResponse response) {

		String m_number = basketproduct.substring(basketproduct.lastIndexOf("/") + 1);
		String[] basketproducts = basketproduct.split("/");
		// 이미 등록된 상품인지 체크함 => 나중엔 의미없을듯?
		BasketVO basketVO = productSVC.basketcheck(basketproducts[0], m_number);

		int inresult = 0;
		if (basketVO == null) {
			inresult = productSVC.basketin(basketproducts[0], m_number);
		}
		// 관심상품 등록

		ResponseEntity<Map> res = null; // 중복확인

		Map<String, Object> map = new HashMap<>(); // 관심상품 등록이 완료되면
		if (basketVO != null) {
			map.put("rtcode", "01");
			map.put("result", "이미 등록된 상품입니다.");
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200
		} else if (inresult == 1) {
			map.put("rtcode", "00");
			map.put("result", "관심상품 등록완료.");
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200
		}
		return res;
	}

	// 관심상품해제(Restfull 처리, 응답포맷:JSON)
	@PostMapping(value = "/basketout", produces = "application/json")
	@ResponseBody
	public ResponseEntity<Map> basketout(@RequestBody String basketproduct, HttpServletRequest request,
			HttpServletResponse response) {
		String m_number = basketproduct.substring(basketproduct.lastIndexOf("/") + 1);
		String[] basketproducts = basketproduct.split("/");
		// 관심상품 해제
		int inresult = productSVC.basketout(basketproducts[0], m_number);
		ResponseEntity<Map> res = null; // 중복확인

		Map<String, Object> map = new HashMap<>(); // 관심상품 등록이 완료되면
		if (inresult == 1) {
			map.put("rtcode", "00");
			map.put("result", "관심상품 해제완료.");
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200
		}

		return res;
	}
	

}
