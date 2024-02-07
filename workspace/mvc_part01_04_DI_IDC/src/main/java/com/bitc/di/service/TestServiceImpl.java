package com.bitc.di.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bitc.di.dao.TestDAO;
import com.bitc.di.dao.TestDAOImpl;
import com.bitc.di.dao.TestDBCPDAOImpl;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service("ts")
@Slf4j
public class TestServiceImpl implements TestService {
	
	@Setter(onMethod_= {@Autowired, @Qualifier("td")})
	private TestDAO dao;

	/*
	@Autowired @Qualifier("testDAOImpl")
	public void setDao(TestDAO dao) {
		this.dao = dao;
	}
	*/
	public TestServiceImpl() {
		log.info("testService Impl 생성");
		// dao = new TestDBCPDAOImpl();
		dao = new TestDAOImpl();
		System.out.println("dao : " + dao);
	}
	
	@Override
	public void testService(String message) {
		log.info("test service message : {}", message);
		System.out.println("dao : " + dao);
	}

}
