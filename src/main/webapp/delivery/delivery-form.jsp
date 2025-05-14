7<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배송지 관리</title>
    <link rel="stylesheet" href="../resources/css/common.css">
</head>
<body>
    <%@ include file="../common/nav.jsp" %>

    <div class="mypage-layout">
        <%@ include file="../mypage/mypage-menu.jsp" %>

        <main class="mypage-content">
            <div class="container">
                <div class="address-modal-header">
                    배송지 관리
                    <button class="address-btn" id="openAddressAdd">주소지 추가</button>
                </div>

                <!-- 배송지 목록 -->
                <%@ include file="address-list.jsp" %>

            </div>
        </main>
    </div>

<!-- 배송지 추가 모달 -->
<div class="address-modal-backdrop" id="addressAddModal">
    <div class="address-modal">
        <div class="address-modal-header">
            배송지 추가
            <button class="address-modal-close" id="closeAddressAdd">&times;</button>
        </div>
        <form class="address-add-form" action="address-add.jsp" method="post">
            <label class="address-add-label">배송지명</label>
            <input class="address-add-input" type="text" name="addrName" placeholder="배송지명을 입력하세요">

            <label class="address-add-label">수령인</label>
            <input class="address-add-input" type="text" name="receiverName" placeholder="수령인을 입력하세요">

            <label class="address-add-label">수령인 전화번호</label>
            <input class="address-add-input" type="text" name="receiverTel" placeholder="숫자만 입력해주세요">
			<div class="form-text-receiverTel"></div>

            <label class="address-add-label">배송지주소</label>
            <div class="address-add-row">
                <input class="address-add-input" type="text" name="zipCode" placeholder="우편번호">
                <button class="address-search-btn" type="button" data-modal="add">주소지 검색</button>
            </div>
            <input class="address-add-input" type="text" name="addrBasic" placeholder="배송지 주소">
            <input class="address-add-input" type="text" name="addrDetail" placeholder="상세 주소">

            <!-- 기본 배송지 설정 체크박스 -->
            <label>
                <input type="checkbox" name="isDefaultAddress" value="t"> 기본배송지로 설정
            </label>

            <div class="address-modal-footer">
                <button class="address-modal-btn" type="button" id="closeAddressAdd2">닫기</button>
                <button class="address-modal-btn" type="submit">저장</button>
            </div>
        </form>
    </div>
</div>

<!-- 배송지 수정 모달 -->
<div class="address-modal-backdrop" id="editAddressModal">
	<div class="address-modal">
		<div class="address-modal-header">
			배송지 수정
			<button class="address-modal-close" id="closeEditModal">&times;</button>
		</div>
		<form class="address-add-form" action="address-add.jsp" method="post">
			<input type="hidden" name="addrNo">

			<label class="address-add-label">배송지명</label>
			<input class="address-add-input" type="text" name="addrName">

			<label class="address-add-label">수령인</label>
			<input class="address-add-input" type="text" name="receiverName">

			<label class="address-add-label">전화번호</label>
			<input class="address-add-input" type="text" name="receiverTel" >
			<div id="tel-validation-message" style="color: red; font-size: 12px;"></div>

			<label class="address-add-label">배송지 주소</label>
			<div class="address-add-row">
                <input class="address-add-input" type="text" name="zipCode" placeholder="우편번호">
                <button class="address-search-btn" type="button" data-modal="edit">주소지 검색</button>
            </div>
			<input class="address-add-input" type="text" name="addrBasic">
			<input class="address-add-input" type="text" name="addrDetail">

			<label>
				<input type="checkbox" name="isDefaultAddress" value="t"> 기본배송지로 설정
			</label>

			<div class="address-modal-footer">
				<button class="address-modal-btn" type="button" id="closeEditModal2">닫기</button>
                <button class="address-modal-btn" type="submit">저장</button>
			</div>
		</form>
	</div>
