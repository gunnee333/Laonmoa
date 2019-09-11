package com.laonmoa.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class InterceptorBean implements HandlerInterceptor {

	// Controller 가 요청하기 전에 호출되는 메소드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 클라이언트에 부여한 세션을 가져온다.
		HttpSession session = request.getSession();

		if (session.getAttribute("id") == null) { // 로그인상태가 아니라면 로그인으로 이동시킴
			response.sendRedirect(request.getContextPath() + "/loginpage");
			return false;
		}
		return true;
	}

	// 예외가 발생되지 않은 경우에 Controller 의 작업이 끝나면 호출되는 메소드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	// 예외가 발생과 상관없이 Controller 의 작업이 끝나면 호출되는 메소드
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
