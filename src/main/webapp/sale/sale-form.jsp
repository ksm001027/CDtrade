<%@page import="kr.co.cdtrade.vo.User"%>
<%@page import="kr.co.cdtrade.mapper.UserMapper"%>
<%@page import="kr.co.cdtrade.vo.Album"%>
<%@page import="kr.co.cdtrade.mapper.AlbumMapper"%>
<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	 int albumNo = StringUtils.strToInt(request.getParameter("ano"));
	 int userNo = StringUtils.strToInt(request.getParameter("uno"));
	 
	 
	 AlbumMapper albumMapper = MybatisUtils.getMapper(AlbumMapper.class);
	 Album album = albumMapper.getAlbumByAlbumNo(albumNo);
	 
	 UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
	 User user = userMapper.getUserByNo(userNo);
	 
	 
	 
	
%>

   
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매 등록</title>
    <link rel="stylesheet" href="../resources/css/common.css">
</head>

<body>
	<div class="container">
        <div class="sale-form-container">
            <div class="sale-form-layout">
                <!-- 왼쪽 컬럼 -->
                <div class="sale-form-left">
                    <!-- 상품 정보 -->
                    <div class="form-section">
                        <div class="product-info">
                            <div>
                                <img src="<%=album.getCoverImageUrl() %>"
                                    alt="<%=album.getArtistName() %>"
                                    style="width: 200px; height: 200px; object-fit: cover;">

                            </div>
                            <div class="product-details">
                                <div>
                                    <div class="badge">미개봉</div>
                                </div>
                                <h2><%=album.getTitle() %></h2>
                                <p><%=album.getArtistName() %></p>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <br>
                    <!-- 탭 버튼 -->
                    <div class="tab-buttons">
                        <button class="tab-button active">미개봉</button>
                        <button class="tab-button">중고</button>
                    </div>

                    <!-- 판매 체크리스트 -->
                    <div class="form-section">
                        <h3 class="section-title">판매 체크리스트</h3>
                        <div class="checkbox-list">
                            <label class="checkbox-item">
                                <input type="checkbox">
                                <span>겉비닐</span>
                            </label>
                            <label class="checkbox-item">
                                <input type="checkbox">
                                <span>특이사항</span>
                            </label>
                            <label class="checkbox-item">
                                <input type="checkbox">
                                <span>구성품</span>
                            </label>
                            <label class="checkbox-item">
                                <input type="checkbox">
                                <span>사인반</span>
                            </label>
                        </div>
                    </div>
                    <hr>
                    <!-- 상품 설명 -->
                    <div class="form-section">
                        <h3 class="section-title">상품설명</h3>
                        <div class="condition-tags">
                            <button class="condition-tag">모서리 손상</button>
                            <button class="condition-tag">잉크 구겨짐</button>
                            <button class="condition-tag">뒷면 구겨짐</button>
                            <button class="condition-tag">단순개봉</button>
                            <button class="condition-tag">1회 청음</button>
                        </div>
                        <div class="condition-tags">
                            <button class="condition-tag">정품에 지장 없는 얼룩 스크래치</button>
                            <button class="condition-tag">미세한 오염</button>
                            <button class="condition-tag">접힘</button>
                            <button class="condition-tag">상태 확인차 개봉</button>
                            <button class="condition-tag">구성품 없음</button>
                        </div>
                        <div class="condition-tags">
                            <button class="condition-tag">구성품 포함</button>
                            <button class="condition-tag">사인반</button>
                            <button class="condition-tag">테두리 터짐</button>
                        </div>
                        <textarea class="description-input" placeholder="내용을 입력해주세요."></textarea>
                    </div>

                    <!-- 사진 첨부 섹션 -->
                    <div class="form-section">
                        <h3 class="section-title">사진첨부</h3>
                        <p class="photo-description">사진 최대15장 첨부(*거래 앨범/뒤, 결함 확대)</p>

                        <div class="photo-link-container">
                            <div class="photo-link-input">
                                <input type="text" placeholder="사진 URL을 입력해주세요" class="link-input">
                                <button class="add-link-btn">추가</button>
                            </div>
                            <div class="photo-links">
                                <div class="photo-count">0/15</div>
                            </div>
                        </div>

                        <div class="photo-notice">
                            <p>*스크린샷이나 목업(mockup) 이미지가 아닌 실제 상품의 사진을 촬영해 주세요.</p>
                            <p>*커버는 전면과 후면 사진을 촬영하시고, 음반은 모든 면의 사진을 포함해 주세요.</p>
                            <p>*포함된 모든 구성품의 사진을 촬영해 주세요.</p>
                            <p>*상품에 결함이 있는 경우, 해당 결함 부분을 확대하여 촬영한 상세 사진을 제공해 주세요.</p>
                        </div>
                    </div>

                    <!-- 계좌 정보 섹션 -->
                    <div class="form-section">
                        <div class="account-info-header">
                        <input type="hidden" name="accountNumber" id="accountNumberInput">
                            <h3 class="section-title">계좌 정보</h3>
                            <button class="account-edit-btn" onclick="openModal()">계좌 변경</button>
                        </div>
                        <div class="account-info-content">
						    <p>은행: <span id="main-bank"><%=user.getBankName() != null ? user.getBankName() : "신한은행"%></span></p>
						    <p>예금주: <span id="main-holder"><%=user.getName()%></span></p>
						    <p>계좌번호: <span id="main-account"><%=user.getAccountNumber() != null ? user.getAccountNumber() : "110-123-456789"%></span></p>
						</div>

                    </div>
                </div>
                <div class="vertical-line"></div>
                <!-- 오른쪽 컬럼 -->
                <div class="sale-form-right">
                <!-- 계좌 변경 모달 -->
					<div id="accountModal"
						style="display: none; position: fixed; top: 20%; left: 50%; transform: translate(-50%, 0); background: #fff; padding: 20px; border: 1px solid #ccc; z-index: 1000;">
						<h3>계좌 선택</h3>
						<div id="accountList"></div>
						<button onclick="openAddAccountForm()">+ 새 계좌 추가</button>
						<div id="addAccountForm" style="display: none; margin-top: 20px;">
							<input type="text" id="newBank" placeholder="은행명"><br>
							<input type="text" id="newAccount" placeholder="계좌번호"><br>
							<input type="text" id="newHolder" placeholder="예금주"><br>
							<button onclick="addAccount()">저장</button>
							<button onclick="closeAddAccountForm()">취소</button>
						</div>
						<button onclick="closeModal()">닫기</button>
					</div>



					<!-- 가격 정보 -->
                    <div class="form-section">
                        <h3 class="section-title">가격 정보</h3>
                        <div class="price-info">
                            <div class="price-row">
                                <span class="price-label">평균판매가</span>
                                <span>44,000원</span>
                            </div>
                            <div class="price-row">
                                <span class="price-label">구매평균가</span>
                                <span>200,000원</span>
                            </div>
                            <div class="price-row">
                                <span class="price-label">수수료</span>
                                <span id="commission">0</span>원
                            </div>
                            <form action="register-sale.jsp" method="post" id="saleForm">
                            <div class="price-row">
                                <span class="price-label">판매희망가</span>
                                <input type="text" class="price-input" name="price" placeholder="판매희망가 입력"id="price-input">
                            </div>
                            </form>
                            <div class="price-row">
                                <span class="price-label">정산금액</span>
                                <span id="price">0</span>원
                            </div>
                        </div>
                    </div>
                    <hr>
                    <!-- 동의 사항 -->
                    <div class="agreement-box">
                        <label class="agreement-item">
                            <input type="checkbox">
                            <span>판매하려는 상품을 확인 했습니다. 앨범명, 아티스트명, 출시년도, CAT NO., 상세정보를 한번 더 확인했습니다.</span>
                        </label>
                        <label class="agreement-item">
                            <input type="checkbox">
                            <span>검수 기준과 <a href="#">이용 정책</a>을 확인했습니다.</span>
                        </label>
                        <label class="agreement-item">
                            <input type="checkbox">
                            <span>판매를 통해 거래 체결이 완료되면 단순 변심이나 실수에 의한 취소는 불가합니다.</span>
                        </label>
                        <label class="agreement-item">
                            <input type="checkbox">
                            <span>구매 조건을 모두 확인하였으며, 거래 진행에 동의합니다.</span>
                        </label>
                    </div>
					
                    <!-- 판매 버튼 -->
                    <button class="submit-button" form="saleForm" disabled>판매</button>

                    <!-- 주의사항 -->
                    <p class="notice-text">* 포토카드, 가사지, 스티커와 같은 구성품이 포함되어 있지 않거나 (분실), 특정 구성품이 누락되었다면 (미개봉), 이러한 정보를
                        기재해주세요.</p>
                    <p class="notice-text">* 결함이 미기재된 경우, 검수 과정에서 즉류 처리될 수 있습니다.</p>
                </div>
            </div>
        </div>
    </div>
	<!-- 계좌 변경 모달 -->
	<div id="accountModal"
		style="display: none; position: fixed; top: 20%; left: 50%; transform: translate(-50%, 0); background: #fff; padding: 20px; border: 1px solid #ccc; z-index: 1000;">
		<h3>계좌 정보 변경</h3>
		<form method="post" action="update-account.jsp">
			<input type="hidden" name="userNo" value="<%=user.getNo()%>">
			<input type="hidden" name="ano" value="<%=albumNo%>"> <input
				type="text" name="accountNumber" placeholder="새 계좌번호 입력"
				value="<%=user.getAccountNumber() != null ? user.getAccountNumber() : ""%>">
			<button type="submit">저장</button>
			<button type="button" onclick="closeModal()">취소</button>
		</form>
	</div>

	<%@include file="../../common/footer.jsp" %>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
    
    	
    	let currentMinPrice = 44000;
    	let currentMaxPrice = 200000;
    	
    
    	$("#price-input").keyup(function(){
    		let inputPrice = Number($("#price-input").val());
    		
    		
    		let commission = inputPrice*0.06;
    		let account = Math.round(inputPrice - commission);
    		
    		if (commission < 1){
    			commission = 0
    		} 
    		
    		$("#commission").text(commission.toFixed(0));
    		
    		
    		$("#price").text(account);
    		
    	});
    	
    	
    	$(".submit-button").click(function(e) {
			e.preventDefault();
			
			let inputPrice = Number($("#price-input").val()); 
			
			if (isNaN(inputPrice) || inputPrice <= 0) {
				alert("판매 희망가를 올바르게 입력해주세요.");
				$("#price-input").focus();
				return;
			}
			
			let allChecked = true;
			$(".agreement-item input[type='checkbox']").each(function() {
				if (!$(this).is(":checked")) {
					allChecked = false;
					return false;
				}
			})
			
			if (!allChecked) {
				alert("모든 동의사항을 체크해 주세요.");
				return;
			}
			
			$("form").submit();
			
		});
    	
    	function updateSubmitButtonState() {
    		let allChecked = true;
    		$(".agreement-item input[type='checkbox']").each(function(){
    			if (!$(this).is(":checked")) {
    				allChecked = false;
    				return false;
    			}
    		});
    		
    		const $submitButton = $(".submit-button");
    		if (allChecked) {
	    		$submitButton.prop("disabled", false);    			
    		} else {
    			$submitButton.prop("disabled", true)
    		}
    	}
    	
    	$(".agreement-item input[type='checkbox']").on("change", function() {
    		updateSubmitButtonState();
    	});
    	
    	$(document).ready(function() {
    		updateSubmitButtonState();    		
    	});
    	
    	document.addEventListener("DOMContentLoaded", function(){
    		const buttons = document.querySelectorAll(".condition-tag");
    		const textarea = document.querySelector(".description-input");
    		
    		for(let i = 0; i < buttons.length; i++) {
    			buttons[i].addEventListener("click", function(){
    				const text = buttons[i].textContent.trim();
    				let lines = textarea.value.split("\n");
    				
    				if (buttons[i].classList.contains("selected")) {
    					buttons[i].classList.remove("selected");
    					lines = lines.filter(function(line){
    						return line.trim() !== text;
    					});
    					textarea.value = lines.join("\n");
    				} else {
    					buttons[i].classList.add("selected");
    					if (!lines.includes(text)) {
    						lines.push(text);
    						textarea.value = lines.join("\n");
    					}
    				}
    			});
    		}
    	});
    	

        // 탭 버튼 전환 기능
        document.querySelectorAll('.tab-button').forEach(button => {
            button.addEventListener('click', () => {
                document.querySelector('.tab-button.active').classList.remove('active');
                button.classList.add('active');
            });
        });
        
        
        document.querySelector('.account-edit-btn').addEventListener('click', function() {
            document.getElementById('accountModal').style.display = 'block';
        });

       
        function openModal() {
            document.getElementById('accountModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('accountModal').style.display = 'none';
        }

        let accounts = [
            { bank: "신한은행", account: "110-123-456789", holder: "홍길동", isMain: true }
        ];

        function renderMainAccount() {
            const main = accounts.find(acc => acc.isMain);
            document.getElementById("main-bank").innerText = main.bank;
            document.getElementById("main-holder").innerText = main.holder;
            document.getElementById("main-account").innerText = main.account;
            document.getElementById("accountNumberInput").value = main.account;
        }

        function openModal() {
            document.getElementById("accountModal").style.display = "block";
            renderAccountList();
        }

        function closeModal() {
            document.getElementById("accountModal").style.display = "none";
        }

        function renderAccountList() {
            const container = document.getElementById("accountList");
            container.innerHTML = "";
            accounts.forEach((acc, i) => {
                const radio = `<input type="radio" name="selectedAcc" ${acc.isMain ? "checked" : ""} onclick="setMainAccount(${i})">`;
                const info = `${acc.bank} (${acc.account}) / ${acc.holder}`;
                container.innerHTML += `<div>${radio} ${info}</div>`;
            });
        }

        function setMainAccount(index) {
            accounts.forEach((acc, i) => acc.isMain = (i === index));
            renderMainAccount();
            renderAccountList();
        }

        function openAddAccountForm() {
            document.getElementById("addAccountForm").style.display = "block";
        }

        function closeAddAccountForm() {
            document.getElementById("addAccountForm").style.display = "none";
        }

        function addAccount() {
            const bank = document.getElementById("newBank").value;
            const acc = document.getElementById("newAccount").value;
            const holder = document.getElementById("newHolder").value;
            if (bank && acc && holder) {
                accounts.push({ bank, account: acc, holder, isMain: false });
                renderAccountList();
                closeAddAccountForm();
            } else {
                alert("모든 정보를 입력해주세요.");
            }
        }

        // 초기 로딩 시 기본 계좌 세팅
        document.addEventListener("DOMContentLoaded", renderMainAccount);

        
    </script>
</body>
</html>