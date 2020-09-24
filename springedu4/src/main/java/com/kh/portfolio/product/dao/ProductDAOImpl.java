package com.kh.portfolio.product.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.portfolio.product.vo.BasketVO;
import com.kh.portfolio.product.vo.ProductVO;

@Repository
public class ProductDAOImpl implements ProductDAO {

	private static final Logger logger
	= LoggerFactory.getLogger(ProductDAOImpl.class);

@Inject
	private SqlSession sqlSession;


//판매하기페이지
@Override
public int productPage(ProductVO productVO) {
	logger.info("테스트1"+productVO.toString());
	return sqlSession.insert("mappers.ProductDAO-mapper.productPage",productVO);
}
@Override
public int modifyproductPage(ProductVO productVO,String modifynumber) {
	logger.info("modifyproductPage CALL!!"+productVO.toString());
	Map<String,Object> map = new HashMap<>();
	map.put("productVO", productVO);
	map.put("modifynumber", modifynumber);
	return sqlSession.update("mappers.ProductDAO-mapper.modifyproductPage",map);
}

@Override
public int productInfo(ProductVO productVO) {
	return sqlSession.insert("mappers.ProductDAO-mapper.productInfo");
}

//게시글 목록
@Override
public List<ProductVO> list() {
	List<ProductVO> list = null;
	
	list = sqlSession.selectList("mappers.ProductDAO-mapper.manlist");
	
	return list;
}

//상품 삭제
@Override
public int deleteproduct(String productnumber) {
//	logger.info("MemberDAOImplXML.outMember(String id, String pw) 호출됨");
	Map<String,String> map = new HashMap<>();
	map.put("productnumber",productnumber);
	
	return sqlSession.delete("mappers.ProductDAO-mapper.deleteproduct", map);
}
@Override
public List<ProductVO> list(int startRec, int endRec) {
	List<ProductVO> list = null;
	Map<String,Object> map = new HashMap<>();
	map.put("startRec", startRec);
	map.put("endRec", endRec);
	list = sqlSession.selectList("mappers.ProductDAO-mapper.list2",map);		
	return list;
}
//게시글 목록(검색포함)
@Override
public List<ProductVO>myproduct(int startRec, int endRec,String m_number,int trsstate) {
	List<ProductVO> list = null;
	Map<String,Object> map = new HashMap<>();
	map.put("startRec", startRec);
	map.put("endRec", endRec);
	map.put("m_number",m_number);
	map.put("trsstate",trsstate);
	list = sqlSession.selectList("mappers.ProductDAO-mapper.myproduct",map);		
	return list;
}
//추천목록
@Override
public List<ProductVO> recommandlist(String regender, String resize, String rebestcategory1, String rebestcategory2,
		String rebestcategory3, String renum) {
	List<ProductVO> list = null;
	Map<String,Object> map = new HashMap<>();
	map.put("regender", regender);
	map.put("resize", resize);
	map.put("rebestcategory1", rebestcategory1);
	map.put("rebestcategory2", rebestcategory2);
	map.put("rebestcategory3", rebestcategory3);
	map.put("renum", renum);
	list = sqlSession.selectList("mappers.ProductDAO-mapper.recommandlist",map);		
	return list;
}
//게시글 목록(검색포함)
	@Override
	public List<ProductVO> list(int startRec, int endRec, String searchType, String keyword) {
		List<ProductVO> list = null;
		Map<String,Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		list = sqlSession.selectList("mappers.ProductDAO-mapper.list2",map);		
		return list;
	}
	@Override
	public List<ProductVO> list(int startRec, int endRec, String listCategory, String searchType, String keyword,String gender,int mlist) {
		List<ProductVO> list = null;
		Map<String,Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		map.put("listCategory", listCategory);
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		map.put("gender", gender);
		map.put("mlist", mlist);
		logger.info("genderdao"+gender);
		list = sqlSession.selectList("mappers.ProductDAO-mapper.list",map);		
		return list;
	}
//게시글 총 레코드 수 
	@Override
	public int totalRecordCount() {
		return sqlSession.selectOne("mappers.ProductDAO-mapper.totalRecordCount");
	}
	@Override
	public int totalRecordCount(String searchType, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		return sqlSession.selectOne("mappers.ProductDAO-mapper.searchedTotalRecordCount",map);
	}
	
	@Override
	public int mytotalRecordCount(String m_number,int trsstate) {
		Map<String, Object> map = new HashMap<>();
		map.put("m_number", m_number);
		map.put("trsstate", trsstate);
		return sqlSession.selectOne("mappers.ProductDAO-mapper.mysearchedTotalRecordCount",map);
	}
	
