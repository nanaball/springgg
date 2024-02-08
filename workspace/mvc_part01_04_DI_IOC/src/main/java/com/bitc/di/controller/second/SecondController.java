package com.bitc.di.controller.second;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.bitc.di.dao.TestDAO;
import com.bitc.di.service.TestService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SecondController {

	
	@Resource(name="path")
	private String path;
	
	@Autowired(required = false)
	TestService ts;
	
	@Autowired(required = false)
	@Qualifier(value="td")
	TestDAO td;
	
	
	public SecondController() {
		log.info("SecondController 생성");
		log.info("second path : {}", path);
		log.info("second ts : {}", ts);
		log.info("second td : {}", td);
	}
	
	/**
	 * bean 객체가 생성이 되고나서 container에 의해 의존성 주입이 완료되고 
	 * 객체가 사용될 준비가 완료되면 bean으로 등록되지 전에 최초에 한번 호출되는 method
	 */
	@PostConstruct
	public void init() {
		log.warn("PostConstruct init() 호출");
		log.info("PostConstruct second path : {}", path);
		log.info("PostConstruct second ts : {}", ts);
		log.info("PostConstruct second td : {}", td);
	}
	
	@GetMapping("main")
	public void doMain() {
		log.info("second controller do main 호출");
	}
}
