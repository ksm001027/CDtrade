<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.mapper.UserMapper" %>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils" %>

<%
	Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");

	if (userNo != null) {
		UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
		userMapper.deactivateUserByNo(userNo);
		
		response.setStatus(200);
	} else {
		response.setStatus(400);
	}
%>
