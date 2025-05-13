<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.UserMapper"%>
<%@page import="kr.co.cdtrade.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String error = request.getParameter("fail");
%>
    
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 수정</title>
    <link rel="stylesheet" href="../resources/css/common.css">
</head>

<body>
    	<!-- 상단 메뉴 -->
    <%@ include file="../common/nav.jsp" %>
    	
    <div class="mypage-layout">
    	
        <!-- 좌측 메뉴 -->
        <%@ include file="../mypage/mypage-menu.jsp" %>
        
        <!-- 우측 컨텐츠 -->
        <main class="mypage-content">
            <div class="edit-profile-container">
                <form class="auth-form" method="post" action="edit-profile.jsp">
                
                <%
                	UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
                	Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO"); 
                	User savedUser = userMapper.getUserByNo(userNo);
                %>
                
                    <label class="auth-label">이메일</label>
                    <input class="auth-input" type="email" name="email" value="<%= savedUser.getEmail() %>" readonly>
                    <label class="auth-label">이름</label>
                    <input class="auth-input" type="text" name="name" value="<%= savedUser.getName() %>" readonly>
                    <label class="auth-label">닉네임</label>
                    <input class="auth-input" type="text" name="nickname" value="<%= savedUser.getNickname() %>" >
                    <% if ("nickname".equals(error)) { %>
						<div class="alert">이미 사용 중인 닉네임입니다.</div>
					<% } %>
                    <label class="auth-label">휴대폰 번호</label>
                    <input class="auth-input" type="text" name="tel" value="<%= savedUser.getTel()%>">
                    <% if ("tel".equals(error)) { %>
                    	<div class="alert">이미 사용 중인 전화번호입니다.</div>
                    <% } %>
                    <label class="auth-label">현재 비밀번호</label>
                    <input class="auth-input" type="password" name="currentPassword" placeholder="비밀번호 인증">
                    <% if ("password".equals(error)) { %>
						<div class="alert">현재 비밀번호가 올바르지 않습니다.</div>
					<% } %>
                    <label class="auth-label">비밀번호</label>
                    <input class="auth-input" type="password" name="newPassword" placeholder="비밀번호 입력">
                    <label class="auth-label">비밀번호 재입력</label>
                    <input class="auth-input" type="password" name="passwordConfirm" placeholder="비밀번호 재입력">
                    <% if ("confirm".equals(error)) { %>
						<div class="alert">새 비밀번호와 재입력 값이 일치하지 않습니다.</div>
					<% } %>
                    <button class="auth-btn" type="submit">저장하기</button>
                </form>
            </div>
        </main>
    </div>
</body>

</html>