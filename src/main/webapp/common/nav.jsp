<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../resources/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<%
	Integer loginedUserNo = (Integer) session.getAttribute("LOGINED_USER_NO");
%>

<body>
    <nav class="main-navbar">
        <div class="navbar-inner">
            <a href="#" class="navbar-logo"><span class="logo-1">원숭이와 </span> <span class="logo-2">춤을</span></a>
            <ul class="navbar-menu">
                <li><a href="#">베스트</a></li>
                <li><a href="#">장르별</a></li>
                <li><a href="#">최신리뷰</a></li>
                <li><a href="#">판매상품</a></li>
            </ul>
            <div class="navbar-search">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="앨범, 아티스트 검색">
            </div>
            <div class="navbar-actions">
                <a href="#" class="navbar-action"></a>
<%
	if (loginedUserNo != null) {
%>
                <a href="../login/login-form.jsp" class="navbar-profile">
                    <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="profile">
                </a>
                <a href="../login/logout.jsp" class="navbar-action">로그아웃</a>
<%
	} else {
%>
                <a href="../login/login-form.jsp" class="navbar-action">로그인</a>
<%
	}
%>
            </div>
        </div>
    </nav>
</body>

</html>