	@Override
	public int totalRecordCount(String listCategory, String searchType, String keyword,String gender,int mlist) {
		Map<String, Object> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		map.put("listCategory", listCategory);
		map.put("gender", gender);
		map.put("mlist", mlist);
		return sqlSession.selectOne("mappers.ProductDAO-mapper.searchedTotalRecordCount",map);
	}
	
	//게시글 보기
	@Override
	public ProductVO productInfo(String p_number) throws Exception {

		return sqlSession.selectOne("mappers.ProductDAO-mapper.productInfo",Long.valueOf(p_number));

	}

	//지도로보기
	@Override
	public List<ProductVO> maplist() {
		List<ProductVO> list = null;
		
		list = sqlSession.selectList("mappers.ProductDAO-mapper.maplist");
		
		return list;
	}
	@Override
	public int baskettotalRecordCount(String m_number) {
		Map<String, Object> map = new HashMap<>();
		map.put("m_number", m_number);
		return sqlSession.selectOne("mappers.ProductDAO-mapper.baskettotalRecordCount",map);
	}

	@Override
	public int reqtotalRecordCount(String m_number) {
		Map<String, Object> map = new HashMap<>();
		map.put("m_number", m_number);
		return sqlSession.selectOne("mappers.ProductDAO-mapper.reqsearchedTotalRecordCount",map);
	}
	
	@Override
	public int transtotalRecordCount(String m_number) {
		Map<String, Object> map = new HashMap<>();
		map.put("m_number", m_number);
		return sqlSession.selectOne("mappers.ProductDAO-mapper.transsearchedTotalRecordCount",map);
	}


	@Override
	public ProductVO getproduct(String modifynumber) {

		return sqlSession.selectOne("mappers.ProductDAO-mapper.getproduct",modifynumber);
	}
	@Override
	public BasketVO basketcheck(String basketproduct, String m_number) {
		Map<String, Object> map = new HashMap<>();
		map.put("basketproduct", basketproduct);
		map.put("m_number", m_number);
		return sqlSession.selectOne("mappers.ProductDAO-mapper.basketcheck",map);
	}
	//관심상품등록
	@Override
	public int basketin(String basketproduct, String m_number) {
		Map<String, Object> map = new HashMap<>();
		map.put("basketproduct", basketproduct);
		map.put("m_number", m_number);
		return sqlSession.insert("mappers.ProductDAO-mapper.basketin",map);
	}
	//관심상품해제
	@Override
	public int basketout(String basketproduct, String m_number) {
		Map<String, Object> map = new HashMap<>();
		map.put("basketproduct", basketproduct);
		map.put("m_number", m_number);
		return sqlSession.delete("mappers.ProductDAO-mapper.basketout",map);
	}
	@Override
	public BasketVO pbasketcheck(String p_number, String m_number) {
		Map<String, Object> map = new HashMap<>();
		map.put("basketproduct", p_number);
		map.put("m_number", m_number);
		return sqlSession.selectOne("mappers.ProductDAO-mapper.basketcheck",map);
	}
	@Override
	public List<ProductVO> basketlist(int startRec, int endRec, String m_number) {
		List<ProductVO> list = null;
		Map<String,Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		map.put("m_number",m_number);
		list = sqlSession.selectList("mappers.ProductDAO-mapper.basketlist",map);		
		return list;
	}
	@Override
	public List<ProductVO> basketchecklist(String m_number) {
		List<ProductVO> list = null;
		Map<String,Object> map = new HashMap<>();
		map.put("m_number", m_number);
		list = sqlSession.selectList("mappers.ProductDAO-mapper.basketchecklist",map);		
		return list;
	}
	// 후기 게시글 총 레코드 수
	@Override
	public int reviewtotalRecordCount() {
		return sqlSession.selectOne("mappers.ProductDAO-mapper.reviewtotalRecordCount");
	}
	@Override
	public List<ProductVO> myallproduct(String m_number) {
		List<ProductVO> list = null;
		Map<String,Object> map = new HashMap<>();
		map.put("m_number", m_number);
		list = sqlSession.selectList("mappers.ProductDAO-mapper.myallproduct",map);		
		return list;
	}
	@Override
	public int mytransFindCriteria(String m_number, int trsstate) {
		Map<String, Object> map = new HashMap<>();
		map.put("m_number", m_number);
		map.put("trsstate", trsstate);
		return sqlSession.selectOne("mappers.ProductDAO-mapper.mytransTotalRecordCount",map);
	}
	


	




	
}
