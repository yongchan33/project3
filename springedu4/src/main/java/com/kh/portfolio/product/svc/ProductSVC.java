package com.kh.portfolio.product.svc;

import java.util.List;

import com.kh.portfolio.common.page.FindCriteria;
import com.kh.portfolio.common.page.PageCriteria;
import com.kh.portfolio.product.vo.BasketVO;
import com.kh.portfolio.product.vo.ProductVO;

public interface ProductSVC {

//판매하기
	int productPage(ProductVO productVO);
	//등록
	int productInfo(ProductVO productVO);
	//수정
	int modifyproductInfo(ProductVO productVO,String modifynumber);
	// 상품삭제
	int deleteproduct(String productnumber);
	// 게시글 목록
	List<ProductVO> list();
	//수정상품정보
	ProductVO getproduct(String modifynumber);
	// 게시글 목록
	List<ProductVO> list(int reqPage);
	
	
	
	// 게시글 목록(검색포함)
	List<ProductVO> list(int reqPage, String searchType, String keyword);

	// 추천 게시물목록
	List<ProductVO> recommandlist(String regender, String resize, String rebestcategory1, String rebestcategory2,
			String rebestcategory3, String renum);

	// 게시글 목록(검색포함)
	List<ProductVO> list(int reqPage, String listCategory, String searchType, String keyword, String gender, int mlist);

	// 게시글 목록(검색포함)
	List<ProductVO> myproduct(int reqPage, String m_number,int trsstate);
	// 게시글 목록(검색포함)
	List<ProductVO> myallproduct(String m_number);
	// 페이징제어 반환
	PageCriteria getPageCriteria(int reqPage);
	
	// 페이징제어 + 검색포함
	FindCriteria getFindCriteria(int reqPage, String searchType, String keyword);
	//구매요청 검색수
	FindCriteria getreqFindCriteria(int reqPage, String m_number);
	//거래요청 검색수
	FindCriteria gettransFindCriteria(int reqPage, String m_number);
	//ㅎ기 게시판
	FindCriteria reviewgetFindCriteria(int reqPage);
	
	
	// (내상품)페이징제어 + 검색포함
	FindCriteria mygetFindCriteria(int reqPage,String m_number,int trsstate);

	// 페이징제어 + 검색포함
	FindCriteria getFindCriteria(int reqPage, String listCategory, String searchType, String keyword, String gender,
			int mlist);
	
	// (관심상품)페이징제어
	FindCriteria basketFindCriteria(int reqPage,String m_number);

	// 게시글 보기
	public ProductVO productInfo(String p_number) throws Exception;

	// 지도로보기
	List<ProductVO> maplist();
	//관심상품중복확인
	BasketVO basketcheck(String basketproduct,String m_number);
	//관심상품등록
	int basketin(String basketproduct,String m_number);
	
	//관심상품해제
	int basketout(String basketproduct,String m_number);
	
	//관심상품해제
	BasketVO pbasketcheck(String p_number,String m_number);
	
	// 사용자 관심상품리스트
	List<ProductVO> basketlist(int reqPage, String m_number);
	
	// 사용자 관심상품체크리스트
	List<ProductVO> basketchecklist(String m_number);
		
	// (내상품)페이징제어 + 검색포함
	FindCriteria mytransFindCriteria(int reqPage,String m_number,int trsstate);

	
	

}
