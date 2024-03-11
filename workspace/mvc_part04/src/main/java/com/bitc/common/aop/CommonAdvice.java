package com.bitc.common.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Aspect
@Component
@Slf4j
public class CommonAdvice {

	/**
	 * 반환타입과 매개변수에 상관없이 
	 * com.bitc.*.controller package에 있는 모든 class를 타켓으로 지정하고 
	 * 모든 method를 joinPoints로 지정
	 */
	@Around("execution(* com.bitc.*.controller.*.*(..))")
	public Object checkControllerLog(ProceedingJoinPoint pjp) throws Throwable{
		
		log.info("----------------------------------advice CheckController START-----");
		log.info("target : {} ", pjp.getTarget());
		log.info("method : {} ", pjp.getSignature().getName());
		log.info("arguments : {} ", Arrays.toString(pjp.getArgs()));
		Object o = pjp.proceed();
		log.info("return : {} ", o);
		log.info("----------------------------------advice CheckController END-------");
		return o;
	}
	
	@Around("execution(* com.bitc.*.service.*.*(..))")
	public Object checkServiceLog(ProceedingJoinPoint pjp) throws Throwable{
	
		log.info("----------------------------------advice CheckService log START-----");
		log.info("target : {} ", pjp.getTarget());
		log.info("method : {} ", pjp.getSignature().getName());
		log.info("arguments : {} ", Arrays.toString(pjp.getArgs()));
		Object o = pjp.proceed();
		log.info("return : {} ", o);
		log.info("----------------------------------advice CheckService log END-------");
		return o;
		
	}
}
