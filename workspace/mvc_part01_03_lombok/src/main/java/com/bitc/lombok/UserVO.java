package com.bitc.lombok;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.Singular;
import lombok.ToString;

/**
 *  pojo 클래스를 위한 필수 메소드들  
 */
// @Data
// @Getter
// @Setter
// 객체 생성 시에 필요한 필수 값이 존재하기 때문에 기본 생성자로 객체 생성 불가
// @NoArgsConstructor					// 기본 생성자 추가
// @AllArgsConstructor						// 모든 값을 매개변수로 받는 생성자 추가
// @ToString(callSuper = true)			// 부모 toString도 호출
// @ToString(exclude = "uid")			// toString에 해당 필드(uid) 제외
// @ToString(exclude = {"uid","upw"}, callSuper=true)	// 여러 필드 정보 제외(upw, uid), 부모 다 존재 
// @ToString(of = {"uid","upw"})			// 지정한 필드 정보만 포함(upw, uid) 
// @EqualsAndHashCode(of= {"uid", "upw"})	// 지정된 필드 정보가 일치하면 논리적으로 동등한 객체
// @RequiredArgsConstructor				// 필수 인자값을 이용한 생성자 
@Builder
@ToString
public class UserVO {
	
	@Getter
	private int uno;
	@Setter @NonNull
	private String uid;
	@NonNull	// 이 필드는 null이면 안됨
	private String upw;
			// final : 값이 변경되지 않음
	private final String uname;
	
	// 2024-10-10 10:23:34
	// @DateTimeFormat(pattern="yyyy-MM-dd hh:mm:ss")
	private Date regdate;
	
	@Singular("list")
	private List<String> friendList;
}
