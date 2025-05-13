<%@page import="kr.co.cdtrade.vo.User"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.UserMapper"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
	trimDirectiveWhitespaces="true"
    pageEncoding="UTF-8"%>
<%
	String email = request.getParameter("email");

	UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
	
	User savedUser = userMapper.getUserByEmail(email);
	
	if (savedUser == null) {
		out.write("none");
	} else {
		out.write("exists");
	}
	
%>