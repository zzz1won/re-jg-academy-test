package kr.disable.jugd.academy.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Configuration
public class AuthInterceptor extends HandlerInterceptorAdapter{

	Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	// 컨트롤러보다 먼저 수행
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// session 객체를 가지고온다.
		HttpSession session = request.getSession(false);
		
		try {
			if(request.getServletPath().indexOf("admin") != -1) {
				if(session.getAttribute("ADMIN") == null) {
					response.sendRedirect("/admin/index/");
					return false;
				} else {
					return true;
				}
			}
			
			if(request.getServletPath().indexOf("judge") != -1) {
				if(session.getAttribute("USER") == null) {
					response.sendRedirect("/judge/index/");
					return false;
				} else {
					return true;
				}
			}
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		return true;
	}

	// 컨트롤러가 수행되고 화면이 보여지기 직전에 수행
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}
}
