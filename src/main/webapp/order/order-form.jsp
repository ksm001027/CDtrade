<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.vo.Address"%>
<%@page import="kr.co.cdtrade.mapper.AddressMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="kr.co.cdtrade.mapper.SaleMapper"%>
<%@page import="kr.co.cdtrade.mapper.OrderMapper"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>     
<%   
     //String userNo = (String) session.getAttribute("LOGINED_USER_NO");
     	     
          
     	OrderMapper orderMapper = MybatisUtils.getMapper(OrderMapper.class);
     	SaleMapper saleMapper = MybatisUtils.getMapper(SaleMapper.class);
     	AddressMapper addressMapper = MybatisUtils.getMapper(AddressMapper.class);   
     	
     	//List<Address> addresses = addressMapper.getAllAddressByUserNo(userNo);   
     	int delivery = 'f';
     	int deliveryFee = 2800;
     	int saleNo = 4;
     	int userNo = 1;
     	Sale sale = saleMapper.getSaleByNo(saleNo);
     	Address address = addressMapper.getBasicAddressByUserNo(userNo);   
%>
<!DOCTYPE html>   
<html lang="ko">   
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제</title>
    <link rel="stylesheet" href="../resources/css/common.css">
</head>

<body>
	<form id="form-order" method="post" action="order-process.jsp">
    <input type="hidden" name="no" value=1 />
    <input type="hidden" name="price" value=<%=sale.getPrice() %> />
    <input type="hidden" name="deliveryFee" value=<%=deliveryFee %> />
    <input type="hidden" name="paymentMethod" value="무통장" />
    <input type="hidden" name="status" value="완료" />
    <input type="hidden" name="addrNo" id="input-addr-no" value="1" />
    <input type="hidden" name="saleNo" value="<%=saleNo %>" /> 
    <input type="hidden" name="albumNo" value="<%=sale.getAlbumNo()%>" />
    <input type="hidden" name="userNo" value="2" />
    </form>




    <div class="container">
        <div class="order-form-layout">
            <!-- 왼쪽 영역 -->
            <div class="order-form-left">
                <div class="order-form-title">결제</div>
                <div class="order-form-section">
                    <div class="order-product-info">
                        <img src="<%=sale.getPhotoPath() %>" alt="Blonde">
                        <div class="order-product-detail">
<% 
	if (sale.getIsOpened().equals("f")) {    
%>
                            <div><span class="badge">미개봉</span></div>
<%
	;} else {
%>
							<div><span class="badge">개봉</span></div>
<%
	;}
