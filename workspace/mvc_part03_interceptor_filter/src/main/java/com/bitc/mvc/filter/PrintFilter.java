package com.bitc.mvc.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;

import org.springframework.beans.factory.annotation.Autowired;

import com.bitc.mvc.VO.TestVO;

import lombok.extern.slf4j.Slf4j;

// WebFilter : web.xml 에 스프링에서 만든 filter를 안쓰고 프린트 필터에서 바로 적용
@WebFilter(
		urlPatterns = "/*",
		initParams = @WebInitParam(name="encoding", value="UTF-8")
		)
@Slf4j
public class PrintFilter implements Filter{
	
	@Autowired(required = false)
	TestVO test;
	
	// 필터 등록은 배포서술자(web.xml)에
	
	private String encodingName;
	
	// ALT + S+ V
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		log.info("PrintFilter 초기화 시작 --- " );
		encodingName = filterConfig.getInitParameter("encoding");
		log.info("encodingNamev : {} " , encodingName);
		log.info("PrintFilter 초기화 종료 --- " );
	}


	public void doFilter(
			ServletRequest request, 
			ServletResponse response, FilterChain chain)
			throws IOException, ServletException{
		log.info("PrintFilter doFilter START -----------------------------------");
		log.info("filter testVO injection : {} ", test);
		request.setCharacterEncoding(encodingName);
		chain.doFilter(request, response);
		log.info("PrintFilter doFilter END-- -----------------------------------");
	}


	@Override
	public void destroy() { // server가 리스타트 되거나 ㅇㅇ 할때 마지막쯤
		log.info("PrintFilter destroy() ========");
	}

}
