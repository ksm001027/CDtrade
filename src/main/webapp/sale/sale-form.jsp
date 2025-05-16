<%@page import="org.apache.catalina.mapper.Mapper"%>
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
	String mode = request.getParameter("mode");
	int albumNo = StringUtils.strToInt(request.getParameter("ano"));
	int saleNo = 0; 
	String snoParam = request.getParameter("sno");
	if (snoParam != null){
	saleNo = StringUtils.strToInt(request.getParameter("sno"));
	}
	SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);
	AlbumMapper albumMapper = MybatisUtils.getMapper(AlbumMapper.class);
	
	Album album = albumMapper.getAlbumByAlbumNo(albumNo);
	Sale sale = null;
	
	if ("edit".equals(mode) && saleNo > 0) {
	    sale = salesMapper.getSaleBySaleNo(saleNo);
	}
		 
	
%>

   
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@include file="../common/nav.jsp" %>
    <title><%= "edit".equals(mode) ? "상품 수정" : "판매 등록" %>판매 등록</title>
    <link rel="stylesheet" href="../resources/css/common.css">
</head>
<%
	UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
	User user = userMapper.getUserByNo(loginedUserNo);
%>

<body>
<h1><%= "edit".equals(mode) ? "상품 수정" : "판매 등록" %></h1>

<form action="<%= "edit".equals(mode) ? "update-sale.jsp" : "register-sale.jsp" %>" method="post" id="saleForm">
	<input type="hidden" name="mode" value="<%= mode %>">
	<input type="hidden" name="sno" value="<%= saleNo %>">
	<input type="hidden" name="ano" value="<%= albumNo %>">
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
                    <input type="hidden" name="isOpened" id="isOpenedInput" value="<%= sale != null ? sale.getIsOpened() : "f" %>">
                        <button type="button" class="tab-button active">미개봉</button>
                        <button type="button" class="tab-button">중고</button>
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
                            <button type="button" class="condition-tag">모서리 손상</button>
                            <button type="button" class="condition-tag">잉크 구겨짐</button>
                            <button type="button" class="condition-tag">뒷면 구겨짐</button>
                            <button type="button" class="condition-tag">단순개봉</button>
                            <button type="button" class="condition-tag">1회 청음</button>
                        
                            <button type="button" class="condition-tag">정품에 지장 없는 얼룩 스크래치</button>
                            <button type="button" class="condition-tag">미세한 오염</button>
                            <button type="button" class="condition-tag">접힘</button>
                            <button type="button" class="condition-tag">상태 확인차 개봉</button>
                            <button type="button" class="condition-tag">구성품 없음</button>
                       
                            <button type="button" class="condition-tag">구성품 포함</button>
                            <button type="button" class="condition-tag">사인반</button>
                            <button type="button" class="condition-tag">테두리 터짐</button>
                        </div>
                        <textarea class="description-input" name="description" placeholder="내용을 입력해주세요."><%= sale != null ? sale.getDescription().trim() : "" %></textarea>
                        
                    </div>

                    <!-- 사진 첨부 섹션 -->
                    <div class="form-section" name="photoPath">
                        <h3 class="section-title">사진첨부</h3>
                        <p class="photo-description">사진 최대15장 첨부(*거래 앨범/뒤, 결함 확대)</p>

                        <div class="photo-link-container">
                            <div class="photo-link-input">
                                <input type="text" placeholder="사진 URL을 입력해주세요"  class="link-input">
                                <button type="button" class="add-link-btn">추가</button>
                            </div>
							<div class="photo-links">
								<div class="photo-count" id="photoCount">0/15</div>
								<div class="photo-list"></div>
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
                            <button class="account-edit-btn" onclick="openModal()" disabled>계좌 변경</button>
                        </div>
                        <div class="account-info-content">
						    <p><span id="main-bank"></span></p>
						    <p>예금주: <span id="main-holder"><%=user.getName()%></span></p>
						    <p>계좌번호: <span id="main-account"><%=user.getAccountNumber()%></span></p>
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
                                <span><%=String.format("%,d", album.getAvgSalePrice())  %>원</span>
                            </div>
                            <div class="price-row">
                                <span class="price-label">구매평균가</span>
                                <span><%=String.format("%,d", album.getAvgOrderPrice()) %>원</span>
                            </div>
                            <div class="price-row">
                                <span class="price-label">수수료(판매가의 3%)</span>
                                <span id="commission">0원</span>
                            </div>
                            
                            
                            <input type="hidden" name="photoPath" id="photoLinksInput">
                            <div class="price-row">
                                <span class="price-label">판매희망가</span>
                                <input type="text" class="price-input" value="<%= sale != null ? sale.getPrice() : "" %>" name="price" placeholder="판매희망가 입력"id="price-input">
                            </div>
                            
                            <div class="price-row">
                                <span class="price-label">정산금액</span>
                                <span id="price">0원</span>
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
                    <button type="submit" class="submit-button" form="saleForm" disabled>
                    <%= "edit".equals(mode) ? "상품 수정" : "판매 등록" %>
                    </button>

                    <!-- 주의사항 -->
                    <p class="notice-text">* 포토카드, 가사지, 스티커와 같은 구성품이 포함되어 있지 않거나 (분실), 특정 구성품이 누락되었다면 (미개봉), 이러한 정보를
                        기재해주세요.</p>
                    <p class="notice-text">* 결함이 미기재된 경우, 검수 과정에서 즉류 처리될 수 있습니다.</p>
                </div>
            </div>
        </div>
    </div>
