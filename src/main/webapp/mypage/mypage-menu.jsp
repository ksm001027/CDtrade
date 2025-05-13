<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
.mypage-menu a,
.mypage-menu a:visited,
.mypage-menu a:link,
.mypage-menu a:active {
    color: #333 !important;
    text-decoration: none !important;
}

.mypage-menu a:hover {
    color: black;
    text-decoration: underline;
}
</style>

<!-- 좌측 메뉴 -->
<nav class="mypage-menu">
    <div class="mypage-menu-title">마이페이지</div>

    <div class="mypage-menu-section">
        <div class="mypage-menu-section-title">쇼핑 정보</div>
        <ul class="mypage-menu-list">
            <li><a href="../order/order-form.jsp">구매 내역</a></li>
            <li><a href="../sale/sale-form.jsp">판매 내역</a></li>
            <li><a href="../wishlist/wish-list.jsp">그.. 위시리스트♥</a></li>
            <li><a href="../mycollection/mycollection.jsp">마이 컬렉션</a></li>
        </ul>
    </div>

    <div class="mypage-menu-section">
        <div class="mypage-menu-section-title">내 정보</div>
        <ul class="mypage-menu-list">
            <li><a href="../edit-profile/edit-profile-form.jsp">회원정보 수정</a></li>
            <li><a href="../delivery/delivery-form.jsp">배송지 관리</a></li>
            <li><a href="../account/manage-account.jsp">계좌번호 관리</a></li>
        </ul>
    </div>

    <div class="mypage-menu-section">
        <div class="mypage-menu-section-title">설정</div>
        <ul class="mypage-menu-list">
            <li><a href="../login/logout.jsp">로그아웃</a></li>
            <li id="deleteModalOpen" style="cursor:pointer;">회원탈퇴</li>
        </ul>
    </div>
</nav>

<!-- 회원탈퇴 모달 -->
<div class="modal-backdrop" id="deleteModal">
	<div class="modal show">
		<div>
			<h2 class="modal-title">두익이네</h2>
			<p class="modal-desc">회원탈퇴시 기존에 저장된 정보가<br>모두 소멸하게 되며 복구할 수 없게 됩니다.</p>
			<p class="modal-desc"><strong>해당 계정으로 재가입이 불가능합니다.</strong></p>
			<p class="modal-desc">그래도 탈퇴하시겠습니까?</p>
		</div>

		<div class="modal-btns">
			<button class="modal-btn" id="deleteModalNo">아니요</button>
			<button class="modal-btn" id="deleteModalYes">예</button>
		</div>
	</div>
</div>


