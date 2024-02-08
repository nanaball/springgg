package com.bitc.lombok;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LombokTest {
	
	
	@Before
	public void before() {
		System.out.println("text method 실행 전 처리되는 메소드");
	}
	
	@Test // 이 method가 junit이 테스트 하기 위한 기능 이다.
	public void lombokTest() {
		log.info("lombok library test");
		/*
		UserVO user = new UserVO("id001", "pw001", "최기근");
//		user.setUid("id001");
//		user.setUpw("pw001");
//		user.setUname("최기근");
		user.setUno(1);
		user.setRegdate(new Date());
		log.info("test user info : {} {}", user , "입니다.");
		
		UserVO user2 = new UserVO("id001", "pw001", "원빈");
		*/
		List<String> list = new ArrayList<>();
		list.add("원빈");
		list.add("이나영");
		list.add("김태희");
		list.add("비");
		list.add("유재석");
		list.add("서장훈");
		list.add("백종원");
		UserVO user = UserVO.builder().uno(1).uid("id001").upw("pw002")
									.uname("최기근").regdate(new Date())
									.friendList(list).build();
		UserVO user2 = UserVO.builder().uid("id001").upw("pw002").uname("이순신")
										.list("홍길동").list("이이").build();
		log.info("user : {} ", user);
		log.info("user2 : {} ", user2);
		log.info("user1 equals user2 - {}", user.equals(user2));
	}
	
	@After
	public void after() {
		log.warn("test method 실행 후 처리되는 메소드");
	}
}
