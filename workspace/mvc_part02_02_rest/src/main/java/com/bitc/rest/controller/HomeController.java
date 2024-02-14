package com.bitc.rest.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	
	@GetMapping("responseData")
	public String responseData() {
		return "resData";
	}
	
	@GetMapping("js")
	public String javascriptAJAX() {
		return "javascript";
	}
	
	@GetMapping("ajaxTest")
	public String ajaxTest() {
		return "ajax";
	}
}
