<%@page import="java.util.ArrayList"%>
<%@page import="vo.MemberVO"%>
<%@page import="org.eclipse.jdt.internal.compiler.ast.MemberValuePair"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!-- joinCheck.jsp -->
<%
	// 파라미터 읽기전에 인코딩하기 읽고 나서는 변경x
	request.setCharacterEncoding("utf-8");	

	// ServletContext(appliction) 영역에 회원 목록 정보를 저장 
	List<MemberVO> memberList = (List<MemberVO>)application.getAttribute("memberList");
	
	// 아직 등록된 회정정보가 존재하지 않음 
	if(memberList == null){
		memberList = new ArrayList<>();
		application.setAttribute("memberList", memberList);
	}
	
	// 회원가입에 필요한 파라미터 정보를 이용해서 회원가입 요청 처리
	
	// 사용자가 입력창에 입력한 파라미터들 중에 name 값이 id 값을 읽어옴.
	String id = request.getParameter("id");
	
	// 등록된 회원들 중에 동일한 id를 사용하고 있는 사용자가 존재하는지 확인 
	// 중복 아이디 체크
	
	MemberVO member = new MemberVO(id);
	
	// 회원 목록에 등록된 회원정보가 하나라도 존재하면 (memberList가 비어있지 않으면)
	if(!memberList.isEmpty() && memberList.contains(member)){
		// memberList에 매개변수로 전달된 member와 id가 일치하는 회원정보가 존재함.
%>
	<script>
		alert('이미 사용중인 아이디 입니다.');
		// go(-1) = back(이전페이지) // gor(1) = forward(다음페이지)
		history.go(-1);
	</script>
<%
		return;	// 회원가입 요청처리를 하지 않도록 servlet의 service method 즉시 종료 
	}
	
	// 사용가능한 아이디 - 회원가입 요청처리(회원등록)
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String addr = request.getParameter("addr");
	String phone = request.getParameter("phone");
	String gender = request.getParameter("gender");
	String strAge = request.getParameter("age");
	int age = Integer.parseInt(strAge); // 등록할 정수 타입으로 변경 
	
	// 읽어온 파라미터 정보를 회원 정보에 추가할 member field에 저장
	member.setPass(pass);
	member.setAddr(addr);
	member.setName(name);
	member.setPhone(phone);
	member.setGender(gender);
	member.setAge(age);

	// 회원 목록에 새롭게 생성된 회원 정보 추가
	memberList.add(member);
	
	// TODO 삭제 예정
	System.out.println("====================================================");
	System.out.println(application.getAttribute("memberList"));
	System.out.println("====================================================");
%>
<!-- 정상적으로 회원정보가 등록이 완료되었으면 로그인 페이지로 이동 -->
	<script>
		alert('회원가입 성공');
		location.href="login.jsp";
	</script>

















