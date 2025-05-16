<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="kr.co.cdtrade.vo.User"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.UserMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
<% 
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	
	UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
	
	User savedUser = userMapper.getUserByEmail(email);
	
	if (savedUser == null) {
		response.sendRedirect("login-form.jsp?fail=invalid");
		return;
	}
	
	if ("f".equals(savedUser.getIsActive())) {
		response.sendRedirect("login-form.jsp?fail=withdrawn");
		return;
	}
	
	String secretPassword = DigestUtils.sha256Hex(password);
	if (!secretPassword.equals(savedUser.getPassword())) {
		response.sendRedirect("login-form.jsp?fail=invalid");
		return;
	}
	
	session.setAttribute("LOGINED_USER_NO", savedUser.getNo());
	session.setAttribute("LOGINED_USER_NICKNAME", savedUser.getNickname());
	
	response.sendRedirect("../mypage/mypage.jsp");
	
%>