package com.bitc.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.bitc.mapper.MessageMapper;
import com.bitc.vo.MessageVO;

import lombok.extern.slf4j.Slf4j;

/**
 * pom.xml aspectjtools 의존성 추가
 * servlet-context.xml
 * component-scan aop 패키지 추가
 * aop : auto-proxy 태그 추가
 */
@Slf4j
@Component
@Aspect		// AOPAdvice 클래스 임을 명시
public class AOPAdvice {
	
	public AOPAdvice() {
		log.info("AOP Advice 생성");
	}

	
/*	
	// target joinPoint(method) 가 실행되기 전 호출
	// @Before("execution(com.bitc.vo.MessegeVO[반환타입이 messageVO일때만 가능 )")
										// 클래스.메소드(매개변수-타입갯수 상관없음. (.. : 모든것, 타입갯수 노상관)
	@Before("execution(* com.bitc.service.*.*(..))")		// 여기서는 junit before가 아님
	public void startLog(JoinPoint jp) {	
			// 맨 왼쪽 줄 갯수 옆에 위에 화살표 왼쪽 방향으로 있어야 비포 적용된거임(수행되기전 AOP로 처리되는 무언가있음)
			// 적용받는 AOP는 왼쪽 줄갯구 옆에 위에 화살표 오른쪽 방향으로 있음
		log.info("-------------------------------------------------------");
		log.info("-------------------------------------------------------");
		log.info("-----------------------START LOG-----------------------");
		log.info("target : {}", jp.getTarget()); // 대상메소드를 가지고 있는걸 target이라고 함
		log.info("type : {}", jp.getKind());	// 호출되는 대상의 종류
		log.info("parameters : {}", Arrays.toString(jp.getArgs()));	// 매개변수 있는지
		log.info("name : {}", jp.getSignature().getName());		// 메소드 뭔지
		log.info("---------------------SRATR LOG END---------------------");
		
	}
										// MessageServiceImpl 화살표가 직선이면 aop가 여러개 등록되었음을 알림
	@After("execution(* com.bitc.service.MessageServiceImpl.*(..))")
	public void endLog() {
		log.info("---------------------END AFTER LOG---------------------");
		log.info("---------------------SRATR LOG END--------------------");
	}
	
	// afterthrowing : 예외를 전달 받고 난 후 
	@AfterThrowing(
			value="execution(* com.bitc.serviec.*.*(..))", 
			throwing = "exception"
			)
	public void endThrowing(JoinPoint jp, Exception exception) {
		log.info("----------------------------------------------------------------");
		log.info("--------------------START @AfterThrowing LOG--------------------");
		log.info("target : {} ", jp.getTarget());
		log.info("name : {} ", jp.getSignature().getName());
		log.info("error : {} ", exception.getMessage());
		log.info("name : {} ", jp.getSignature().getName());
		log.info("--------------------END @AfterThrowing LOG----------------------");
		log.info("----------------------------------------------------------------");
	}
	
	// 타겟 메소드가 작업 수행 후 정상적으로 값을 반환하고 난 뒤 
	@AfterReturning(
			pointcut="execution(!void com.bitc.service.MessageServiceImpl.*(..))",
			returning = "returnValue"			
			)
	public void successLog(JoinPoint jp, Object returnValue) {
		log.info("----------------------------------------------------------------");
		log.info("--------------------START @AfterReturning LOG--------------------");
		log.info("target : {} ", jp.getTarget());
		log.info("name : {} ", jp.getSignature().getName());
		log.info("error : {} ", returnValue);
		log.info("--------------------END @AfterReturning LOG----------------------");
		log.info("----------------------------------------------------------------");
	}
	
	*/
	
	@Around("execution(* com.bitc.service.*.*(..))")
							// ProceedingJoinPoint : 실제 타겟에 있는 메소드의 실행도 직접 ㅊㅓ리해줄수 있음
	public Object serviceLog(ProceedingJoinPoint pjp) throws Throwable{
		log.info("--------------------------------------------------------------");
		log.info("------------------------AROUND START--------------------------");
		log.info("target : {}" , pjp.getTarget());
		log.info("name : {}", pjp.getSignature().getName());
		log.info("parameter : {}", Arrays.toString(pjp.getArgs()));
		
		// Before - 실행 전
		// target 실체 객체의 pointcut method 호출
		Object o = pjp.proceed();
		// after - 실행 후 
		log.info("around AFTER : {} " , o);
		log.info("-------------------------AROUND END--------------------------");
		log.info("-------------------------------------------------------------");
		
		return o;
	}
	
	// 의존성 주입
	@Autowired
	MessageMapper mapper;
	
	@Around(value="execution(* com.bitc.service.MessageServiceImpl.readMessage(String,int)) && args(uid, mno)")
	public Object checkReadMessage(ProceedingJoinPoint pjp, String uid, int mno) throws Throwable {
		log.info("-----------------------------------------------------------------");
		log.info("--------------------checkReadMessage Around START----------------");
		log.info("parameters : {}", Arrays.toString(pjp.getArgs()));
		log.info("uid : " + uid);
		log.info("mno : " + mno);
		
		//메세지 번호가 일치하는 메세지 정보를 MessageVO 타입으로 반환
		MessageVO vo = mapper.readMessage(mno);
		
		if(vo.getOpendate() != null) {
			log.info(" throw readMessage : {}" , vo);
			log.info(" throw checkReadMessage AROUND END");
			throw new NullPointerException("이미 수신한 메세지 입니다.");
		}
		
		log.info("Before END-------------------------------------------------------");
		Object o = pjp.proceed();
		vo = (MessageVO)o;
		vo.setMessage("Around에서 메세지 정보 변경");
		log.info("--------------------checkReadMessage Around END------------------");
		log.info("-----------------------------------------------------------------");

		/*
		Object o;
		try {
			o = pjp.proceed();	// after + returning
		} catch (Throwable e) {
			e.printStackTrace();	// after + throwing
		}
		*/

		return o;
	}
}
