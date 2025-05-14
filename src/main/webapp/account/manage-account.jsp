<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.vo.User" %>
<%@ include file="../common/nav.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>정산 계좌 관리</title>
	<link rel="stylesheet" href="../resources/css/common.css">
</head>
<body>

<%
	User savedUser = (User) session.getAttribute("LOGINED_USER");
	String accountNumber = (savedUser != null && savedUser.getAccountNumber() != null) ? savedUser.getAccountNumber() : "";
	boolean isAccountRegistered = !accountNumber.isEmpty();
%>

<div class="mypage-layout">
	<%@ include file="../mypage/mypage-menu.jsp" %>

	<div class="mypage-content account-manage-container">
		<h2 class="account-title">정산 계좌 관리</h2>

		<form action="account-save.jsp" method="post" class="account-form">
			<label class="account-label">계좌정보</label>
			<select name="bankName" class="account-select" required>
				<option value="">은행 선택</option>
				<option value="두익은행">두익은행</option>
			</select>

			<input class="account-input" type="text" name="accountNumber" placeholder="계좌번호를 입력하세요" value="<%= accountNumber %>" required>
			<input class="account-input" type="text" name="accountHolder" placeholder="예금주명을 입력하세요" required>

			<%
				String buttonLabel = isAccountRegistered ? "계좌번호 수정하기" : "계좌번호 등록하기";
			%>
			<button class="auth-btn" type="submit"><%= buttonLabel %></button>
		</form>
	</div>
</div>

</body>
</html>
