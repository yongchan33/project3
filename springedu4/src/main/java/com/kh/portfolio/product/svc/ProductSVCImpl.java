package com.kh.portfolio.product.svc;

import java.util.List;

import javax.inject.Inject;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kh.portfolio.common.page.FindCriteria;
import com.kh.portfolio.common.page.PageCriteria;
import com.kh.portfolio.common.page.RecordCriteria;
import com.kh.portfolio.product.dao.ProductDAO;
import com.kh.portfolio.product.vo.BasketVO;
import com.kh.portfolio.product.vo.ProductVO;

@Service
public class ProductSVCImpl implements ProductSVC {

	private static final Logger logger 
	= LoggerFactory.getLogger(ProductSVCImpl.class);

@Inject

ProductDAO productDAO;

@Inject
RecordCriteria recordCriteria;

@Inject
PageCriteria pageCriteria;

@Inject
FindCriteria findCriteria;

@Override
public int productPage(ProductVO productVO) {
	int result = 0;
	result = productDAO.productPage(productVO);
	return result;
}

@Transactional
@Override
public int productInfo(ProductVO productVO) {
	int result = 0;
	// 게시글 입력처리
	result = productDAO.productPage(productVO);

	return result;
}
//상품수정
@Override
public int modifyproductInfo(ProductVO productVO,String modifynumber) {
	int result = 0;
	// 게시글 입력처리
	result = productDAO.modifyproductPage(productVO,modifynumber);

	return result;
}

//상품 삭제
	@Override
	public int deleteproduct(String productnumber) {
		int result = 0;

		result = productDAO.deleteproduct(productnumber);

		return result;
	}
@Override
public List<ProductVO> list() {
	List<ProductVO> list = null;
	list = productDAO.list();
	return list;
}
//추천게시물
@Override
public List<ProductVO> recommandlist(String regender, String resize, String rebestcategory1,
		String rebestcategory2, String rebestcategory3, String renum) {
	
	List<ProductVO> list = null;
	list = productDAO.recommandlist(regender,resize,rebestcategory1,rebestcategory2,rebestcategory3,renum);
	return list;
}
@Override
public List<ProductVO> list(int reqPage) {
	List<ProductVO> list = null;
	//요청페이지
			recordCriteria.setReqPage(reqPage);
			//한페이이지에보여줄 레코드수 셋팅
			recordCriteria.setRecNumPerPage(10);
			list = productDAO.list(recordCriteria.getStarRec(),
													 recordCriteria.getEndRec());
			return list;
}
//게시글 목록(검색포함)
@Override
public List<ProductVO> list(int reqPage, String searchType, String keyword) {
	List<ProductVO> list = null;

	//요청페이지
	recordCriteria.setReqPage(reqPage);
	//한페이이지에보여줄 레코드수 셋팅
	recordCriteria.setRecNumPerPage(10);
	list = productDAO.list(recordCriteria.getStarRec(),
											 recordCriteria.getEndRec(),
											 searchType,
											 keyword);

	return list;
}

@Override
public List<ProductVO> list(int reqPage, String listCategory, String searchType, String keyword,String gender,int mlist) {
	List<ProductVO> list = null;
	logger.info("genderlist"+gender);
	//요청페이지
	recordCriteria.setReqPage(reqPage);
	//한페이이지에보여줄 레코드수 셋팅
	recordCriteria.setRecNumPerPage(10);
	logger.info("시작레코드,종료레코드 계산"+recordCriteria.getStarRec()+"/"+recordCriteria.getEndRec());
	list = productDAO.list(recordCriteria.getStarRec(),
											 recordCriteria.getEndRec(),
											 listCategory,
											 searchType,
											 keyword,
											gender,
											mlist
			);

	return list;
}
//페이징제어 반환
	@Override
	public PageCriteria getPageCriteria(int reqPage) {

		//한페이지에 보여줄 레코드수
		recordCriteria.setRecNumPerPage(10);
		//사용자의 요청페이지
		recordCriteria.setReqPage(reqPage);
		//한페이지에보여줄 페이지수
		pageCriteria.setPageNumPerPage(10);
		//레코드정보
		pageCriteria.setRc(recordCriteria);


		//게시글 총 레코드 건수
		pageCriteria.setTotalRec(productDAO.totalRecordCount());
		//페이징계산
		pageCriteria.calculatePaging();


		return pageCriteria;
	}
	//페이징제어 + 검색어포함
		@Override
		public FindCriteria getFindCriteria(int reqPage, String searchType, String keyword) {

			//한페이지에 보여줄 레코드수
			recordCriteria.setRecNumPerPage(10);
			//사용자의 요청페이지
			recordCriteria.setReqPage(reqPage);
			//한페이지에보여줄 페이지수
			pageCriteria.setPageNumPerPage(10);
			//레코드정보
			pageCriteria.setRc(recordCriteria);

			//검색어정보
			findCriteria.setPageCriteria(pageCriteria);
			findCriteria.setSearchType(searchType);
			findCriteria.setKeyword(keyword);

			//게시글 총 레코드 건수
			findCriteria.getPageCriteria().setTotalRec(productDAO.totalRecordCount(searchType,keyword));
			//페이징계산
			pageCriteria.calculatePaging();

			return findCriteria;
		}
		
