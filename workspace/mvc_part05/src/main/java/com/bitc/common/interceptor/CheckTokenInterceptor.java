package com.bitc.common.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CheckTokenInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("CSRF 인증 토큰 확인");
		if(request.getMethod().toUpperCase().equals("POST")) {
			HttpSession session = request.getSession();
			String sessionToken = (String)session.getAttribute("csrf_token");
			String requestToken = request.getParameter("csrf_token");
			if(requestToken == null 
				|| requestToken.equals("") 
				|| !requestToken.equals(sessionToken)) {
				// 정상적인 경로로 우리 사이트를 통해 요청이 전달된게 아님
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('잘못된 접근입니다.');");
				out.println("history.go(-1);");
				out.println("</script>");
				return false;
			}
		}
		return true;
	}

	
	
}