%>
                            <span class="order-product-title"><%=sale.getAlbumTitle()%></span>
                            <span class="order-product-artist"><%=sale.getArtistName() %></span>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="order-form-section">
                    <div class="order-form-label">구매 가격</div>    
                    <div class="order-form-value"><%=StringUtils.commaWithNumber(sale.getPrice()) %>원</div>
                    <hr class="order-form-hr">
                </div>
                <div class="order-form-section">
                    <div class="order-form-header">
                        <div class="order-form-label">배송지 정보</div>
                        <button class="order-shipping-btn" id="btn-open-address-modal">배송지 선택</button> 
                    </div>
                    <div class="order-shipping-box">
                        우편번호 : 
                        <input type="text"
                         class="form-control" 
                         id="input-addr-zipcode" 
                         value="<%=address.getZipCode() %>" disabled><br>
                         주소 : 
                        <input type="text"
                         class="form-control" 
                         id="input-addr-basic" 
                         value="<%=address.getAddrBasic() %>" disabled>
                        <input type="text"
                         class="form-control" 
                         id="input-addr-detail" 
                         value="<%=address.getAddrDetail() %>" disabled><br>
                         수령인 및 전화번호 : 
                        <input type="text"
                         class="form-control" 
                         id="input-addr-receiverName" 
                         value="<%=address.getReceiverName() %>" disabled>
                        <input type="text"
                         class="form-control" 
                         id="#input-addr-tel" 
                         value="<%=address.getReceiverTel() %>" disabled>
                   
                    </div> 
                </div>
                <div class="order-form-section">
                    <div class="order-form-label">결제 방법</div>
                    <div class="order-pay-methods">
                        <button class="order-pay-btn " id="btn-paymethod" onclick="dis()">무통장 입금</button>
                    </div>
                    <div class="order-shipping-box" id="dis" align="center">                   
                    	<h1>예금주 : <%=sale.getUserName() %></h1>
                    	<br><h1>계좌정보 : <%=sale.getUserAccountNumber() %></h1>
                    </div>
                </div>
            </div>
            <div class="vertical-line"></div>
            <!-- 오른쪽 영역 -->
            <div class="order-form-right">
                <div class="order-summary-title">결제 정보</div>
                <table class="order-summary-table">
                    <tr>
                        <th>상품 구매금액</th>
                        <td><%=StringUtils.commaWithNumber(sale.getPrice()) %>원</td>
                    </tr>
                    <tr>
                        <th>배송비</th>
                        <td><%=StringUtils.commaWithNumber(deliveryFee) %>원</td>
                    </tr>
                    <tr>
                        <th>검수비</th>
                        <td>무료</td>
                    </tr>
                    <tr>
                        <th>총 결제 금액</th>
                        <td class="order-summary-total"><%=StringUtils.commaWithNumber(sale.getPrice() + deliveryFee) %>원</td>
                    </tr>
                </table>
                <hr>
                <ul class="order-agree-list">
                    <li class="order-agree-item"><input type="checkbox" name="ck1">구매하려는 상품을 확인했습니다. 앨범명, 아티스트명, 출시년도, CAT NO.,
                        상세정보를 한번 더 확인했습니다.</li>
                    <li class="order-agree-item"><input type="checkbox" name="ck1"><strong id="text-modal1">검수 기준과</strong><strong id="text-modal2"> 이용 정책</strong>을 확인했습니다.</li>
                    <li class="order-agree-item"><input type="checkbox" name="ck1">판매자의 판매거부, 배송지연, 미입고 등의 사유가 발생할 경우, 거래가 취소될 수
                        있습니다. 거래 진행 상태 알림을 위한 알림톡 수신 동의와 등록 전화번호를 확인 했습니다.</li>
                    <li class="order-agree-item"><input type="checkbox" name="ck1">구매를 통해 거래 체결이 완료되면 단순 변심이나 실수에 의한 취소는 불가합니다.
                    </li>
                    <li class="order-agree-item"><input type="checkbox" name="ck1"><strong>구매 조건을 모두 확인하였으며, 거래 진행에 동의합니다.</strong>
                    </li>
                </ul>
                <button id="pay-button" class="order-pay-final-btn" disabled>결제</button>
            </div>
        </div>
    </div>
    <!-- 배송지 선택 모달 -->
    <div class="address-modal-backdrop" id="addressSelectModal">
        <div class="address-modal">
            <div class="address-modal-header">
                배송지 선택
                <button class="address-modal-close" id="closeAddressSelect">&times;</button>
            </div>
            <div class="address-list">
                <div class="address-item" id="address-list"></div>
            </div>
            <div class="address-modal-footer">
                <button class="address-modal-btn" id="closeAddressSelect2">적용</button>
                <button class="address-modal-btn" id="openAddressAdd">주소지 추가</button>
            </div>
        </div>
    </div>
    <!-- 배송지 추가 모달 -->
    <div class="address-modal-backdrop" id="addressAddModal">
        <div class="address-modal">
            <div class="address-modal-header">
                배송지 추가
                <button class="address-modal-close" id="closeAddressAdd">&times;</button>
            </div>
            <form class="address-add-form">
                <label class="address-add-label">배송지명</label>
                <input class="address-add-input" type="text" placeholder="배송지명을 입력하세요">
                <label class="address-add-label">수령인</label>
                <input class="address-add-input" type="text" placeholder="수령인을 입력하세요">
                <label class="address-add-label">수령인 전화번호</label>
                <input class="address-add-input" type="text" placeholder="숫자만 입력해주세요">
                <label class="address-add-label">배송지주소</label>
                <div class="address-add-row">
                    <input class="address-add-input" type="text" placeholder="우편번호">
                    <button class="address-search-btn" type="button">주소지 검색</button>
                </div>
                <input class="address-add-input" type="text" placeholder="배송지 주소">
                <input class="address-add-input" type="text" placeholder="상세 주소">
            </form>
            <div class="address-modal-footer">
                <button class="address-modal-btn" id="closeAddressAdd2">닫기</button>
                <button class="address-modal-btn">저장</button>
            </div>
        </div>
    </div>
    <!-- <!-- 결제 확인 모달 -->
    <div class="modal-backdrop" id="payModal">
        <div class="modal">
            <div class="modal-title">상품 결제</div>
            <div class="modal-desc">정말 상품을 결제하시겠습니까?</div>
            <div class="modal-btns">
                <button class="modal-btn" id="payModalNo">아니오</button>
                <button class="modal-btn" id="payModalYes">예</button>
            </div>
        </div>
    </div> 
    
    <div class="address-modal-backdrop" id="checkModal1">
        <div class="address-modal">
            <div class="address-modal-header">
                검수 기준
                <button class="address-modal-close" id="closecheckModal1">&times;</button>
            </div>
            <div class="modal-desc">
            검수 기준1<br>검수 기준2<br>
            <br><br><br><br><br><br><br><br><br>
            </div>
            
        </div>
    </div>
    
    <div class="address-modal-backdrop" id="checkModal2">
        <div class="address-modal">
            <div class="address-modal-header">
                이용 정책
                <button class="address-modal-close" id="closecheckModal2">&times;</button>
            </div>
            <div class="modal-desc">
            이용 정책1<br>이용 정책2<br>
            <br><br><br><br><br><br><br><br><br>
            </div>
            
        </div>
    </div>
    
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
        // 배송지 선택 모달 닫기
        document.getElementById('closeAddressSelect').onclick = function () {
            document.getElementById('addressSelectModal').classList.remove('show');
        };
        document.getElementById('closeAddressSelect2').onclick = function () {
            document.getElementById('addressSelectModal').classList.remove('show');
        };
        // 배송지 추가 모달 열기
        document.getElementById('openAddressAdd').onclick = function () {
            document.getElementById('addressSelectModal').classList.remove('show');
            document.getElementById('addressAddModal').classList.add('show');
        };
        // 배송지 추가 모달 닫기
        document.getElementById('closeAddressAdd').onclick = function () {
            document.getElementById('addressAddModal').classList.remove('show');
        };
        document.getElementById('closeAddressAdd2').onclick = function () {
            document.getElementById('addressAddModal').classList.remove('show');
        };
        // 결제 확인 모달 열기
        document.querySelector('.order-pay-final-btn').onclick = function (e) {
            e.preventDefault();
            document.getElementById('payModal').classList.add('show');
        };
        // 결제 확인 모달 닫기
        document.getElementById('payModalNo').onclick = function () {
            document.getElementById('payModal').classList.remove('show');
        };
        document.getElementById('payModalYes').onclick = function () {
            document.getElementById('payModal').classList.remove('show');
            // 실제 결제 로직은 여기에 추가
        };
        document.getElementById('closecheckModal1').onclick = function () {
            document.getElementById('checkModal1').classList.remove('show');
        };
        document.getElementById('closecheckModal2').onclick = function () {
            document.getElementById('checkModal2').classList.remove('show');
        };
        
        $(":checkbox[name='ck1']").click(function(){
        	if($(":checkbox[name='ck1']:checked").length == 5){
        		$(".order-pay-final-btn").addClass("active");
        		$(".order-pay-final-btn").attr("disabled", false);
        }
        	else{
        		$(".order-pay-final-btn").removeClass("active");
        		$(".order-pay-final-btn").attr("disabled", true);
        	}});
        
        $("#pay-button").click(function() {
        	$("#form-order").trigger("submit");
        });
        
        $("#text-modal1").click(function() {
        	document.getElementById('checkModal1').classList.add('show');
        });
        $("#text-modal2").click(function() {
        	document.getElementById('checkModal2').classList.add('show');
        });
        
        $('#dis').hide();
        
        function dis(){
          if($('#dis').css('display') == 'none'){
            $('#dis').show();
            $(".order-pay-btn").addClass("active");
          }else{
            $('#dis').hide();
            $(".order-pay-btn").removeClass("active");
          }
          }; 
          
        $("#closeAddressSelect2").click(function() {
        	let $radio = $("#address-list :radio:checked");
        	
        	let no = $radio.attr("data-addr-no");
        	let name = $radio.attr("data-addr-name");
        	let zipcode = $radio.attr("data-addr-zipcode");
        	let basic = $radio.attr("data-addr-basic");
        	let detail = $radio.attr("data-addr-detail");
        	let recname = $radio.attr("data-addr-receiverName");
        	let rectel = $radio.attr("data-addr-tel");
        	
        	$("#input-addr-no").val(no);
        	$("#input-addr-name").val(name);
        	$("#input-addr-zipcode").val(zipcode);
        	$("#input-addr-basic").val(basic);
        	$("#input-addr-detail").val(detail);
        	$("#input-addr-receiverName").val(recname);
        	$("#input-addr-tel").val(rectel);
        	
        	document.getElementById('addressSelectModal').classList.add('hide');
        });
        
        
        $("#btn-open-address-modal").click(function(){
    		document.getElementById('addressSelectModal').classList.add('show');
    		
    		$.ajax({
    			type: "get",
    			url: "order-address.jsp",
    			dataType: "json",
    			success: function(addressArr){
    				let $div = $("#address-list").empty();
    				
    				for (let addr of addressArr) {
    					let content = `
        					<div class="address-list-item" data-address-id="1">                      
                                	<input class="form-check-input" 
                                		type="radio" 
                                		name="addressRadio" 
                                		id="address-\${addr.no}" \${addr.isDefaultAddress == 't' ? 'checked' : ''}
                                		data-addr-no="\${addr.no}"
                                		data-addr-name="\${addr.name}"
                                		data-addr-receiverName="\${addr.receiverName}"
                                		data-addr-tel="\${addr.receiverTel}"
                                		data-addr-basic="\${addr.addrBasic}"
                                		data-addr-detail="\${addr.addrDetail}"
                                		data-addr-zipcode="\${addr.zipCode}">
                                	<label class="form-check-label" for="address1">
                                		<div class="address-item">
                                		<div><span class="address-name">\${addr.name}</span></div>
                                        <div class="address-info">\${addr.zipCode}</div>
                                        <div class="address-info">\${addr.addrBasic} \${addr.addrDetail}</div>
                                        <div class="address-phone"> \${addr.receiverName}| \${addr.receiverTel}</div>                  
                                	</label>                           	
                        	</div>
        				`;
        				$("#address-list").append(content);
    				}
    			}
    		})
        });
    				
    </script>
   
</body>

</html>