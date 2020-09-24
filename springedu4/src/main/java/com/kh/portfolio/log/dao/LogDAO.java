package com.kh.portfolio.log.dao;

import java.util.List;

import com.kh.portfolio.log.vo.LogVO;
import com.kh.portfolio.product.vo.ProductVO;

public interface LogDAO {

	//로그등록
	int addLog(LogVO logVO);
	//로그 전체조회
	List<LogVO> listAllLog(String l_m_number);
}