		//(내상품)페이징제어 + 검색어포함
				@Override
				public FindCriteria mygetFindCriteria(int reqPage,String m_number,int trsstate) {

					//한페이지에 보여줄 레코드수
					recordCriteria.setRecNumPerPage(10);
					//사용자의 요청페이지
					recordCriteria.setReqPage(reqPage);
					//한페이지에보여줄 페이지수
					pageCriteria.setPageNumPerPage(10);
					//레코드정보
					pageCriteria.setRc(recordCriteria);

					//검색어정보
					findCriteria.setPageCriteria(pageCriteria);
					//게시글 총 레코드 건수
					findCriteria.getPageCriteria().setTotalRec(productDAO.mytotalRecordCount(m_number,trsstate));
					//페이징계산
					pageCriteria.calculatePaging();
					return findCriteria;
				}
		@Override
		public FindCriteria getFindCriteria(int reqPage, String listCategory, String searchType, String keyword,String gender,int mlist) {
			//사용자의 요청페이지
			recordCriteria.setReqPage(reqPage);
			//한페이지에 보여줄 레코드수
			recordCriteria.setRecNumPerPage(10);
			//한페이지에보여줄 페이지수
			pageCriteria.setPageNumPerPage(10);
			//레코드정보
			pageCriteria.setRc(recordCriteria);
			
			//검색어정보
			findCriteria.setPageCriteria(pageCriteria);
			findCriteria.setSearchType(searchType);
			findCriteria.setKeyword(keyword);
			findCriteria.setListCategory(listCategory);
			findCriteria.setGedner(gender);

			//게시글 총 레코드 건수
			findCriteria.getPageCriteria().setTotalRec(productDAO.totalRecordCount(listCategory,searchType,keyword,gender,mlist));

			//페이징계산
			pageCriteria.calculatePaging();
			return findCriteria;
		}

		//게시글 보기

		@Override
		public ProductVO productInfo(String p_number) throws Exception {
			
			return productDAO.productInfo(p_number);
		}


		//지도로보기
		@Override
		public List<ProductVO> maplist() {
			List<ProductVO> list = null;
			
			list = productDAO.maplist();
			
			return list;
		}

		@Override
		public List<ProductVO> myproduct(int reqPage,String m_number,int trsstate) {
			List<ProductVO> list = null;

			//요청페이지
			recordCriteria.setReqPage(reqPage);
			//한페이이지에보여줄 레코드수 셋팅
			recordCriteria.setRecNumPerPage(10);
			list = productDAO.myproduct(recordCriteria.getStarRec(),
													 recordCriteria.getEndRec(),
													 m_number,
													 trsstate);

			return list;
		}
		// (관심상품)페이징제어
		@Override
		public FindCriteria basketFindCriteria(int reqPage, String m_number) {

			//한페이지에 보여줄 레코드수
			recordCriteria.setRecNumPerPage(10);
			//사용자의 요청페이지
			recordCriteria.setReqPage(reqPage);
			//한페이지에보여줄 페이지수
			pageCriteria.setPageNumPerPage(10);
			//레코드정보
			pageCriteria.setRc(recordCriteria);
			
			//검색어정보
			findCriteria.setPageCriteria(pageCriteria);
			//게시글 총 레코드 건수
			findCriteria.getPageCriteria().setTotalRec(productDAO.baskettotalRecordCount(m_number));
			//페이징계산
			pageCriteria.calculatePaging();

			return findCriteria;
		}
		
		@Override
		public FindCriteria reviewgetFindCriteria(int reqPage) {

			//한페이지에 보여줄 레코드수
			recordCriteria.setRecNumPerPage(10);
			//사용자의 요청페이지
			recordCriteria.setReqPage(reqPage);
			//한페이지에보여줄 페이지수
			pageCriteria.setPageNumPerPage(10);
			//레코드정보
			pageCriteria.setRc(recordCriteria);
			
			//검색어정보
			findCriteria.setPageCriteria(pageCriteria);
			//게시글 총 레코드 건수
			findCriteria.getPageCriteria().setTotalRec(productDAO.reviewtotalRecordCount());
			//페이징계산
			pageCriteria.calculatePaging();

			return findCriteria;
		}

