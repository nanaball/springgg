package com.bitc.di.controller.home;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.inject.Named;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bitc.di.dao.TestDAO;
import com.bitc.di.service.TestService;
import com.bitc.di.vo.TestBoardVO;

/**
 * context:component-scan 으로 Bean으로 <등록>되는 annotation
 * @Controller : presentation Layer에서 controller를 명시하기 위해서 사용
 * @Service : Business Layer에서 Service를 명시하기 위해서 사용
 * @Repository : Persistence Layer에서 Data Access Object 또는 저장소를 명시하기 위해 사용
 * @Component : 그 외의 의미를 두지 않는 class를 Bean으로 등록하고 관리하기 위해 사용
 * @Component 의 하위 형태로 @Controller, @Service, @Repository가 존재 
 */

/**
 * DI Annotation (Dependency Injection) - 의존성 주입
 * spring에 의해서 관리되는 bean 객체를 우리가 원하는 필드에 <주입받아 사용>하게 해주는 annotation
 * 											@Inject @Named @Resource 자바 1.8까지만 기본 포함
 * 			 @Autowired			@Qualifier				@Inject					@Resource
 * 범용성 	  스프링 전용			 스프링 전용		   	   자바에서 직원				자바에서 지원
 * 연결성		타입에 맞춰서 주입		Bean의 name을 		 타입에 맞춰서 주입			이름으로 검색 후 타입으로 검색
 * 								 이용하여 주입			@Named를 이용해서
 * 								 독립적인 사용x			이름으로 구분해서 주입가능
 * 
 */

@Controller
public class HomeController {
	
	@Autowired 	// 의존성 주입
	TestService ts;
	
	// @Autowired
	// private String uploadPath;
	
	// 이름으로 먼저 검색
	@Resource(name="path")
	private String uploadPath;
	
	@Inject
//	@Named("size")
	private int size;
	
//	@Autowired
//	private String upload;
	
	@Autowired
	@Qualifier(value="upload")
	private String uploadDir;
	
	
				// 기본값은 true | false면 검색된 값이 없어도 사용가능함
	@Autowired(required=false)
	private TestDAO td;
	
	@Autowired
	private TestBoardVO vo;
	
	
	
	
	
	
	
	
	@GetMapping("/")
	public String home() {	
	
		System.out.println(vo);
		System.out.println("uploadPath : " + uploadPath);
		System.out.println("size : " + size);
//		System.out.println("upload : " + upload);
		System.out.println("uploadDir : " + uploadDir);
		
		if(ts != null) {
			ts.testService("Home Controller");
		}else {
			System.out.println("HomeController ts is null");
		}
		
		if(td != null) {
			td.select("Home Controller");
		}else {
			System.out.println("HomeController td is null");
		}
		
		return "home";
	}
	
}
