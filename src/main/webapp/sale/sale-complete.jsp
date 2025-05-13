<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	int saleNo = StringUtils.strToInt(request.getParameter("sno"));
	SalesMapper saleMapper = MybatisUtils.getMapper(SalesMapper.class);
	Sale sale = saleMapper.getSaleBySaleNo(saleNo);
	 
	
	Sale sale = new Sale();

%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품등록 완료</title>
    <link rel="stylesheet" href="../resources/css/common.css">
</head>

<body>
    <div class="container">
        <div class="complete-container">
            <div class="complete-title">상품등록 완료</div>
            <img class="complete-img" src="https://image.yes24.com/goods/92147169/XL" alt="신지훈 - 1집 별과 추억과 시 (2024)">
            <div class="badge" style="margin-bottom:1rem;">미개봉</div>
            <div style="font-size:1.15rem;font-weight:bold;">신지훈 - 1집 별과 추억과 시 (2024)</div>
            <div style="color:#aaa; font-size:1rem; margin-bottom:2rem;">신지훈</div>
            <img class="complete-img" src="<%=sale.getPhotoPath().split(",")[0] %>" alt="<%=sale.getAlbumTitle()%>">
            <div class="badge" style="margin-bottom:1rem;"><%="t".equals(sale.getIsOpened()) ? "중고" : "미개봉" %></div>
			<div id="album-title"
				style="font-size: 1.15rem; 
						font-weight: bold; 
						white-space: nowrap; 
						overflow: hidden; 
						text-overflow: ellipsis; 
						max-width: 600px;"><%=sale.getAlbumTitle()%></div>
			<div style="color:#aaa; font-size:1rem; margin-bottom:2rem;"><%=sale.getArtistName() %></div>
            <hr>
            <div class="complete-main-title">판매 상품이 등록되었습니다.</div>
            <div class="complete-main-desc">거래가 완료되면 알림톡이 발송됩니다.</div>
            <table class="complete-table">
                <tr>
                    <th>수수료</th>
                    <td class="fee">무료(0원)</td>
                </tr>
                <tr>
                    <th>판매희망가</th>
                    <td>160,000원</td>
                </tr>
                <tr>
                    <th>정산금액</th>
                    <td>160,000원</td>
                </tr>
            </table>
            <hr>
            <button class="complete-btn" href="http://localhost:8080/CDtrade/sale/sale-detail/sno=<%= %>">판매글 확인하기</button>
            <button class="complete-btn">메인으로 돌아가기</button>
        </div>
    </div>
    <%@include file="../../common/footer.jsp" %>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
</body>
</html>