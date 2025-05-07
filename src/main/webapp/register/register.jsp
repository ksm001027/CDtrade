<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="kr.co.cdtrade.vo.User"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.UserMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	String email = request.getParameter("email");
 	String password = request.getParameter("password");
 	String passwordConfirm = request.getParameter("passwordConfirm");
 	String name = request.getParameter("name");
 	String nickname = request.getParameter("nickname");
 	String tel = request.getParameter("tel");
 	
 	String telRegex = "^010-\\d{4}-\\d{4}$";
    if (!tel.matches(telRegex)) {
        response.sendRedirect("register-form.jsp?fail=tel");
        return;
    }
 	
 	UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
 	
 	User savedUser = userMapper.getUserByEmail(email);
 	if (savedUser != null) {
 		response.sendRedirect("register-form.jsp?fail=id");
 		return;
 	}
 	
 	savedUser = userMapper.getUserByNickname(nickname);
 	if (savedUser != null) {
 	    response.sendRedirect("register-form.jsp?fail=nickname");
 	    return;
 	}
 	
 	String secretPassword = DigestUtils.sha256Hex(password);
 	User user = new User();
 	user.setEmail(email);
 	user.setPassword(secretPassword);
 	user.setName(name);
 	user.setNickname(nickname);
 	user.setTel(tel);
 	
 	userMapper.insertUser(user);
 	
 	response.sendRedirect("register-complete.jsp");
 	
 %>