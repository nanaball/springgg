package com.bitc.di.controller.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.bitc.di.dao.TestDAO;
import com.bitc.di.service.TestService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor	// 필수 인자로 생성자 값 만듬
public class MainController {
	
//	@Autowired - final 지정해서 생성자 만들어서 
	private final TestService ts;
	private final TestDAO td;
	
	/*
	public MainController(TestService ts, TestDAO td){
		this.ts = ts;
		this.td = td;
	}
	*/
	
	@GetMapping("main")
	public String main() {
		System.out.println("MainController test Service : " + ts);
		return "home";
	}
}
