<%@page import="kr.co.cdtrade.vo.Order"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.OrderMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   int orderNo = StringUtils.strToInt(request.getParameter("ono"));

   OrderMapper orderMapper = MybatisUtils.getMapper(OrderMapper.class);
   
   Order order = orderMapper.getOrderByNo(orderNo);       
%>
<!DOCTYPE html>
<html lang="ko">
 
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>구매완료</title>
    <link rel="stylesheet" href="../resources/css/common.css">
</head>

<body>
    <div class="container">
        <div class="complete-container">
            <div class="complete-title">결제 완료</div>
            <span class="complete-purchase-id">구매번호: <%= orderNo %></span>
            <img class="complete-img" src="<%= order.getcoverImageUrl() %>" alt="<%=order.getAlbumTitle() %>">
            <div class="badge" style="margin-bottom:1rem;">
<%
	if (order.getIsOpened().equals("f")) {
%>               
            미개봉
<%
	;} else {
%>
			개봉
<%
	;}
%>            
            
            </div>
            <div style="font-size:1.15rem;font-weight:bold;"><%=order.getAlbumTitle() %></div>
            <div style="color:#aaa; font-size:1rem; margin-bottom:2rem;"><%=order.getArtistName() %></div>
            <hr>
            <div class="complete-main-title">결제가 완료되었습니다.</div>
            <div class="complete-main-desc"></div>
            <table class="complete-table">
                <tr>
                    <th>주문앨범</th>
                    <td><%=order.getAlbumTitle() %></td>  
                </tr>
                <tr>
                    <th>아티스트명</th>
                    <td><%=order.getArtistName() %></td>
                </tr>    
                <tr>
                    <th>결제가격</th>
                    <td><%=StringUtils.commaWithNumber(order.getPrice() + order.getDeliveryFee()) %> 원</td>
                </tr>
                <tr>
                    <th>배송정보</th>
                    <td><%=order.getaddrBasic() %><br><%=order.getreceiverName() %> | <%=order.getreceiverTel() %></td>
                </tr>
            </table>   
            <hr>
            <button class="complete-btn">구매내역으로 이동하기</button>
            <button class="complete-btn">메인으로 돌아가기</button>
        </div>
    </div>
</body>

</html>