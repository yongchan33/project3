package com.kh.portfolio.log.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.portfolio.log.vo.LogVO;
import com.kh.portfolio.product.vo.ProductVO;

@Repository
public class LogDAOImpl implements LogDAO {

	private static final Logger logger
	= LoggerFactory.getLogger(LogDAOImpl.class);

@Inject
	private SqlSession sqlSession;

//로그기록
@Override
public int addLog(LogVO logVO) {
	logger.info("로그"+logVO.toString());
	return sqlSession.insert("mappers.LogDAO-mapper.addLog",logVO);
}

//로그 조회
@Override
public List<LogVO> listAllLog(String l_m_number) {
	List<LogVO> list = null;
	list = sqlSession.selectList("mappers.LogDAO-mapper.listAllLog",l_m_number);		
	return list;
}



	
}
