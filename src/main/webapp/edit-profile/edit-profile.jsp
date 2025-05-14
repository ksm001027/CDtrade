<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="kr.co.cdtrade.vo.User"%>
<%@page import="kr.co.cdtrade.mapper.UserMapper"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
	if (userNo == null) {
		response.sendRedirect("../login/login-form.jsp");
		return;
	}
	
	String nickname = request.getParameter("nickname");
	String currentPassword = request.getParameter("currentPassword");
	String newPassword = request.getParameter("newPassword");
	String passwordConfirm = request.getParameter("passwordConfirm");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");

	UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
	User savedUser = userMapper.getUserByNo(userNo);
	
	String hashedCurrentPassword = DigestUtils.sha256Hex(currentPassword);
	if (!hashedCurrentPassword.equals(savedUser.getPassword())) {
		response.sendRedirect("edit-profile-form.jsp?fail=password");
		return;
	}
	
	String finalPassword = savedUser.getPassword();
	if (newPassword != null && !newPassword.isEmpty()) {
		if (!newPassword.equals(passwordConfirm)) {
			response.sendRedirect("edit-profile-form.jsp?fail=confirm");
			return;
		}
		finalPassword = DigestUtils.sha256Hex(newPassword);
		
	}
	
	// 닉네임 중복 검사
	String loginNickname = (String) session.getAttribute("LOGINED_USER_NICKNAME");
	
	// 세션 닉네임 null이면 로그인 풀린 거니까 로그인 페이지로 이동
	if (loginNickname == null) {
		response.sendRedirect("../login/login-form.jsp");
		return;
	}

	// 닉네임 변경 시도한 경우에만 DB에서 중복 체크
	if (!nickname.equals(loginNickname)) {
		User duplicatedUser = userMapper.getUserByNickname(nickname);
		if (duplicatedUser != null) {
			response.sendRedirect("edit-profile-form.jsp?fail=nickname");
			return;
		}
	}

	User updateUser = new User();
	
	updateUser.setNo(userNo);
	updateUser.setNickname(nickname);
	updateUser.setPassword(finalPassword);
	updateUser.setName(name);
	updateUser.setTel(tel);
	
	userMapper.updateUser(updateUser);
	
	response.sendRedirect("../mypage/mypage.jsp");
%>