</div>



    <script>
        document.getElementById('openAddressAdd').onclick = function () {
            document.getElementById('addressAddModal').classList.add('show');
        };
        document.getElementById('closeAddressAdd').onclick = function () {
            document.getElementById('addressAddModal').classList.remove('show');
        };
        document.getElementById('closeAddressAdd2').onclick = function () {
            document.getElementById('addressAddModal').classList.remove('show');
        };
    </script>
    
    <script>
    document.querySelectorAll('.edit-address-btn').forEach(btn => {
    	btn.addEventListener('click', function() {
    		const modal = document.getElementById('editAddressModal');
    		modal.querySelector('[name="addrNo"]').value = this.dataset.addrNo;
    		modal.querySelector('[name="addrName"]').value = this.dataset.addrName;
    		modal.querySelector('[name="receiverName"]').value = this.dataset.receiverName;
    		modal.querySelector('[name="receiverTel"]').value = this.dataset.receiverTel;
    		modal.querySelector('[name="zipCode"]').value = this.dataset.zipCode;
    		modal.querySelector('[name="addrBasic"]').value = this.dataset.addrBasic;
    		modal.querySelector('[name="addrDetail"]').value = this.dataset.addrDetail;

    		// 기본배송지 체크박스 상태 설정
    		const isDefault = this.dataset.isDefault === 't';
    		modal.querySelector('[name="isDefaultAddress"]').checked = isDefault;

    		modal.classList.add('show');
    	});
    });

    // 모달 닫기 버튼
    document.getElementById('closeEditModal').onclick = function () {
    	document.getElementById('editAddressModal').classList.remove('show');
    };
    document.getElementById('closeEditModal2').onclick = function () {
    	document.getElementById('editAddressModal').classList.remove('show');
    };
    </script>
    
<!-- 다음 우편번호 오픈 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
	// 배송지 추가/수정 모달 각각에서 "주소지 검색" 버튼 클릭 시 동작
	document.querySelectorAll('.address-search-btn').forEach(btn => {
		btn.addEventListener('click', function() {
			const modalType = this.dataset.modal; // 'add' 또는 'edit'

			new daum.Postcode({
				oncomplete: function(data) {
					const zonecode = data.zonecode;
					const roadAddress = data.roadAddress;

					let zipInput, addrBasicInput, addrDetailInput;

					if (modalType === 'add') {
						zipInput = document.querySelector('#addressAddModal input[name="zipCode"]');
						addrBasicInput = document.querySelector('#addressAddModal input[name="addrBasic"]');
						addrDetailInput = document.querySelector('#addressAddModal input[name="addrDetail"]');
					} else if (modalType === 'edit') {
						zipInput = document.querySelector('#editAddressModal input[name="zipCode"]');
						addrBasicInput = document.querySelector('#editAddressModal input[name="addrBasic"]');
						addrDetailInput = document.querySelector('#editAddressModal input[name="addrDetail"]');
					}

					if (zipInput && addrBasicInput && addrDetailInput) {
						zipInput.value = zonecode;
						addrBasicInput.value = roadAddress;
						addrDetailInput.focus(); // 상세주소로 커서 이동
					}
				}
			}).open();
		});
	});
</script>

<script type="text/javascript">
	let telRegExp = /^010-\d{4}-\d{4}$/;
	
	$("input[name='receiverTel']").keyup(function() {
		let value = $(this).val();
		let $message = $("#tel-validation-message");
	
		if (!telRegExp.test(value)) {
			$message.text("올바른 전화번호 형식을 입력하세요. (예: 010-1234-5678)");
		} else {
			$message.text("");
		}
	});
	
	$(".address-add-form, .address-edit-form").on("submit", function(e) {
		let tel = $(this).find("input[name='receiverTel']").val();
		if (!telRegExp.test(tel)) {
			alert("전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)");
			$(this).find("input[name='receiverTel']").focus();
			e.preventDefault();
			return false;
		}
	});
</script>

</body>
</html>
