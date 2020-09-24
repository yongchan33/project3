package com.kh.portfolio.log.svc;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.kh.portfolio.log.dao.LogDAO;
import com.kh.portfolio.log.vo.LogVO;
import com.kh.portfolio.member.dao.MemberDAO;
@Service
public class LogSVCImpl implements LogSVC{
		private static final Logger logger 
		= LoggerFactory.getLogger(LogSVCImpl.class);
		
		@Inject
		@Qualifier("memberDAOImplXML")
		MemberDAO memberDAO;
		
		@Inject
		LogDAO logDAO;
		
		//로그 등록
		@Override
		public int addLog(LogVO logVO) {
			int result = 0;
			result = logDAO.addLog(logVO);

			return result;
		}
		@Override
		public List<LogVO> listAllLog(String l_m_number) {
			List<LogVO> list = null;
			list = logDAO.listAllLog(l_m_number);

			return list;
		}
	
	
}