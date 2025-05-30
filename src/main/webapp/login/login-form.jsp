<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 - 두익이네</title>
    <link rel="stylesheet" href="../resources/css/common.css">
</head>
<body>
    <div class="auth-container">
        <img src="img/logo.png" alt="로고" class="auth-logo">

        <div class="auth-title">☆두익이네☆<br>로그인</div>

        <form class="auth-form" action="login.jsp" method="post">
            <input type="email" name="email" class="auth-input" placeholder="이메일" required>
            <input type="password" name="password" class="auth-input" placeholder="비밀번호" required>
            <button type="submit" class="auth-btn">로그인</button>
        </form>

        <div class="auth-links">
            <a href="../register/register-form.jsp">회원가입</a>
            <span>|</span>
            <a href="find-id.jsp">아이디 찾기</a>
            <span>|</span>
            <a href="find-password.jsp">비밀번호 찾기</a>
        </div>
    </div>
    
    <%
		String fail = request.getParameter("fail");
		boolean showModal = fail != null;
		
		String message = "이메일 또는 비밀번호가 잘못되었습니다.";
		if ("withdrawn".equals(fail)) {
			message = "이미 탈퇴한 계정입니다. 다시 회원가입 해주세요.";
		}
	%>

	<div id="loginFailModal" class="modal-backdrop <%= showModal ? "show" : "" %>">
	  <div class="modal-content">
	    <div class="modal-title">로그인 실패</div>
	    <div class="modal-desc"><%= message %></div>
	    <a href="login-form.jsp" class="modal-btn">확인</a>
	    
	  </div>
	</div>
</body>
</html>
