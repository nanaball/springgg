package com.bitc.di.service;

import org.springframework.stereotype.Service;

// @Service
// interface는 instance 생성이 불가능하기 때문에 component로 등록될 수 없음
public interface TestService {

	void testService(String message);
	
	
}
