<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.mapper.UserMapper" %>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils" %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String email = request.getParameter("email");
	String tel = request.getParameter("tel");
	boolean verified = false;

	if (email != null && tel != null) {
		UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
		int count = userMapper.verifyUserForPasswordReset(Map.of("email", email, "tel", tel));
		verified = (count > 0);
		if (verified) {
			response.sendRedirect("reset-password.jsp?email=" + email);
		}
	}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>비밀번호 찾기</title>
	<link rel="stylesheet" href="../resources/css/common.css">
</head>
<body>
	<%@ include file="../common/nav.jsp" %>
	<div class="auth-container">
		<div class="auth-title">비밀번호 찾기</div>
		<form class="auth-form" method="get">
			<label class="auth-label">이메일</label>
			<input class="auth-input" type="email" name="email" placeholder="이메일 입력" required />
			<label class="auth-label">휴대폰 번호</label>
			<input class="auth-input" type="text" name="tel" placeholder="010-1234-5678" required />
			<button class="auth-btn" type="submit">본인 확인</button>
		</form>
	</div>
	
	<!-- 실패 모달 -->
	<div id="failModal" class="modal-backdrop">
		<div class="modal-content">
			<p>일치하는 정보가 없습니다. 다시 확인해 주세요.</p>
			<button class="auth-btn" onclick="closeFailModal()">확인</button>
		</div>
	</div>
	
	<script>
		function showFailModal() {
			document.getElementById("failModal").classList.add("show");
		}
	
		function closeFailModal() {
			document.getElementById("failModal").classList.remove("show");
		}
	</script>
	
	<% if (email != null && tel != null && !verified) { %>
	<script>
		showFailModal();
	</script>
	<% } %>
	
	<%@ include file="../common/footer.jsp" %>
</body>
</html>
