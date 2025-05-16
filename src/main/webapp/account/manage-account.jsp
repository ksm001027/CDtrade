<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.mapper.UserMapper" %>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>계좌번호 관리</title>
	<link rel="stylesheet" href="../resources/css/account.css">
</head>
<body>

<%@ include file="../common/nav.jsp" %>

<%
	Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");

	if (userNo == null) {
		response.sendRedirect("../login/login-form.jsp");
		return;
	}

	UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
	String accountNumber = userMapper.getAccountNumberByUserNo(userNo);

	boolean isAccountRegistered = (accountNumber != null && !accountNumber.trim().isEmpty());
%>

<div class="mypage-layout">
	<%@ include file="../mypage/mypage-menu.jsp" %>

	<div class="mypage-content account-manage-container">
		<h2 class="account-title">계좌번호 관리</h2>

		<form action="account-save.jsp" method="post" class="account-form">
			<label class="account-label">계좌정보</label>
			<select name="bankName" class="account-select" required>
				<option value="">은행 선택</option>
				<option value="두익은행">두익은행</option>
			</select>

			<input class="account-input" type="text" name="accountNumber" placeholder="계좌번호를 입력하세요" value="<%= accountNumber != null ? accountNumber : "" %>" required>
			<input class="account-input" type="text" name="accountHolder" placeholder="예금주명을 입력하세요" required>

			<%
				String buttonLabel = isAccountRegistered ? "계좌번호 수정하기" : "계좌번호 등록하기";
			%>
			<button class="auth-btn" type="submit"><%= buttonLabel %></button>
		</form>
	</div>
</div>

<%@ include file="../common/footer.jsp" %>

</body>
</html>
