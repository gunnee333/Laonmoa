package com.laon.moa;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SessionFilter implements Filter {

	// 세션 id값 없으면 로그인페이지로 이동시키는 필터
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("html/text;charset=UTF-8");
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;

		HttpSession session = request.getSession();
		String requestURL = request.getRequestURI();
		System.out.println(requestURL);
		if (requestURL.equals("/adminLogin") || requestURL.equals("/login")) {
			chain.doFilter(req, res);
		} else {
			if (session == null || session.getAttribute("id") == null) {
				response.sendRedirect("/adminLogin");
			} else {
				chain.doFilter(req, res);
			}
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	@Override
	public void destroy() {
		System.out.println("SessionFilter Destroy!");
	}

}
