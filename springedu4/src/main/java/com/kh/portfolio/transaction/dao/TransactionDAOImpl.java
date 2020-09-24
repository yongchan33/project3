package com.kh.portfolio.transaction.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.portfolio.product.svc.ProductSVCImpl;
import com.kh.portfolio.product.vo.ProductVO;
import com.kh.portfolio.transaction.vo.RequestVO;
import com.kh.portfolio.transaction.vo.ReviewVO;
import com.kh.portfolio.transaction.vo.TransactionVO;

@Repository
public class TransactionDAOImpl implements TransactionDAO {
	private static final Logger logger = LoggerFactory.getLogger(ProductSVCImpl.class);
	@Inject
	private SqlSession sqlSession;

	@Override
	public int request(RequestVO requestVO) {
		return sqlSession.insert("mappers.TransactionDAO-mapper.request", requestVO);
	}

	@Override
	public List<RequestVO> rlist(int startRec, int endRec, String m_number) {
		List<RequestVO> list = null;
		Map<String, Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		map.put("m_number", m_number);
		list = sqlSession.selectList("mappers.TransactionDAO-mapper.rlist", map);
		return list;
	}

	// 요청거절
	@Override
	public int canclerequest(String requestnumber) {
		logger.info("transactionDAOImplXML.outMember(String id, String pw) 호출됨");
		Map<String, String> map = new HashMap<>();
		map.put("requestnumber", requestnumber);

		return sqlSession.update("mappers.TransactionDAO-mapper.canclerequest", map);
	}

	@Override
	public List<TransactionVO> tlist(int startRec, int endRec, String m_number) {
		List<TransactionVO> list = null;
		Map<String, Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		map.put("m_number", m_number);
		list = sqlSession.selectList("mappers.TransactionDAO-mapper.tlist", map);
		return list;
	}

	@Override
	public int totalRecordCount(String searchType, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		return sqlSession.selectOne("mappers.TransactionDAO-mapper.searchedTotalRecordCount", map);
	}

	// 거래요청 수락
	@Override
	public int transaction(String requestnumber,String m_number,String t_content) {
		Map<String, Object> map = new HashMap<>();
		map.put("requestnumber", requestnumber);
		map.put("m_number", m_number);
		map.put("t_content", t_content);
		return sqlSession.insert("mappers.TransactionDAO-mapper.transaction",map);
	}

	// 거래요청 상태변경(판매중->거래중)
	@Override
	public int updatecondition(String requestnumber,String m_number) {
		Map<String, Object> map = new HashMap<>();
		map.put("requestnumber", requestnumber);
		map.put("m_number", m_number);
		return sqlSession.update("mappers.TransactionDAO-mapper.updatecondition",map);
	}

	// 거래취소 상태변경(거래중->판매중)
	@Override
	public int deletetransaction(String productnumber) {
		Map<String, Object> map = new HashMap<>();
		map.put("productnumber", productnumber);
		return sqlSession.update("mappers.TransactionDAO-mapper.deletetransaction", map);
	}

	// 거래상태변경(대기중'1'-> 거절'3')
	@Override
	public int utctransaction(String productnumber) {
		Map<String, Object> map = new HashMap<>();
		map.put("productnumber", productnumber);
		return sqlSession.update("mappers.TransactionDAO-mapper.utctransaction", map);
	}
	// 거래요청 상태변경('1' 대기 -> '2' 수락)
	@Override
	public int allowreqest(String requestnumber,String m_number) {
		Map<String, Object> map = new HashMap<>();
		map.put("requestnumber", requestnumber);
		map.put("m_number", m_number);
		return sqlSession.update("mappers.TransactionDAO-mapper.allowreqest",map);
	}
	@Override
	public int review(ReviewVO reviewVO) {
		logger.info("reviewDAOIMPL호출");
		return sqlSession.insert("mappers.TransactionDAO-mapper.review", reviewVO);
	}

	@Override
	public int transactionfinish(String productnumber) {
		Map<String, Object> map = new HashMap<>();
		map.put("productnumber", productnumber);
		return sqlSession.update("mappers.TransactionDAO-mapper.transactionfinish", map);
	}
	
	@Override
	public int finishtcondition(String productnumber,String m_number) {
		Map<String, Object> map = new HashMap<>();
		map.put("productnumber", productnumber);
		map.put("m_number", m_number);
		return sqlSession.update("mappers.TransactionDAO-mapper.finishtcondition", map);
	}


	@Override
	public List<RequestVO> mytransaction(int startRec, int endRec, String m_number, int trsstate) {
		List<RequestVO> list = null;
		Map<String,Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		map.put("m_number",m_number);
		map.put("trsstate",trsstate);
		list = sqlSession.selectList("mappers.TransactionDAO-mapper.mytransaction",map);		
		return list;
	}

	@Override
	public int canclesamerequest(String requestnumber) {
		Map<String, Object> map = new HashMap<>();
		map.put("requestnumber", requestnumber);
		return sqlSession.update("mappers.TransactionDAO-mapper.canclesamerequest", map);
	}

	@Override
	public RequestVO checkrequest(String m_number, String p_number) {
		Map<String, Object> map = new HashMap<>();
		map.put("m_number", m_number);
		map.put("p_number", p_number);
		return sqlSession.selectOne("mappers.TransactionDAO-mapper.checkrequest",map);
	}
	@Override
	public List<ProductVO> outmembercheck(String m_number) {
		Map<String, Object> map = new HashMap<>();
		map.put("m_number", m_number);
		return sqlSession.selectList("mappers.TransactionDAO-mapper.outmembercheck", map);
	}


}
