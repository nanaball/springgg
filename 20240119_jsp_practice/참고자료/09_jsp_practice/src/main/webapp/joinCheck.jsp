<%@page import="java.util.ArrayList"%>
<%@page import="vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!-- joinCheck.jsp -->
<%request.setCharacterEncoding("utf-8");%>

<%

	List<MemberVO> memberList = new ArrayList<>();
	if(memberList == null){
		application.setAttribute("memberList", memberList);	
	}
	System.out.print(memberList);
	
	String id = request.getParameter("id");
	String pass  = request.getParameter("pass");
	String name = request.getParameter("name");
	String addr = request.getParameter("addr");
	String phone = request.getParameter("phone");
	String gender = request.getParameter("gender");	
	int age = Integer.parseInt(request.getParameter("age"));	
	
	
	
	
	MemberVO joinMember = new MemberVO(id, pass, name, addr, phone, gender, age);
	
	
	
	
%>







