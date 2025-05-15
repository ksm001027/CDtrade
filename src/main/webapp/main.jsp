<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

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
            <h2 class="section-title">최근 판매 앨범</h2>

			<div class="section-product-list">
				<button class="product-pagination-btn" id="sales-prev-btn" disabled="">
					 <svg width="24" height="48" viewBox="0 0 24 48" fill="none" xmlns="http://www.w3.org/2000/svg">
			            <path d="M15 41L7 24L15 7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
			        </svg>
				</button>
	            <div class="product-grid" id="sales-list">				

	                <!-- 판매상품 블록 -->
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
         <button class="product-pagination-btn" id="sales-next-btn">
	            	 <svg width="24" height="48" viewBox="0 0 24 48" fill="none" xmlns="http://www.w3.org/2000/svg">
			            <path d="M9 7L17 24L9 41" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
			         </svg>
	            </button>
  
  </div>
  
  <!-- 판매상품 목록 -->
  <div class="recommended-products">
  		<div class="main-sesction-header">
            <h2 class="section-title">판매상품</h2>
            <a href="#">더보기 ></a>
  		</div>

			<div class="section-product-list">
				
	            <div class="product-grid" id="sales-list">				

	                <!-- 판매상품 블록 -->
	                <div class="product-card-2">
	                	<a href="../sale/sale-detail.jsp?sno=8">
		                    <div class="product-image">
		                        <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		                    </div>
	                    </a>
	                    <div class="card-info">
		                    <h3 class="card-title">김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집</h3>
		                    <p class="card-price">60,000원</p>
	                    </div>
	                    
	                </div>
	                
	                <div class="product-card-2">
	                	<a href="../sale/sale-detail.jsp?sno=8">
		                    <div class="product-image">
		                        <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		                    </div>
	                    </a>
	                    <div class="card-info">
		                    <h3 class="card-title">김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집</h3>
		                    <p class="card-price">60,000원</p>
	                    </div>
	                    
	                </div>
	                
	                 <div class="product-card-2">
	                	<a href="../sale/sale-detail.jsp?sno=8">
		                    <div class="product-image">
		                        <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		                    </div>
	                    </a>
	                    <div class="card-info">
		                    <h3 class="card-title">김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집</h3>
		                    <p class="card-price">60,000원</p>
	                    </div>
	                    
	                </div>
	                
	                 <div class="product-card-2">
	                	<a href="../sale/sale-detail.jsp?sno=8">
		                    <div class="product-image">
		                        <img src="https://storage.second-track.com/album/album-1707357027234311.png" alt="김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집">
		                    </div>
	                    </a>
	                    <div class="card-info">
		                    <h3 class="card-title">김광석 - 인생 이야기 [180g 2LP] - 공연 멘트집+스페셜 엽서(6종)+커버 가사집</h3>
		                    <p class="card-price">60,000원</p>
	                    </div>
	                    
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
