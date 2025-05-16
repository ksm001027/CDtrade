<%@page import="java.util.HashMap"%>
<%@page import="kr.co.cdtrade.mapper.AlbumMapper"%>
<%@page import="kr.co.cdtrade.vo.Album"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);
    List<Sale> recentSales = salesMapper.getRecentOnSaleProducts(); 
    List<Sale> recentCompletedSales = salesMapper.getRecentCompletedSales();
    
    AlbumMapper albumMapper = MybatisUtils.getMapper(AlbumMapper.class);
    Map<String, Object> albumCondition = new HashMap<>();
    albumCondition.put("offset", 0);
    albumCondition.put("rows", 8);
    albumCondition.put("sort", "recent-order");
    List<Album> albums = albumMapper.getAlbums(albumCondition);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Vinyl Store</title>
  <link rel="stylesheet" href="resources/css/common.css">
</head>
<body>

	<%@ include file="common/nav.jsp" %>
  <div class="container">
  <!-- 
  	가장 최근 거래된 앨범 목록 
   -->
  	<div class="recommended-products">
           <div class="main-sesction-header">
	            <h2 class="section-title">최근 판매 앨범</h2>
	            <a href="sale/sale-list.jsp">더보기 ></a>
  			</div>

			<div class="section-product-list">
	            <div class="product-grid" id="sales-list">				
	                <div class="product-card">
	                	<a href="../sale/sale-detail.jsp?sno=8">
	                    <div class="product-image">
	                        <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
	                    </div>
	                    </a>
	                    <h3 class="card-title">김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집</h3>
	                    <p class="card-price">60,000원</p>
	                    
	                </div>
	                <div class="product-card">
	                	<a href="../sale/sale-detail.jsp?sno=8">
	                    <div class="product-image">
	                        <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
	                    </div>
	                    </a>
	                    <h3 class="card-title">김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집</h3>
	                    <p class="card-price">60,000원</p>
	                    
	                </div>
	                <div class="product-card">
	                	<a href="../sale/sale-detail.jsp?sno=8">
	                    <div class="product-image">
	                        <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
	                    </div>
	                    </a>
	                    <h3 class="card-title">김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집</h3>
	                    <p class="card-price">60,000원</p>
	                    
	                </div>	
	                <div class="product-card">
	                	<a href="../sale/sale-detail.jsp?sno=8">
	                    <div class="product-image">
	                        <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
	                    </div>
	                    </a>
	                    <h3 class="card-title">김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집</h3>
	                    <p class="card-price">60,000원</p>
	                    
	                </div>	
	                <div class="product-card">
	                	<a href="../sale/sale-detail.jsp?sno=8">
	                    <div class="product-image">
	                        <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
	                    </div>
	                    </a>
	                    <h3 class="card-title">김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집</h3>
	                    <p class="card-price">60,000원</p>
	                    
	                </div>	
	                <div class="product-card">
	                	<a href="../sale/sale-detail.jsp?sno=8">
	                    <div class="product-image">
	                        <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
	                    </div>
	                    </a>
	                    <h3 class="card-title">김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집</h3>
	                    <p class="card-price">60,000원</p>
	                    
	                </div>	
        </div>
  </div>
  
  <!-- 판매상품 목록 -->
  <div class="recommended-products">
  		<div class="main-sesction-header">
            <h2 class="section-title">판매상품</h2>
            <a href="sale/sale-list.jsp">더보기 ></a>
  		</div>

			<div class="section-product-list">
				
	            <div class="product-grid" id="sales-list">				
					<% for(Sale recentSale : recentSales) { 
						String[] photos = recentSale.getPhotoPath().split(","); %>
	                <!-- 판매상품 블록 -->
	                <div class="product-card-2">
	                	<a href="sale/sale-detail.jsp?sno=<%=recentSale.getNo()%>">
		                    <div class="product-image">
		                        <img src="<%=photos[0].trim() %>" alt="<%=recentSale.getAlbumTitle()%>">
		                    </div>
	                    </a>
	                    <div class="card-info">
		                    <h3 class="card-title"><%=recentSale.getAlbumTitle() %></h3>
		                    <p class="card-price"><%=String.format("%,d", recentSale.getPrice()) %>원</p>
	                    </div>
	                </div>
	                <%}%>
	                	                    
	                </div>
        </div>
        
  </div>
  
  <!--  장르별 목록 -->
   <div class="recommended-products">
  		<div class="main-sesction-header">
            <h2 class="section-title">장르별 검색</h2>
  		</div>

		<div class="section-product-list">
			<div class="product-grid">
				<!-- 장르 카드 -->
				<div class="card-genre">
                     <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		             <p>인디</p>
				</div>
				<!-- 장르 카드 -->
				<div class="card-genre">
                     <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		             <p>인디</p>
				</div><!-- 장르 카드 -->
				<div class="card-genre">
                     <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		             <p>인디</p>
				</div><!-- 장르 카드 -->
				<div class="card-genre">
                     <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		             <p>인디</p>
				</div><!-- 장르 카드 -->
				<div class="card-genre">
                     <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		             <p>인디</p>
				</div><!-- 장르 카드 -->
				<div class="card-genre">
                     <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		             <p>인디</p>
				</div><!-- 장르 카드 -->
				<div class="card-genre">
                     <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		             <p>인디</p>
				</div><!-- 장르 카드 -->
				<div class="card-genre">
                     <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		             <p>인디</p>
				</div><!-- 장르 카드 -->
				<div class="card-genre">
                     <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		             <p>인디</p>
				</div><!-- 장르 카드 -->
				<div class="card-genre">
                     <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		             <p>인디</p>
				</div><!-- 장르 카드 -->
				<div class="card-genre">
                     <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		             <p>인디</p>
				</div>
			</div>
	           
        </div>
        
  </div>
  
</body>
</html>
