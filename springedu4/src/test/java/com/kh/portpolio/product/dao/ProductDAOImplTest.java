package com.kh.portpolio.product.dao;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.kh.portfolio.common.page.RecordCriteria;
import com.kh.portfolio.member.vo.MemberCategoryVO;
import com.kh.portfolio.member.vo.MemberVO;
import com.kh.portfolio.product.dao.ProductDAO;
import com.kh.portfolio.product.vo.ProductVO;
import com.kh.portfolio.transaction.dao.TransactionDAO;
import com.kh.portfolio.transaction.vo.ReviewVO;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/*.xml"})
public class ProductDAOImplTest {
	
	private final static Logger logger
	= LoggerFactory.getLogger(ProductDAOImplTest.class);
	@Inject
	//@Qualifier : spring 컨테이너에 동일타입의 bean이 존재할경우 명시적으로 참조하고자하는 bean을 지정할때사용
	//spring컨테이너에서 관리되는 bean이름은 특별히 지정해주지 않으면 클래스명을 기본값으로 갖는다(첫글자는 소문자)
	TransactionDAO transactionDAO;
	ProductDAO productDAO;
	@Inject
	RecordCriteria recordCriteria;

	//판매상품입력
	@Test
	@DisplayName("page1판매상품입력")
	@Disabled
	void productPage() {
	
		ProductVO productVO = new ProductVO();
		MemberVO  memberVO = new MemberVO();
		MemberCategoryVO memberCategoryVO = new MemberCategoryVO();
		productVO.setP_name("나이키팬츠");
		productVO.setP_purchase_price("40000");
		productVO.setP_sale_price("20000");
		productVO.setP_brand("샤넬");
		productVO.setP_condition("1");
		productVO.setP_size("2");
		productVO.setP_transaction("1");
		productVO.setP_address("부산");
		productVO.setP_img_path("ung.jpg");
		productVO.setMemberCategoryVO(memberCategoryVO);
		productVO.getMemberCategoryVO().setC_number("13");
		productVO.setMemberVO(memberVO);
		productVO.getMemberVO().setM_number("100");
		
		int result = productDAO.productPage(productVO);
		
		logger.info("relult:"+result);
		logger.info("productVO"+productVO);
	}
	
	@Test
	@DisplayName("게시글목록")
	@Disabled
	void list() {

		recordCriteria.setReqPage(1);  			//요청페이지
		recordCriteria.setRecNumPerPage(10);		//한페이지에 보여줄 레코드 수

		List<ProductVO> list = productDAO.list(recordCriteria.getStarRec(),
																			 recordCriteria.getEndRec());
		logger.info("레코드갯수:" + list.size());

//		list.stream().forEach((board)->{
//			System.out.println(board);
//		});
		list.stream().forEach(System.out::println);

//		logger.info("게시글 목록:" + list.toString());
	}	
	@Test
	@DisplayName("후기작성")
	void review() {
		ReviewVO reviewVO = new ReviewVO();
		ProductVO productVO = new ProductVO();
		MemberVO  memberVO = new MemberVO();
		reviewVO.setGrade1(3);
		reviewVO.setGrade2(3);
		reviewVO.setRe_content("gdgd");
		reviewVO.setMemberVO(memberVO);
		reviewVO.getMemberVO().setM_number("1");
		reviewVO.setProductVO(productVO);
		reviewVO.getProductVO().setP_number("2");
		
		int result = transactionDAO.review(reviewVO);
		logger.info("result"+result);
	}
}
