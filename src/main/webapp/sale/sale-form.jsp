<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

 
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
                                <img src="https://image.yes24.com/goods/92147169/XL"
                                    alt="Hyukoh, Sunset Rollercoaster - AAA"
                                    style="width: 200px; height: 200px; object-fit: cover;">

                            </div>
                            <div class="product-details">
                                <div>
                                    <div class="badge">미개봉</div>
                                </div>
                                <h2>Hyukoh, Sunset Rollercoaster - AAA (Smokey Marble)</h2>
                                <p>혁오(hyukoh),Sunset Rollercoaster</p>
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
                            <h3 class="section-title">계좌 정보</h3>
                            <button class="account-edit-btn">계좌 변경</button>
                        </div>
                        <div class="account-info-content">
                            <p class="no-account-msg">등록된 계좌정보가 없습니다.</p>
                        </div>
                    </div>
                </div>
                <div class="vertical-line"></div>
                <!-- 오른쪽 컬럼 -->
                <div class="sale-form-right">


                    <!-- 가격 정보 -->
                    <div class="form-section">
                        <h3 class="section-title">가격 정보</h3>
                        <div class="price-info">
                            <div class="price-row">
                                <span class="price-label">최저 판매가</span>
                                <span>44,000원</span>
                            </div>
                            <div class="price-row">
                                <span class="price-label">최고판매가</span>
                                <span>200,000원</span>
                            </div>
                            <div class="price-row">
                                <span class="price-label">수수료</span>
                                <span id="commission">0</span>원
                            </div>
                            <form action="register-sale.jsp" method="post">
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
					allchecked = false;
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
    	
    	
        // 상태 태그 선택 기능
        document.querySelectorAll('.condition-tag').forEach(tag => {
            tag.addEventListener('click', () => {
                tag.classList.toggle('selected');
            });
        });

        // 탭 버튼 전환 기능
        document.querySelectorAll('.tab-button').forEach(button => {
            button.addEventListener('click', () => {
                document.querySelector('.tab-button.active').classList.remove('active');
                button.classList.add('active');
            });
        });
        
        
        
    </script>
</body>
</html>