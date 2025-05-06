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
            <li><a href="#">구매 내역</a></li>
            <li><a href="#">판매 내역</a></li>
            <li><a href="#">그.. 위시리스트♥</a></li>
        </ul>
    </div>

    <div class="mypage-menu-section">
        <div class="mypage-menu-section-title">내 정보</div>
        <ul class="mypage-menu-list">
            <li><a href="#">회원정보 수정</a></li>
            <li><a href="#">배송지 관리</a></li>
            <li><a href="#">정산 계좌 관리</a></li>
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
    <div class="modal">
        <div class="modal-title">회원탈퇴</div>
        <div class="modal-desc">
            회원탈퇴 시 기존에 저장된 정보가 모두 소멸하게 되며 복구할 수 없습니다.<br><br>
            <strong>해당 계정으로 재가입이 불가합니다.</strong><br><br>
            정말 탈퇴하시겠습니까?
        </div>
        <div class="modal-btns">
            <button class="modal-btn" id="deleteModalNo">아니오</button>
            <button class="modal-btn" id="deleteModalYes">예</button>
        </div>
    </div>
</div>

<!-- 탈퇴 모달 스크립트 -->
<script>
    document.getElementById('deleteModalOpen').onclick = function () {
        document.getElementById('deleteModal').classList.add('show');
    };
    document.getElementById('deleteModalNo').onclick = function () {
        document.getElementById('deleteModal').classList.remove('show');
    };
</script>
