package com.bitc.di.dao;

import org.springframework.stereotype.Repository;

@Repository	// TestDAOImpl -- 따로 지정이 없으면 
public class TestDAOImpl implements TestDAO {

	@Override
	public void select(String message) {
		
		System.out.println("testDAOImpl : " + message);
	}

}
