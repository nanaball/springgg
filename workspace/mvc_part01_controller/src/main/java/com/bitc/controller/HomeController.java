package com.bitc.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	public HomeController() {
		System.out.println("HomeController 생성..");
	}
	
	@RequestMapping(value = "main.home", method = RequestMethod.GET)
	public String home(HttpSession session, Model model) {
		System.out.println("main.home 요청처리 method 실행");
		session.setAttribute("test", "session test");
		model.addAttribute("modelTest", "test model");
		// /WEB-INF/views/"+"home"+".jsp"
		return "home";
		
	}
	
}