		@Override
		public FindCriteria getreqFindCriteria(int reqPage, String m_number) {

			//한페이지에 보여줄 레코드수
			recordCriteria.setRecNumPerPage(10);
			//사용자의 요청페이지
			recordCriteria.setReqPage(reqPage);
			//한페이지에보여줄 페이지수
			pageCriteria.setPageNumPerPage(10);
			//레코드정보
			pageCriteria.setRc(recordCriteria);

			//검색어정보
			findCriteria.setPageCriteria(pageCriteria);
			//게시글 총 레코드 건수
			findCriteria.getPageCriteria().setTotalRec(productDAO.reqtotalRecordCount(m_number));
			//페이징계산
			pageCriteria.calculatePaging();

			return findCriteria;
		}
		@Override
		public FindCriteria gettransFindCriteria(int reqPage, String m_number) {

			//한페이지에 보여줄 레코드수
			recordCriteria.setRecNumPerPage(10);
			//사용자의 요청페이지
			recordCriteria.setReqPage(reqPage);
			//한페이지에보여줄 페이지수
			pageCriteria.setPageNumPerPage(10);
			//레코드정보
			pageCriteria.setRc(recordCriteria);

			//검색어정보
			findCriteria.setPageCriteria(pageCriteria);
			//게시글 총 레코드 건수
			findCriteria.getPageCriteria().setTotalRec(productDAO.transtotalRecordCount(m_number));
			//페이징계산
			pageCriteria.calculatePaging();

			return findCriteria;
		}

		@Override
		public ProductVO getproduct(String modifynumber) {
			ProductVO productVO = null;
			productVO = productDAO.getproduct(modifynumber);
			return productVO;
		}

		@Override
		public BasketVO basketcheck(String basketproduct, String m_number) {
			BasketVO basketVO = null;
			// 게시글 입력처리
			basketVO = productDAO.basketcheck(basketproduct,m_number);

			return basketVO;
		}
		//관심상품등록
		@Override
		public int basketin(String basketproduct, String m_number) {
			int result = 0;
			// 게시글 입력처리
			result = productDAO.basketin(basketproduct,m_number);

			return result;
		}
		//관심상품해제
		@Override
		public int basketout(String basketproduct, String m_number) {
			int result = 0;
			// 게시글 입력처리
			result = productDAO.basketout(basketproduct,m_number);

			return result;
		}

		//관심상품여부확인
		@Override
		public BasketVO pbasketcheck(String p_number,String m_number) {
			BasketVO basketVO = null;
			// 게시글 입력처리
			basketVO = productDAO.pbasketcheck(p_number,m_number);

			return basketVO;
		}

		@Override
		public List<ProductVO> basketlist(int reqPage, String m_number) {
			List<ProductVO> list = null;

			//요청페이지
			recordCriteria.setReqPage(reqPage);
			//한페이이지에보여줄 레코드수 셋팅
			recordCriteria.setRecNumPerPage(10);
			list = productDAO.basketlist(recordCriteria.getStarRec(),
													 recordCriteria.getEndRec(),
													 m_number);

			return list;
		}

		@Override
		public List<ProductVO> basketchecklist(String m_number) {
			List<ProductVO> list = null;
			
			list = productDAO.basketchecklist(m_number);
			
			return list;
		}

		@Override
		public List<ProductVO> myallproduct(String m_number) {
			List<ProductVO> list = null;
			
			list = productDAO.myallproduct(m_number);
			
			return list;
		}
		//내 거래 보기
		@Override
		public FindCriteria mytransFindCriteria(int reqPage, String m_number, int trsstate) {
			//한페이지에 보여줄 레코드수
			recordCriteria.setRecNumPerPage(10);
			//사용자의 요청페이지
			recordCriteria.setReqPage(reqPage);
			//한페이지에보여줄 페이지수
			pageCriteria.setPageNumPerPage(10);
			//레코드정보
			pageCriteria.setRc(recordCriteria);

			//검색어정보
			findCriteria.setPageCriteria(pageCriteria);
			//게시글 총 레코드 건수
			findCriteria.getPageCriteria().setTotalRec(productDAO.mytransFindCriteria(m_number,trsstate));
			//페이징계산
			pageCriteria.calculatePaging();
			return findCriteria;
		}


		
		

		
		

}
