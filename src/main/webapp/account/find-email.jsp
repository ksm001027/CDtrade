<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.mapper.UserMapper" %>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils" %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String foundEmail = null;

	if (name != null && tel != null) {
		UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
		foundEmail = userMapper.findUserEmail(Map.of("name", name, "tel", tel));
	}
%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이메일 찾기</title>
    <link rel="stylesheet" href="../resources/css/common.css">
</head>

<body>
	<%@ include file="../common/nav.jsp" %>
    <div class="auth-container">
        <div class="auth-title">이메일 찾기</div>
        <form class="auth-form" action="find-email.jsp" method="get">
            <label class="auth-label">이름</label>
            <input class="auth-input" type="text" name="name" placeholder="이름 입력" value="<%= name != null ? name : "" %>" required />
            <label class="auth-label">휴대폰 번호</label>
            <input class="auth-input" type="text" name="tel" placeholder="010-1234-5678" value="<%= tel != null ? tel : "" %>" required />
            <button class="auth-btn" type="submit">이메일 찾기</button>
			<button class="auth-btn" type="button" onclick="location.href='../login/login-form.jsp'">로그인으로 돌아가기</button>
        </form>
    </div>

	<!-- 성공 모달 -->	
	<div id="resultModal" class="modal-backdrop">
		<div class="modal-content">
			<p>찾은 이메일: <strong id="foundEmail"></strong></p>
			<button class="auth-btn" onclick="closeModal()">확인</button>
		</div>
	</div>
	
	<script>
		function showModal(email) {
			document.getElementById("foundEmail").innerText = email;
			document.getElementById("resultModal").classList.add("show");
		}
	
		function closeModal() {
			document.getElementById("resultModal").classList.remove("show");
		}
	</script>
	
	<% if (name != null && tel != null && foundEmail != null) { %>
		<script>
			showModal("<%= foundEmail %>");
		</script>
	<% } %>
	
	<!-- 실패 모달 -->
	<div id="failModal" class="modal-backdrop">
		<div class="modal-content">
			<p>일치하는 정보가 없습니다. 다시 확인해 주세요.</p>
			<button class="auth-btn" onclick="closeFailModal()">확인</button>
		</div>
	</div>
	
	<script>
		function showModal(email) {
			document.getElementById("foundEmail").innerText = email;
			document.getElementById("resultModal").classList.add("show");
		}
	
		function closeModal() {
			document.getElementById("resultModal").classList.remove("show");
		}
	
		function showFailModal() {
			document.getElementById("failModal").classList.add("show");
		}
	
		function closeFailModal() {
			document.getElementById("failModal").classList.remove("show");
		}
	</script>
	
	<% if (name != null && tel != null) { 
		if (foundEmail != null) { %>
			<script>
				showModal("<%= foundEmail %>");
			</script>
	<%  } else { %>
			<script>
				showFailModal();
			</script>
	<%  } 
	} %>
	
	<%@ include file="../common/footer.jsp" %>
</body>
</html>
