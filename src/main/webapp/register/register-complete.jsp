<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>회원가입 완료 - 두익이네</title>
	<link rel="stylesheet" href="../resources/css/common.css">
</head>
<body>
<%@ include file="../common/nav.jsp" %>

	<div class="auth-container">
		<img src="../resources/image/hi-monkey.png" alt="로고" class="auth-logo">
	
        <div class="auth-title">회원가입이 완료되었습니다.</div>
        <div class="auth-complete-message">
            두익이네 오신 걸 환영합니다!<br>
            로그인 후 다양한 서비스를 이용해보세요.
            <br>
            <br>
            <br>
        </div>
        <div class="auth-actions">
            <a href="../login/login-form.jsp" class="auth-btn" style="text-decoration: none; color: white;">로그인 하러 가기</a>
            <a href="../main.jsp" class="auth-btn" style="text-decoration: none; color: white;">메인 페이지로 이동</a>
        </div>
    </div>
    
<%@ include file="../common/footer.jsp" %>
</body>
</html>
