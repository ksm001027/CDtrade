<%@page import="kr.co.cdtrade.vo.User"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.UserMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
	if (userNo == null) {
		response.sendRedirect("../login/login-form.jsp");
		return;
	}
	
	UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
	User user = userMapper.getUserByNo(userNo);
%>

<%@ include file="../common/nav.jsp" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link rel="stylesheet" href="../resources/css/common.css">
</head>

<body>
    <div class="mypage-layout">
    
        <%@ include file="mypage-menu.jsp" %>
        
        <!-- 우측 컨텐츠 -->
        <main class="mypage-content">
            <div class="mypage-profile-card">
                <div class="mypage-profile-info">
                    <div class="mypage-profile-name"> <%= user.getName() %></div>
                    <div class="mypage-profile-email"> <%= user.getEmail() %></div>
                </div>
            </div>
            <div class="mypage-summary-card">
                <div class="mypage-summary-title">구매내역</div>
                <a class="mypage-summary-more" href="../order/order-history.jsp">더보기 &gt;</a>
                <div class="mypage-summary-list">
                    <div class="mypage-summary-item">
                        <div class="mypage-summary-count">0</div>
                        <div class="mypage-summary-label">전체</div>
                    </div>
                    <div class="mypage-summary-divider"></div>
                    <div class="mypage-summary-item">
                        <div class="mypage-summary-count">0</div>
                        <div class="mypage-summary-label">진행중</div>
                    </div>
                    <div class="mypage-summary-divider"></div>
                    <div class="mypage-summary-item">
                        <div class="mypage-summary-count">0</div>
                        <div class="mypage-summary-label">구매완료</div>
                    </div>
                </div>
            </div>
            <div class="mypage-summary-card">
                <div class="mypage-summary-title">판매내역</div>
                <a class="mypage-summary-more" href="../sale/sale-history.jsp">더보기 &gt;</a>
                <div class="mypage-summary-list">
                    <div class="mypage-summary-item">
                        <div class="mypage-summary-count">0</div>
                        <div class="mypage-summary-label">전체</div>
                    </div>
                    <div class="mypage-summary-divider"></div>
                    <div class="mypage-summary-item">
                        <div class="mypage-summary-count">0</div>
                        <div class="mypage-summary-label">진행중</div>
                    </div>
                    <div class="mypage-summary-divider"></div>
                    <div class="mypage-summary-item">
                        <div class="mypage-summary-count">0</div>
                        <div class="mypage-summary-label">판매완료</div>
                    </div>
                </div>

            </div>
        </main>
    </div>
    
	<!-- jQuery 불러오기 -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
	<!-- 회원탈퇴 모달 스크립트 -->
	<script>
		$(function() {
			// 회원탈퇴 버튼 클릭 시 모달 열기
			$('#deleteModalOpen').click(function() {
				$('#deleteModal').addClass('show');
			});
	
			// '아니요' 버튼 클릭 시 모달 닫기
			$('#deleteModalNo').click(function() {
				$('#deleteModal').removeClass('show');
			});
	
			// '예' 버튼 클릭 시 회원탈퇴 처리
			$('#deleteModalYes').click(function() {
				$.ajax({
					type: 'POST',
					url: 'delete-user.jsp',
					success: function() {
						alert('회원탈퇴가 완료되었습니다.');
						window.location.href = '../login/login-form.jsp'; // 세션 정리하고 index로 가게끔
					},
					error: function() {
						alert('회원탈퇴 중 오류가 발생했습니다.');
					}
				});
			});
		});
	</script>
	
	<%@ include file="../common/footer.jsp" %>
	
</body>

</html>