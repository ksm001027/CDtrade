<%@page import="kr.co.cdtrade.utils.GenreMappingUtils"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../resources/css/common.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>

<%
   Integer loginedUserNo = (Integer) session.getAttribute("LOGINED_USER_NO");
%>

<body>
    <nav class="main-navbar">
        <div class="navbar-inner">
            <a href="<%=request.getContextPath() %>/main.jsp" class="navbar-logo"><span class="logo-1">원숭이와 </span> <span class="logo-2">춤을</span></a>
            <ul class="navbar-menu">
                <li><a href="<%=request.getContextPath() %>/album/best-album-list.jsp">베스트</a></li>
                <li class="dropdown">
               <a href="#" class="dropdown-toggle">장르별</a>
               <ul class="dropdown-menu">
<%
   Map<Integer, String> genreMap = GenreMappingUtils.GENRE_NO_TO_NAME;
   for (Map.Entry<Integer, String> entry : genreMap.entrySet()) {
%>   
                <li><a href="<%=request.getContextPath() %>/album/genre-album-list.jsp?genreNo=<%=entry.getKey()%>"><%=entry.getValue()%></a></li>
<%
   };    
%>
               </ul>
             </li>
                <li><a href="<%=request.getContextPath() %>/review-list.jsp">최신리뷰</a></li>
                <li><a href="<%=request.getContextPath() %>/sale/sale-list.jsp">판매상품</a></li>
            </ul>
            <div class="navbar-actions">  
               <form action="<%=request.getContextPath() %>/album/keyword-album-list.jsp" method="get" id="search-btn">
                  <div class="navbar-search">
                     <div id="search-icon">
                         <i class="fas fa-search"></i>
                     </div>
                      <input type="text" placeholder="앨범, 아티스트 검색" name="keyword">
                  </div>
               </form>
                
<%
   if (loginedUserNo != null) {
%>
                <ul class="navbar-menu">
                   <li><a href="/CDtrade/mycollection/mycollection.jsp">마이컬렉션</a></li>
               </ul>
                <a href="/CDtrade/mypage/mypage.jsp" class="navbar-profile">
                    <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="profile">
                </a>
<%
   } else {
%>
                <a href="/CDtrade/login/login-form.jsp" class="navbar-action">로그인</a>
<%
   }
%>
            </div>
        </div>
    </nav>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
       $("#search-btn input[name=keyword]").keyup(function(e){
          if (e.key === 'Enter'){
             $("#search-btn").trigger("submit");
          }
       })
       
       $("#search-icon").click(function(){
          $input = $("#search-btn input[name=keyword]")
          if($input.val() == ""){
             $input.focus();
          } else {
             $("#search-btn").trigger("submit");
          }
       });
       </script>
</body>

</html>