package com.kh.portfolio.product.dao;

import java.util.List;

import com.kh.portfolio.product.vo.BasketVO;
import com.kh.portfolio.product.vo.ProductVO;

public interface ProductDAO {

//판매하기페이지
	int productPage(ProductVO productVO);
	//제품수정
	int modifyproductPage(ProductVO productVO,String modifynumber);
	//상품정보
	int productInfo(ProductVO productVO);
	//수정상품정보
	ProductVO getproduct(String modifynumber);
	// 상품삭제
	int deleteproduct(String productnumber);
	// 게시글 목록
	List<ProductVO> list();

	// 게시글 목록(페이징)
	List<ProductVO> list(int startRec, int endRec);
	// 추천 게시물목록
	List<ProductVO> recommandlist(String regender,String resize,String rebestcategory1,String rebestcategory2,String rebestcategory3, String renum);
	// 게시글 목록(페이징+검색)
	List<ProductVO> list(int startRec, int endRec, String searchType, String keyword);
	// 내 게시글 목록(페이징)
	List<ProductVO> myproduct(int startRec, int endRec,String m_number,int trsstate);
	// 내 게시글 목록
	List<ProductVO> myallproduct(String m_number);
	// 게시글 목록(페이징,카테고리,검색)
	List<ProductVO> list(int startRec, int endRec, String listCategory, String searchType, String keyword,String gender,int mlist);
	// (관심상품)총 레코드 수
	int baskettotalRecordCount(String m_number);
	// 게시글 총 레코드 수
	int totalRecordCount();
	// 후기 게시글 총 레코드 수
	int reviewtotalRecordCount();
	// 검색 게시글 총 레코드수
	int totalRecordCount(String searchType, String keyword);
	// 내 게시글 총 레코드수
	int mytotalRecordCount(String m_number,int trsstate);
	// 내 거래요청 레코드수
	int mytransFindCriteria(String m_number,int trsstate);
	// 내 구매요청레코드수
	int reqtotalRecordCount(String m_number);
	// 총 거래요청 레코드수
	int transtotalRecordCount(String m_number);
	//총 레코드수(카테고리,검색)
	int totalRecordCount( String listCategory, String searchType, String keyword,String gender,int mlist);
	// 게시글 보기
	public ProductVO productInfo(String p_number) throws Exception;
	//지도로보기
	List<ProductVO> maplist();
	//관심상품중복확인
	BasketVO basketcheck(String basketproduct,String m_number);
	//관심상품등록
	int basketin(String basketproduct,String m_number);
	//관심상품해제
	int basketout(String basketproduct,String m_number);
	//관심상품체크
	BasketVO pbasketcheck(String p_number,String m_number);
	// 게시글 목록
	List<ProductVO> basketlist(int startRec, int endRec,String m_number);
	// 사용자 관심상품체크리스트
	List<ProductVO> basketchecklist(String m_number);
}
