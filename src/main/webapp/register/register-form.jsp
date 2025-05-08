<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String fail = request.getParameter("fail");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="../resources/css/common.css">
</head>
<body>

<%
	if ("email".equals(fail)) {
%>
		<div class="alert alert-danger alert-dismissible" role="alert" id="errorAlert">
            <strong>오류!</strong> 
            <span id="errorMessage">이미 사용중인 이메일입니다.</span>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
<%
	} else if ("nickname".equals(fail)) {
%>
		<div class="alert alert-danger alert-dismissible" role="alert" id="errorAlert">
            <strong>오류!</strong> 
            <span id="errorMessage">이미 사용중인 닉네임입니다.</span>
            <button type="button" class="btn-close" aria-label="Close" onclick="this.parentElement.style.display='none'">×</button>
        </div>
<%
	}
%>
    <div class="auth-container">
        <div class="auth-title">회원가입</div>
        <form class="auth-form" id="form-register" method="post" action="register.jsp">
            <label class="auth-label">이메일</label>
            <input class="auth-input" type="email" name="email" id="user-email" placeholder="example@email.com">
            <div class="form-text" id="form-text-email"></div>
            <label class="auth-label">비밀번호</label>
            <input class="auth-input" type="password" name="password" id="user-password" placeholder="비밀번호 입력">
            <label class="auth-label">비밀번호 확인</label>
            <input class="auth-input" type="password" name="passwordConfirm" id="user-password-confirm" placeholder="비밀번호 재입력">
            <label class="auth-label">닉네임</label>
            <input class="auth-input" type="text" name= "nickname" id="user-nickname" placeholder="중복 불가 닉네임">
            <div class="form-text" id="form-text-nickname"></div>
            <label class="auth-label">이름</label>
            <input class="auth-input" type="text" name="name" placeholder="이름 입력">
            <label class="auth-label">휴대폰 번호</label>
            <input class="auth-input" type="text" name="tel" id="user-tel" placeholder="010-1234-5678">
            <div class="form-text" id="form-text-tel"></div>
            <button class="auth-btn" type="submit">회원가입</button>
        </form>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
		let emailRegExp = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
		let nicknameRegExp = /^[가-힣a-zA-Z0-9]{2,6}$/;
		let telRegExp = /^010-\d{4}-\d{4}$/;
		
		let emailCheckPassed = false;
		let nicknameCheckPassed = false;
		let telCheckPassed = false;
		
		$("#form-register").submit(function() {
			if ($("#user-email").val() == "") {
				alert("이메일은 필수 입력값입니다.");
				$("#user-email").focus();
				return false;
			}
			
			if (!emailCheckPassed) {
				alert("이미 사용중인 이메일입니다.");
				$("#user-email").focus();
				return false;
			}
			
			if ($("#user-password").val() == "") {
				alert("비밀번호는 필수 입력값입니다.");
				$("#user-password").focus();
				return false;
			}
			
			if ($("#user-password").val() != $("#user-password-confirm").val()) {
				alert("비밀번호가 일치하지 않습니다.");
				$("#user-password-confirm").val("")
										   .focus();
				return false;
			}
			
			if ($("#user-nickname").val() == "") { 
				alert("닉네임은 필수 입력값입니다.");
				$("#user-nickname").focus();
				return false;
			}
			
			if (!nicknameCheckPassed) {
				alert("이미 사용중인 닉네임입니다.")
				$("#user-nickname").focus();
				return false;
			}
			
			if ($("#user-tel").val() == "") {
				alert("전화번호는 필수 입력값입니다.");
				$("#user-tel").focus();
				return false;
			}
			
			if (!telCheckPassed) {
				alert("이미 사용중인 전화번호입니다.")
				$("#user-tel").focus();
				return false;
			}
			
			return true;
		})
		
		$("#user-email").keyup(function() {
			let $div = $("#form-text-email").empty()
											.removeClass("text-danger")
											.removeClass("text-success");
			
			let value = $(this).val();
			if (!emailRegExp.test(value)) {
				$div.addClass("text-danger")
					.text("올바른 이메일 형식을 입력하세요.");
				emailCheckPassed = false;
				
				return;
			}
				$div.addClass("text-success")
					.text("올바른 이메일 형식입니다.");
				
			$.ajax({
				type: 'get',
				url: 'email-check.jsp',
				data: {email: value},
				dataType: 'text',
				success: function(result) {
					if (result === 'none') {
						$div.addClass("text-success")
							.text("사용가능한 이메일입니다.")
						emailCheckPassed = true;
					} else if (result === 'exists') {
						$div.addClass("text-danger")
							.text("사용할 수 없는 이메일입니다.")
						emailCheckPassed = false;
					}
				}
			});
		})
		
		$("#user-nickname").keyup(function() {
			let $div = $("#form-text-nickname").empty()
											   .removeClass("text-danger")
											   .removeClass("text-success");
			
			let value = $(this).val();
			if (!nicknameRegExp.test(value)) {
				$div.addClass("text-danger")
					.text("올바른 닉네임 형식을 입력하세요.");
				nicknameCheckPassed = false;
				
				return;
			}
				$div.addClass("text-success")
					.text("올바른 닉네임 형식입니다.");
				
			$.ajax({
				type: 'get',
				url: 'nickname-check.jsp',
				data: {nickname: value},
				dataType: 'text',
				success: function(result) {
					if (result === 'none') {
						$div.addClass("text-success")
							.text("사용가능한 닉네임입니다.")
						nicknameCheckPassed = true;
					} else if (result === 'exists') {
						$div.addClass("text-danger")
							.text("사용할 수 없는 닉네임입니다.")
						nicknameCheckPassed = false;
					}
				}
			});
		})
		
		$("#user-tel").keyup(function() {
			let $div = $("#form-text-tel").empty()
										  .removeClass("text-danger")
										  .removeClass("text-success");
			
			let value = $(this).val();
			if (!telRegExp.test(value)) {
				$div.addClass("text-danger")
					.text("올바른 전화번호 형식을 입력하세요.");
				telCheckPassed = false;
				
				return;
			}
				$div.addClass("text-success")
					.text("올바른 전화번호 형식입니다.");
				
			$.ajax({
				type: 'get',
				url: 'tel-check.jsp',
				data: {tel: value},
				dataType: 'text',
				success: function(result) {
					if (result === 'none') {
						$div.addClass("text-success")
							.text("사용가능한 전화번호입니다.")
						telCheckPassed = true;
					} else if (result === 'exists') {
						$div.addClass("text-danger")
							.text("사용할 수 없는 전화번호입니다.")
						telCheckPassed = false;
					}
				}
			});
		})
    </script>
</body>
</html>











