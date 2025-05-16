<%@ page import="kr.co.cdtrade.vo.User" %>
<%@ page import="kr.co.cdtrade.mapper.UserMapper" %>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>

<%
	// 로그인된 사용자 정보 가져오기
	Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
	
	if (userNo == null) {
		// 로그인 안 되어 있으면 로그인 페이지로 이동
		response.sendRedirect("../login/login-form.jsp");
		return;
	}

	// 파라미터 값 받기
	String bankName = request.getParameter("bankName");
	String accountNumber = request.getParameter("accountNumber");
	String accountHolder = request.getParameter("accountHolder");

	// 필수값 검증 (간단한 예시)
	if (bankName == null || accountNumber == null || accountHolder == null || 
	    bankName.trim().isEmpty() || accountNumber.trim().isEmpty() || accountHolder.trim().isEmpty()) {
		response.sendRedirect("manage-account.jsp?error=empty");
		return;
	}

	// DB 처리
	UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);

	// users 테이블의 account_number 업데이트 (UserMapper에 updateAccountNumber 메서드 필요!)
	userMapper.updateAccountNumber(userNo, accountNumber);

	// 저장 후 마이페이지로 리다이렉트
	response.sendRedirect("../mypage/mypage.jsp");
%>
