package com.kh.portfolio.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.portfolio.board.vo.FaqVO;
import com.kh.portfolio.product.vo.ProductVO;
import com.kh.portfolio.transaction.vo.ReviewVO;


@Repository
public class BoardDAOImplXML implements BoardDAO {
	
	private static final Logger logger =
			LoggerFactory.getLogger(BoardDAOImplXML.class);
	
	@Inject
	private SqlSession sqlSession;

	//FAQ목록
	@Override
	public List<FaqVO> faq() {
		List<FaqVO> list = null;
		
		list = sqlSession.selectList("mappers.BoardDAO-mapper.faq");
		
		return list;
	}
	


//리뷰작성
	@Override
	public int review(ReviewVO reviewVO) {
		logger.info("reviewDAOIMPL호출");
		return sqlSession.insert("mappers.BoardDAO-mapper.review",reviewVO);
	}

	//리뷰 리스트
	@Override
	public List<ProductVO> relist(int startRec, int endRec) {
		List<ProductVO> list = null;
		Map<String,Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		list = sqlSession.selectList("mappers.BoardDAO-mapper.relist",map);		
		return list;
	}



	@Override
	public List<ProductVO> myrelist(String m_number) {
		List<ProductVO> list = null;
		Map<String,Object> map = new HashMap<>();
		map.put("m_number", m_number);
		list = sqlSession.selectList("mappers.BoardDAO-mapper.myrelist",map);		
		return list;
	}



}





