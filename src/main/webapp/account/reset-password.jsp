<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.mapper.UserMapper" %>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils" %>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String email = request.getParameter("email");
	String newPassword = request.getParameter("newPassword");

	if (newPassword != null) {
		UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
		String hashedPassword = DigestUtils.sha256Hex(newPassword);
		userMapper.updatePassword(Map.of("email", email, "newPassword", hashedPassword));
%>
		<script>
			alert("비밀번호가 성공적으로 변경되었습니다!");
			location.href = "../login/login-form.jsp";
		</script>
<%
	}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>비밀번호 재설정</title>
	<link rel="stylesheet" href="../resources/css/common.css">
</head>
<body>
	<%@ include file="../common/nav.jsp" %>
	<div class="auth-container">
		<div class="auth-title">새 비밀번호 입력</div>
		<form class="auth-form" method="post" onsubmit="return validatePassword();">
		<input type="hidden" name="email" value="<%= email %>" />
		
		<label class="auth-label">새 비밀번호</label>
		<input class="auth-input" type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호" required />
	
		<label class="auth-label">비밀번호 확인</label>
		<input class="auth-input" type="password" id="confirmPassword" placeholder="비밀번호 확인" required />
	
		<button class="auth-btn" type="submit">비밀번호 변경</button>
	</form>
	
	<script>
		function validatePassword() {
			const pw = document.getElementById("newPassword").value;
			const confirmPw = document.getElementById("confirmPassword").value;
	
			if (pw !== confirmPw) {
				alert("비밀번호가 일치하지 않습니다.");
				return false; // 폼 제출 막기
			}
			return true;
		}
	</script>
	
	</div>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>
