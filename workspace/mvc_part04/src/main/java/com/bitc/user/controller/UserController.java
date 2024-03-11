package com.bitc.user.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.bitc.user.service.UserService;
import com.bitc.user.vo.LoginDTO;
import com.bitc.user.vo.UserVO;

import lombok.RequiredArgsConstructor;


@Controller
@RequestMapping("user")	// 현재 주소표시줄의 마지막 /가 기준이 됨 
@RequiredArgsConstructor
public class UserController {
	
	/**
	 * 필수 인자값을 가진 생성자를 이용한 의존성 주입
	 */
	private final UserService us;

	@RequestMapping("/signIn")
	public String signIn() {
		return "user/signIn";
	}
	
	@GetMapping("/signUp")
	public void signUp() {	
	}
	
	// 회원가입
	@PostMapping("/signUpPost")			// 세션에 정보 저장 
	public String signUpPost(UserVO vo, RedirectAttributes rttr) throws Exception{
		
		us.signUp(vo);
		rttr.addFlashAttribute("message", "회원가입 성공");
		return "redirect:/user/signIn";
	}
	
	// 로그인
	@PostMapping("/signInPost")
	public ModelAndView signInPost(LoginDTO dto, HttpSession session) throws Exception{	
		ModelAndView mav = new ModelAndView();	// ModelAndView : 저장해야할 모델과 뷰의 정보 
		UserVO userVO = us.signIn(dto);
		session.setAttribute("userInfo", userVO);
		mav.setViewName("redirect:/");
		return mav;
	}
	
	// 로그아웃
	@GetMapping("/signOut")
	public String signOut(
			HttpServletResponse response,	// response가 있어야 쿠키 정보 전달함(=>응답객체 받아옴)
//			HttpServletRequest request,
			@CookieValue(name="signInCookie", required=false) Cookie cookie,
			HttpSession session) throws Exception{
		session.removeAttribute("userInfo");
//		Cookie cookie = WebUtils.getCookie(request, "signInCookie");
		if(cookie != null) {
			cookie.setPath("/");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		return "redirect:/";
		
	}
	
}