</form>
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
    		
    		$("#commission").text(Math.round(commission).toLocaleString() + "원");
    		$("#price").text(account.toLocaleString() + "원");
    		
    	});
    	
    	
    	$(".submit-button").click(function(e) {
			e.preventDefault();
			
			updatePhotoList(); // ✅ 사진 링크를 form에 반영하기 위한 핵심 코드
			
			let inputPrice = Number($("#price-input").val()); 
			
			if (photoLinks.length === 0) {
		        alert("상품 사진을 최소 1장 이상 첨부해주세요.");
		        return;
		    }
			
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
    	
    	document.addEventListener("DOMContentLoaded", function () {
    	    // 계좌 정보 렌더링
    	    renderMainAccount();

    	    // 조건 태그 버튼 클릭 처리
    	    const buttons = document.querySelectorAll(".condition-tag");
    	    const textarea = document.querySelector(".description-input");

    	    buttons.forEach(button => {
    	        button.addEventListener("click", function () {
    	            const text = button.textContent.trim();

    	            // 현재 텍스트를 줄바꿈 기준으로 배열로 변환, 빈 값 제거
    	            let lines = textarea.value.split("\n").filter(line => line.trim() !== "");

    	            if (button.classList.contains("selected")) {
    	                // ✅ 선택 해제: 리스트에서 해당 텍스트 제거
    	                button.classList.remove("selected");
    	                lines = lines.filter(line => line !== text);
    	            } else {
    	                // ✅ 선택: 버튼에 selected 추가하고, 배열에 텍스트 추가
    	                button.classList.add("selected");
    	                if (!lines.includes(text)) {
    	                    lines.push(text);
    	                }
    	            }

    	            // ✅ 텍스트 영역에 다시 반영
    	            textarea.value = lines.join("\n");
    	        });
    	    });

    	    // 사진 첨부 초기화
    	    updatePhotoList();
    	});

    	

        // 탭 버튼 전환 기능
      document.querySelectorAll('.tab-button').forEach(button => {
    button.addEventListener('click', () => {
        // 기존 active 클래스 제거
        document.querySelector('.tab-button.active').classList.remove('active');
        // 클릭한 버튼에 active 클래스 추가
        button.classList.add('active');

        // ✅ 미개봉 클릭 시 'f', 중고 클릭 시 't'로 반대값 저장
        const isOpenedValue = button.innerText === '미개봉' ? 'f' : 't';
        document.getElementById('isOpenedInput').value = isOpenedValue;

        console.log(`isOpened 값 설정됨: ${isOpenedValue}`); // 디버깅 로그
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
            { account: "<%= user.getAccountNumber() != null ? user.getAccountNumber() : "110-123-456789" %>", holder: "<%= user.getName() %>", isMain: true }
        ];


        function renderMainAccount() {
            const main = accounts.find(acc => acc.isMain);
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
                const info = `${acc.account} / ${acc.holder}`;
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
            const acc = document.getElementById("newAccount").value;
            const holder = document.getElementById("newHolder").value;
            if (acc && holder) {
                accounts.push({ account: acc, holder, isMain: false });
                renderAccountList();
                closeAddAccountForm();
            } else {
                alert("모든 정보를 입력해주세요.");
            }
        }


      

        const photoLinks = [];

        const addButton = document.querySelector(".add-link-btn");
        const input = document.querySelector(".link-input");

        addButton.addEventListener("click", () => {
            const url = input.value.trim();

            if (!url) {
                alert("사진 URL을 입력해주세요.");
                return;
            }

            if (!/^https?:\/\/.+/.test(url)) {
                alert("올바른 URL 형식이 아닙니다.");
                return;
            }

            if (photoLinks.includes(url)) {
                alert("이미 추가된 사진입니다.");
                return;
            }

            if (photoLinks.length >= 15) {
                alert("사진은 최대 15장까지 첨부 가능합니다.");
                return;
            }

            photoLinks.push(url);
            input.value = "";
            updatePhotoList();

            // 확인 로그
            console.log("✅ 현재 photoLinks 배열:", photoLinks);
        });



        function updatePhotoList() {
            const countEl = document.querySelector(".photo-count");
            const listEl = document.querySelector(".photo-list");
            const hiddenInput = document.getElementById("photoLinksInput"); // 이거 중요
            
            hiddenInput.value = photoLinks.join(",");
            listEl.innerHTML = "";

            photoLinks.forEach(function(url, i) {
                const div = document.createElement("div");
                div.style.marginBottom = "12px";

                const a = document.createElement("a");
                a.href = url;
                a.target = "_blank";
                a.innerText = "사진 " + (i + 1);

                const img = document.createElement("img");
                img.src = url;
                img.alt = "photo-" + i;
                img.style.width = "120px";
                img.style.display = "block";
                img.style.marginTop = "4px";

                img.onerror = function () {
                    img.style.display = "none";
                    a.innerText += " (이미지 로드 실패)";
                };

                // ✅ 삭제 버튼 생성
                const delBtn = document.createElement("button");
                delBtn.innerText = "삭제";
                delBtn.className = "delete-btn";
                delBtn.addEventListener("click", function () {
                    photoLinks.splice(i, 1);  // 배열에서 i번째 요소 제거
                    updatePhotoList();        // 화면 다시 렌더링
                });

                // ✅ 요소들 조립
                div.appendChild(a);
                div.appendChild(img);
                div.appendChild(delBtn); // 삭제 버튼 추가
                listEl.appendChild(div);
            });


            countEl.textContent = `\${photoLinks.length}/15`;

            // 👉 폼 제출용 hidden input에 photoLinks 넣기
            hiddenInput.value = JSON.stringify(photoLinks);
        }



    </script>
</body>
</html>