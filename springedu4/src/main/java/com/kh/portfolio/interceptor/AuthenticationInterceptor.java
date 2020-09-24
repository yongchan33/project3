package com.kh.portfolio.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.kh.portfolio.member.svc.MemberSVC;
import com.kh.portfolio.member.vo.MemberVO;
 
// 로그인처리를 담당하는 인터셉터
public class AuthenticationInterceptor extends HandlerInterceptorAdapter{
	private static final Logger logger
	= LoggerFactory.getLogger(AuthenticationInterceptor.class);
	@Inject
	MemberSVC memberSVC;
     
    // preHandle() : 컨트롤러보다 먼저 수행되는 메서드
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
    	String uri					= request.getRequestURI();
		String contextPath	= request.getContextPath();
		String reqURI				= uri.substring(contextPath.length());
         logger.info("AuthenticationInterceptor 호출됨");
        // session 객체를 가져옴
        HttpSession session = request.getSession();
        // login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
    	Object obj = session.getAttribute("member");
        
        if ( obj ==null ){// 로그인된 세션이 없는 경우...
            // 우리가 만들어 논 쿠키를 꺼내온다.
            Cookie loginCookie = WebUtils.getCookie(request,"loginCookie");
            if ( loginCookie !=null ){// 쿠키가 존재하는 경우(이전에 로그인때 생성된 쿠키가 존재한다는 것)
                // loginCookie의 값을 꺼내오고 -> 즉, 저장해논 세션Id를 꺼내오고
                String sessionId = loginCookie.getValue();
                // 세션Id를 checkUserWithSessionKey에 전달해 이전에 로그인한적이 있는지 체크하는 메서드를 거쳐서
                // 유효시간이 > now() 인 즉 아직 유효시간이 지나지 않으면서 해당 sessionId 정보를 가지고 있는 사용자 정보를 반환한다.
                logger.info("sessionId세션아이디"+sessionId);
                MemberVO memberVO = memberSVC.checkUserWithSessionKey(sessionId);
                if ( memberVO !=null ){// 그런 사용자가 있다면
                    // 세션을 생성시켜 준다.
                    session.setAttribute("member", memberVO);
                    return true;
                }
            }
             
            // 이제 아래는 로그인도 안되있고 쿠키도 존재하지 않는 경우니까 다시 로그인 폼으로 돌려보내면 된다.
            // 로그인이 안되어 있는 상태임으로 로그인 폼으로 다시 돌려보냄(redirect)
            response.sendRedirect(request.getContextPath()+"/loginForm?reqURI="+reqURI);
          
            return false;// 더이상 컨트롤러 요청으로 가지 않도록 false로 반환함
        }
         
        // preHandle의 return은 컨트롤러 요청 uri로 가도 되냐 안되냐를 허가하는 의미임
        // 따라서 true로하면 컨트롤러 uri로 가게 됨.
        return true;
    }
 
    // 컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView)throws Exception {
        // TODO Auto-generated method stub
        super.postHandle(request, response, handler, modelAndView);
    }
     
}

