<%@page import="kr.co.cdtrade.vo.MyCollectionItem"%>
<%@page import="kr.co.cdtrade.mapper.MyCollectionMapper"%>
<%@page import="kr.co.cdtrade.mapper.OrderMapper"%>
<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@page import="kr.co.cdtrade.vo.Review"%>
<%@page import="kr.co.cdtrade.mapper.ReviewMapper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.cdtrade.vo.Order"%>
<%@page import="kr.co.cdtrade.utils.GenreMappingUtils"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.mapper.AlbumGenreMapper"%>
<%@page import="kr.co.cdtrade.vo.Album"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.AlbumMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	/*
		앨범 상세 페이지 8
		필요한 파라미터 : albumNo, sessionUserNo 
		
		요청처리절차 
		1. albumNo로 앨범을 조회 및 표현
			albumNo로 장르 조회 및 표현 
		2. albumNo로 order의 목록을 조회 및 표현 
			- 최근 거래 더보기를 누를때마다 거래내역 5개씩 더 불러오기 -> AJAX로 처리 
			- ajax로 sale-history.jsp로 요청 전달 (요청파라미터 : offset, row, albumNo)
				ㄴ offset은 (더보기 클릭 수)*5 
			- 응답으로 받은 json데이터 파싱 후 테이블에 append 
			- 마지막요소까지 보여졌으면 더보기 버튼 보이지 않도록 설정하기 
				orderRowsByAlbumNo 로 전체 주문수 구하고, 리스트에 표현된 주문 데이터가 전체주문수와 같으면 더보기 버튼 보이지 않도록 설정하기? 
		3. albumNo로 sale의 목록을 조회 및 표현 
			- 정렬 조건이 변경되면 sale 목록 다시 가져오기 -> AJAX로 처리 
			- 페이지네이션도 처리해야함 -> AJAX로 처리 
		4. albumNo로 리뷰 목록 조회 및 표현
			- 사용자 본인이 이미 별점을 남겼다면 남긴 별점 화면에 표시되도록
			- 사용자 본인의 댓글이면 수정, 삭제버튼 추가 
			- 리뷰 더보기 누를때마다 리뷰 더 불러오기 -> AJAX로 처리 
				ㄴ ajax로 album-review-list.jsp로 요청 전달 
				ㄴ 응답으로 받은 json데이터 파싱후 review-list div에 append 
				ㄴ 마지막요소까지 보여졌으면 더보기 버튼 보이지 않도록 설정하기
					=> reviewRowsByAlbumNo 로 전체 리뷰수 구하고, 리스트에 표현된 주문 데이터가 전체주문수와 같으면 더보기 버튼 보이지 않도록 설정하기? 
		5. 리뷰 등록 시 review-add.jsp로 요청 폼 보내기 
			- 마이컬렉션에 해당 앨범을 추가할건지 묻는 모달창 띄우기
				ㄴ 등록버튼을 눌렀을때, 모달창이 뜨는 이벤트 설정해서 review-add.jsp에서 마이컬렉션에 데이터 추가하는 로직까지 구현하기 
				ㄴ 이미 리뷰를 달았을 떄, 리뷰 수정창 아래에 마이컬렉션에 등록하기/제외하기 옵션을 추후에도 선택할 수 있도록하기 
				ㄴ 리뷰가 삭제되면 마이컬렉션에서도 삭제되게 하기
		6. 위시리스트 테이블에 해당 albumNo, 해당 사용자의 userNo를 가진 행이 존재유무에 따라 위시리스트 버튼 스타일 설정 000000000000000000
		7. 클릭 시 이동해야하는 페이징 처리
		
		++ 위시리스트 찜 개수 표현할지 말지 결정 
		++ 장르 클릭하면 장르별 앨범 목록 페이지로 이동 
		++ 판매상품이 몇일전에 올라온건지 표시 (하루전, 2일전, ... 일주일전, 몇개월 전 ...)
	*/
	
	int albumNo = StringUtils.strToInt(request.getParameter("albumNo"));
	// int userNo = (int) session.getAttribute("LOGINED_USER_NO");
	int userNo = 1;
	
	// 앨범 상세 정보 조회 
	AlbumMapper albumMapper = MybatisUtils.getMapper(AlbumMapper.class);
	Album album = albumMapper.getAlbumByNo(albumNo);
	
	// 앨범의 장르 조회
	AlbumGenreMapper albumGenreMapper = MybatisUtils.getMapper(AlbumGenreMapper.class);
	List<Integer> genres = albumGenreMapper.getGenreNosByAlbumNo(albumNo);
	
	// 앨범 거래 내역 조회 
	int orderOffset = 0;
	int orderRows = 5;
	
	OrderMapper orderMapper = MybatisUtils.getMapper(OrderMapper.class);
	List<Order> orders = orderMapper.getOrdersByAlbumNo(albumNo, orderOffset, orderRows);
	// 조회된 거래 내역 개수
	int nowOrderRows = orders.size();
	
	// 앨범 거래 내역 전체 행 개수 조회 
	Map<String, Object> orderCondition = new HashMap<>();
	orderCondition.put("albumNo", albumNo);
	int totalOrderRows = orderMapper.getTotalRows(orderCondition);
	
	// 전체 거래내역 행 개수와 조회된 거래내역 행 개수를 비교해서, 모든 데이터가 조회된건지 식별하는 변수 정의하기 
	boolean hasMoreOrders = (nowOrderRows == totalOrderRows) ? false : true;
	
	
	// 최근거래가 변수 정의 
	int recentPrice = orders.size() != 0? orders.get(0).getPrice() : 0;
	
	/*
		------------------------
		리뷰 목록
	*/
	// 앨범에 달린 리뷰 목록 조회 
	int reviewOffset = 0;
	int reviewRows = 3;
	
	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
	List<Review> reviews = reviewMapper.searchReviewsByAlbumNo(albumNo, reviewOffset, reviewRows);
	// 조뢰된 리뷰 목록 개수 
	int nowReviewRows = reviews.size();
	
	
	// 앨범에 달린 리뷰 개수 조회
	int totalReviewRows = reviewMapper.getRowsByAlbumNo(albumNo);
	
	// 전체 리뷰 행 개수와 조회된 리뷰 행 개수를 비교해서, 모든 데이터가 조회된건지 식별하는 변수 정의하기 
	boolean hasMoreReviews = (nowReviewRows == totalReviewRows) ? false : true;
	
	// 본인이 해당 앨범에 남긴 리뷰 조회 
	Review myReview = reviewMapper.getReviewByAlbumNoAndUserNo(albumNo, userNo);
	
	MyCollectionItem myCollectionItem = null;
	if (myReview != null){
		MyCollectionMapper myCollectionMapper = MybatisUtils.getMapper(MyCollectionMapper.class);
		myCollectionItem = myCollectionMapper.findByUserAndAlbum(userNo, albumNo);
	}
	
	/*
		-----------------------
		판매 상품 목록
	*/
	
	// 앨범번호로 상품 목록 조회 
	SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);
	Map<String, Object> saleCondition = new HashMap<>();
	saleCondition.put("albumNo", albumNo);
	saleCondition.put("sort", "newest");
	saleCondition.put("offset", 0);
	saleCondition.put("rows", 8);
	List<Sale> sales = salesMapper.getSales(saleCondition);
	
	// 전체 판매 상품 개수 조회 
	Map<String, Object> saleRowsCondition = new HashMap<>();
	saleRowsCondition.put("albumNo", albumNo);
	int totalSaleRows = salesMapper.getTotalRows(saleRowsCondition);
	
	
%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CDtrade</title>
    <link rel="stylesheet" href="../resources/css/common.css">
</head>

<body>
	<%@ include file="../common/nav.jsp" %>
	<!-- 
		페이지가 로딩되는 시점에 자바스크립트에서 albumNo를 알고있어야함 -> 화면에 나타나지 않는 태그에 데이터 심어두고, 자바스크립트에서 가져오기 
	 -->
	<div id="album-info" 
		data-album-no="<%=albumNo %>" 
		data-total-order-rows="<%=totalOrderRows%>"
		data-order-rows="<%=orderRows %>"
		data-total-review-rows="<%=totalReviewRows%>"
		data-review-rows="<%=reviewRows %>"
		data-user-no="<%=userNo%>"
		data-total-sale-rows="<%=totalSaleRows%>"></div>
    <div class="container">
        <div class="detail-container">
            <!-- 왼쪽: 앨범 이미지 -->
            <div class="detail-image">
                <img src="<%= album.getCoverImageUrl() %>" alt="<%= album.getTitle()%>">
            </div>
            <!-- 오른쪽: 앨범 정보 -->
            <div class="detail-info">
                <div class="detail-header">
                    <div>
                        <h1 class="detail-title"><%= album.getTitle() %></h1>
                        <p class="artist-name"><%= album.getArtistName() %></p>
                    </div>
                    <button class="icon-button" id="wishlist-btn">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                            xmlns="http://www.w3.org/2000/svg">
                            <path
                                d="M19 21L12 16L5 21V5C5 4.46957 5.21071 3.96086 5.58579 3.58579C5.96086 3.21071 6.46957 3 7 3H17C17.5304 3 18.0391 3.21071 18.4142 3.58579C18.7893 3.96086 19 4.46957 19 5V21Z"
                                stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                stroke-linejoin="round" fill="#628868" />
                        </svg>
                        <span class="bookmark-count">32</span>
                    </button>
                </div>
<%
	// 0.5 단위로 평균 평점에 따라 별 색상 다르게 표시 
    double rating = album.getAvgRating(); // 예: 3.7
    int fullStars = (int) rating;         // 가득 찬 별의 개수 -> 3개 
    boolean hasHalf = (rating - fullStars) >= 0.5; // 반 별이 있는지 -> 1개 
    int emptyStars = 5 - fullStars - (hasHalf ? 1 : 0); // 나머지는 빈 별 -> 1개
%>
                <div class="rating">
                    <div class="stars">
<% for (int i = 0; i < fullStars; i++) { %>
    					<span class="star filled">★</span>
<% } %>

<% if (hasHalf) { %>
    					<span class="star half">★</span>
<% } %>

<% for (int i = 0; i < emptyStars; i++) { %>
    					<span class="star">★</span>
<% } %>
                        <span class="rating-score"><%= album.getReviewCount() == 0 ? "-" :album.getAvgRating() %> (<%= album.getReviewCount() %>)</span>
                    </div>
                </div>

                <div class="product-details">
                    <h2>Information</h2>
                    <dl class="info-list">
                        <div class="info-item">
                            <dt>발매일</dt>
                            <dd><%= StringUtils.simpleDate(album.getReleaseDate()) %></dd>
                        </div>
                        <div class="info-item">
                            <dt>장르</dt>
                            <dd>
<%
	for (int i = 0; i<genres.size(); i++){
%>
							<a href="#" class="text-link"><%= GenreMappingUtils.GENRE_NO_TO_NAME.get(genres.get(i)) %></a><%= i <  genres.size() - 1 ? "," : "" %>
<%
	}
%>
                            </dd>
                        </div>
                        <div class="info-item">
                            <dt>정가</dt>
                            <dd><%= StringUtils.commaWithNumber(album.getReleasePrice()) %>원</dd>
                        </div>
                        <div class="info-item">
                            <dt>평균판매가</dt>
                            <dd><%= album.getAvgSalePrice() == 0? "-" : StringUtils.commaWithNumber(album.getAvgSalePrice())+"원" %></dd>
                        </div>
                        <div class="info-item">
                            <dt>평균구매가</dt>
                            <dd><%= album.getAvgOrderPrice() == 0? "-" : StringUtils.commaWithNumber(album.getAvgOrderPrice())+"원" %></dd>
                        </div>
                        <div class="info-item">
                            <dt>최근거래가</dt>
                            <dd><%= recentPrice == 0? "-" : StringUtils.commaWithNumber(recentPrice)+"원" %></dd>
                        </div>
                    </dl>

                    <a href="../sale/sale-form.jsp?ano=<%=albumNo %>" class="purchase-btn">판매</a>

                    <div class="recent-trades">
                        <div class="section-header">
                        	<h3>최근거래</h3>
                        	<div class="product-count">총 거래수  <%=totalOrderRows %>개</div>
                        </div>
                        <table class="trades-table">
                            <thead>
                                <tr>
                                    <th>컨디션</th>
                                    <th>거래일</th>
                                    <th>거래가격</th>
                                </tr>
                            </thead>
                            <tbody id="order-table-body">
<%
	if(orders.isEmpty()){
%>
								<tr>
									<td colspan="3" rowspan="3" style="text-align: center; height: 200px">최근 거래가 없습니다</td>
								</tr>
<%
	} else {
		for (Order order : orders) {
%>

                                <tr>
                                    <td><%= order.getSale().getIsOpened() == "f" ? "미개봉": "중고" %></td>
                                    <td><%= StringUtils.simpleDate(order.getCreatedAt()) %></td>
                                    <td><%= StringUtils.commaWithNumber(order.getPrice()) %>원</td>
                                </tr>
<%
		}
	}
%>
                               
                            </tbody>
                        </table>
                    </div>
<%
	if(!orders.isEmpty() && hasMoreOrders){ // + 가장 아래의 구매데이터가 마지막 구매데이터가 아닐때만 더보기 버튼 표시 
%>
                    <button class="view-all-btn" id="order-view-btn">더보기</button>
<%
	}
%>
                </div>
            </div>
        </div>

        <!-- 
        	판매 상품 목록 
        -->
        <div class="recommended-products">
            <h2 class="section-title">판매 상품 목록</h2>
<%
	if (sales.isEmpty()){
%>
					<div style="text-align: center; height: 100px;">
					등록된 판매 상품이 없습니다 
					</div>
					
<%
	} else {
 %>
 			<div class="section-header">
                <div class="product-count">전체 상품 <%=totalSaleRows %>개</div>
                   <select class="sort-select" id="sale-sort-btn">
					  <option value="newest">최신순</option>
					  <option value="price-desc">높은가격순</option>
					  <option value="price-asc">낮은가격순</option>
					</select>
            </div>
			<div class="section-product-list">
				<button class="product-pagination-btn" id="sales-prev-btn">
					 <svg width="24" height="48" viewBox="0 0 24 48" fill="none" xmlns="http://www.w3.org/2000/svg">
			            <path d="M15 41L7 24L15 7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
			        </svg>
				</button>
	            <div class="product-grid" id="sales-list">				
<%
		for (Sale sale : sales) {
%>
	                <!-- 판매상품 블록 -->
	                <div class="product-card">
	                	<a href="../sale/sale-detail.jsp?sno=<%=sale.getNo()%>">
	                    <div class="product-image">
	                        <img src="<%=sale.getPhotoPath() %>" alt="<%=sale.getAlbumTitle() %>">
	                    </div>
	                    </a>
	                    <h3 class="card-title"><%=sale.getAlbumTitle() %></h3>
	                    <p class="card-price"><%= StringUtils.commaWithNumber(sale.getPrice()) %>원</p>
	                    
	                </div>
<%
		}
%>
	            </div>
	            <button class="product-pagination-btn" id="sales-next-btn">
	            	 <svg width="24" height="48" viewBox="0 0 24 48" fill="none" xmlns="http://www.w3.org/2000/svg">
			            <path d="M9 7L17 24L9 41" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
			         </svg>
	            </button>
            </div>
<%
	}
%>
        </div>

        <!-- 앨범 리뷰 섹션 -->
        <div class="album-reviews">
<!-- 
	사용자가 해당앨범에 리뷰를 작성하지 않았을 때 
 -->
<%
	if (myReview == null) {
%>
        	<form action="../review/review-add.jsp" method="post" id="review-form">
        		<input type="hidden" name="isAddMyCollection">
	            <div class="review-header">
	                <div> 
	                	<h2>앨범리뷰</h2>
	                	<br>
	                 	<div class="stars">
	                        <span class="review-form-star" data-order="1">★</span>
	                        <span class="review-form-star" data-order="2">★</span>
	                        <span class="review-form-star" data-order="3">★</span>
	                        <span class="review-form-star" data-order="4">★</span>
	                        <span class="review-form-star" data-order="5">★</span>
	                    </div>
	                    <input type="hidden" value="0" name="rating" id="rating-input">
	                    <input type="hidden" value="<%= albumNo %>" name="albumNo">
	                </div>
	                <div class="review-stats">
	                    <div class="review-count">전체 <%= totalReviewRows %>개</div>
	                </div>
	            </div>
	
	            <div class="review-write">
	                <textarea placeholder="리뷰를 작성하고 앨범을 마이컬렉션에 추가해보세요" class="review-textarea" name="content"></textarea>
	                <button class="review-submit" type="button" id="review-form-btn">등록</button>
	            </div>
	        </form>
	     </div>
<!-- 
	사용자가 해당앨범에 리뷰를 이미 작성했을 떄 리뷰 수정 폼 
 -->
<%
	} else {
%>
			<form action="#" method="post" id="my-review-form">
	            <div class="review-header">
	                <div> 
	                	<h2>앨범리뷰</h2>
	                	<br>
						<div class="stars" id="my-review-rating" data-my-review-rating="<%=myReview.getRating()%>">
 <%
 	double myReviewRating = myReview.getRating();
    for (int i = 1; i <= 5; i++) {
        if (i <= (int) myReviewRating) {
%>
           					 <span class="review-form-star full" data-order="<%=i%>">★</span>
<%
        } else if (i - myReviewRating <= 0.5) {
%>
           					 <span class="review-form-star half" data-order="<%=i%>">★</span>
<%
        } else {
%>
           					 <span class="review-form-star" data-order="<%=i%>">★</span>
<%
        }
    }
%>
	                    </div>
	                    <input type="hidden" value="0" name="rating" id="rating-input">
	                    <input type="hidden" value="<%= albumNo %>" name="albumNo">
	                    <input type="hidden" value="<%= myReview.getNo() %>" name="reviewNo">
	                </div>
	                <div class="review-stats">
	                    <div class="review-count">전체 <%= totalReviewRows %>개</div>
	                </div>
	            </div>
	
	            <div class="review-write">
	                <textarea placeholder="리뷰를 작성해주세요" class="review-textarea" name="content" ><%=myReview.getContent()%></textarea>
	                <button class="review-submit" type="submit" id="review-update-btn">수정</button>
	                <button class="review-submit second" type="submit" id="review-delete-btn">삭제</button>
	            </div>
	           	</form>
	           		<div class="my-collection-section" id="my-collection-div">
<%
		if (myCollectionItem == null) {
%>
					  <button class="my-collection-btn" id="my-collection-add-btn" data-my-review-no="<%=myReview.getNo()%>">
					  	  <span class="icon">+</span>
					  	  마이컬렉션에 추가하기
					  </button>
<%
		} else {
%>
					<button class="my-collection-btn" id="my-collection-del-btn" data-my-review-no="<%=myReview.getNo()%>">
					  	  <span class="icon">-</span>
					  	  마이컬렉션에서 삭제하기
					  </button>
<%
		}
%>
					</div>
	        </div>
<%
	}
%>
        	
            

            <div class="review-list" id="review-list">
<%
	if(reviews.isEmpty()){
%>     
				<div style="text-align: center; height: 300px">
					등록된 리뷰가 없습니다 
				</div>
<%
	} else {
		
		for (Review review : reviews){
			  double reviewRating = review.getRating(); // 예: 3.5
%>
                <!-- 리뷰 아이템 1 -->
                <div class="review-item <%= (review.getUser().getNo() == userNo ? "mine" : "") %>">
                    <div class="review-stars">
            <%
                for (int i = 1; i <= 5; i++) {
                    if (i <= (int)reviewRating) {
            %>
                        <span class="star filled">★</span>
            <%
                    } else if (i - reviewRating <= 0.5) {
            %>
                        <span class="star half">★</span>
            <%
                    } else {
            %>
                        <span class="star">★</span>
            <%
                    }
                }
            %>
                    </div>
                    <p class="review-text"><%= review.getContent() == null ? "" : review.getContent() %></p>
                    <div class="review-info">
                        <span class="reviewer"><%= review.getUser().getNickname() %></span>
                        <span class="review-date"><%= StringUtils.simpleDate(review.getCreatedAt()) %></span>
                    </div>
                </div>
<%
		}
	}
%>
        </div>
<%
	if(!reviews.isEmpty() && hasMoreReviews){ // + 가장 아래의 리뷰데이터가 마지막 리뷰데이터가 아닐때만 더보기 버튼 표시 
%>
                   <button id="review-view-btn" class="more-reviews">더보기</button>
<%
	}
%>
    </div>
    
    <!-- 마이컬렉션 추가 모달 -->
    <div id="my-collection-check-Modal" class="modal-backdrop">
	  <div class="modal-content">
	    <div class="modal-title">마이컬렉션 추가</div>
	    <div class="modal-desc">마이컬렉션에 해당 앨범을 추가하시겠습니까?</div>
	    <div class="modal-btns" id="my-collection-modal-btn">
		    <a href="#" class="modal-btn" data-is-add-my-collection="true">예</a>	
		    <a href="#" class="modal-btn" data-is-add-my-collection="false">아니요</a>	
	    </div>
	  </div>
	</div>
	
	<%@ include file="../common/footer.jsp" %>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
    	const albumNo = parseInt($("#album-info").attr("data-album-no"));
    	const userNo = parseInt($("#album-info").attr("data-user-no"));
    	
    	/*
    		------------- 
    		마이컬렉션 등록 버튼과 관련된 이벤트 
    	*/
    	$("#my-collection-div").on("click", "#my-collection-add-btn", function(){
    		if(confirm("마이컬렉션에 앨범을 추가하시겠습니까?")){
    			const myReviewNo = $(this).attr("data-my-review-no");
    			$.ajax({
    				type: 'get',
    				url: '../mycollection/add-mycollection-item.jsp',
    				data: {albumNo: albumNo, reviewNo : myReviewNo},
    				dataType: 'text',
    				success: function(reviews){
    					
    	    			$div = $("#my-collection-div").empty();
    	    			
    	    			const deleteBtn = ` <button class="my-collection-btn" id="my-collection-del-btn" data-my-review-no="\${myReviewNo}">
    					  	  <span class="icon">-</span>
    					  	  마이컬렉션에서 삭제하기
    					 	 </button>`;
    					const completeAdd = `<div class="add-complete">
    											마이컬렉션에 추가되었습니다! 
    											<a href="../mycollection/mycollection.jsp" class="add-complete-btn">마이컬렉션 확인하기 ></a>
    										</div>`
    	    			
    	    			$div.append(deleteBtn);
    	    			$div.append(completeAdd);
    				}
    				});
    		}
    	});
    	
    	$("#my-collection-div").on("click", "#my-collection-del-btn", function(){
    		if(confirm("마이컬렉션에서 앨범을 삭제하시겠습니까?")){
    			const myReviewNo = $(this).attr("data-my-review-no");
    			$.ajax({
    				type: 'get',
    				url: '../mycollection/delete-mycollection-item-by-review.jsp',
    				data: {reviewNo : myReviewNo},
    				dataType: 'text',
    				success: function(reviews){
    					$div = $("#my-collection-div").empty();
    					
    					const addBtn = ` <button class="my-collection-btn" id="my-collection-add-btn" data-my-review-no="\${myReviewNo}">
  					  	  <span class="icon">+</span>
  					  	  마이컬렉션에 추가하기
  					 	 </button>`;
  					 	 
		    			$div.append(addBtn);
    				}
    				});
    		}
    	})
    	
    	
    	/*
    		마이컬렉션 추가 모달 관련 이벤트 
    	*/
    	
    	// 마이컬렉션 모달창에서 예,아니오를 눌렀을떄 작업
    	$("#my-collection-modal-btn a").click(function(){
    		const isAddMyCollection = $(this).attr("data-is-add-my-collection");		
    		$("#review-form input[name='isAddMyCollection']").val(isAddMyCollection);
    		
    		$("#review-form").trigger("submit");
    	});
    	
    	
    	/*
    		----------------------------
    		거래내역 더보기 버튼 관련 이벤트 
    	*/
    	// album-info 태그에서 albumNo 획득 (이 작업을 위해 심어둔 태그)
    	// totalOrderRows를 ajax로 알아오기 
    	// nowOrderRows를 order 더보기 조회해올때마다 누적하기 
    	// order-view-btn 내에서, 만약 totalOrderRows == nowOrderRows 라면 더보기 버튼 없애기 
    	let orderViewClickCount = 0;

    	let totalOrderRows = $("#album-info").attr("data-total-order-rows");
    	let orderRows = $("#album-info").attr("data-order-rows");
    	let nowOrderRows = parseInt(orderRows); // 이 변수는 버튼클릭이벤트에서만 사용함 -> 버튼클릭이벤트는 첫 로딩시점에 조회된 구매데이터가 5개여야만 발생할 수 있는 이벤트임 (5개 미만이면 더보기버튼이 없음)
    	
    	/*
    		최근거래내역에서 더보기 버튼을 클릭했을 때 발생하는 이벤트 함수 정의 
    	*/
    	$("#order-view-btn").click(function(){
    		// 버튼 클릭 횟수 업데이트 
    		orderViewClickCount++;
    		
    		const offset = orderViewClickCount*orderRows;
    		
    		let $tableBody=$("#order-table-body");
    		
    		// order-history.jsp로 요청을 보내고, json 응답받기 
    		$.ajax({
				type: 'get',
				url: 'order-history.jsp',
				data: {albumNo: albumNo, offset: offset, rows: orderRows},
				dataType: 'json',
				success: function(orders){
					for(let order of orders){
						const isOpened = order.sale.isOpened == "t"? "중고" : "미개봉";
						
						// 날짜 문자열 포맷 변환
						let createdAt = new Date(order.createdAt);
						createdAt = createdAt.toISOString().split('T')[0];
						
						
						let content = `
		                    <tr>
		                        <td>\${isOpened}</td>
		                        <td>\${createdAt}</td>
		                        <td>\${order.price.toLocaleString()}원</td>
		                    </tr>`;
		                    
						$tableBody.append(content);
					}
					
					// 현재 주문데이터 행 개수 업데이트
					nowOrderRows += orders.length;
					// 현재 조회된 주문데이터 개수와 전체 주문데이터 개수가 같으면 더보기버튼 비활성화 
					console.log("nowOrderRows: " + nowOrderRows);
    			console.log("totalOrderRows: " + totalOrderRows);
					if (nowOrderRows == totalOrderRows){
						$("#order-view-btn").hide();
					}
				}
			});
    	});
    	
    	/*
		-------------------------
		리뷰 목록 더보기 버튼과 관련된 이벤트
		*/
		let reviewClickCount = 0;
		
		let totalReviewRows = $("#album-info").attr("data-total-review-rows");
		let reviewRows = parseInt($("#album-info").attr("data-review-rows"));
		let nowReviewRows = reviewRows;
		
		$("#review-view-btn").click(function(){
			
			reviewClickCount++;
			let offset = reviewClickCount*reviewRows;
			let $list = $("#review-list");
			
			// album-review-list.jsp로 요청을 보내고, json 응답받기 
			$.ajax({
				type: 'get',
				url: 'album-review-list.jsp',
				data: {albumNo: albumNo, offset: offset, rows: reviewRows},
				dataType: 'json',
				success: function(reviews){
					for(let review of reviews){
						// 날짜 문자열 포맷 변환
						let createdAt = new Date(review.createdAt);
						createdAt = createdAt.toISOString().split('T')[0];
						
						const myReview = (userNo == review.user.no) ? "mine" : "";
						
						let starContent = '';
						for (let i = 0 ; i < 5 ; i ++){
							if (i <= parseInt(review.rating)){
								starContent += ` <span class="star filled">★</span>`;
							} else if ( i - review.rating <= 0.5 ){
								starContent += ` <span class="star half">★</span>`;
							} else {
								starContent += ` <span class="star">★</span>`;
							}
						}
						
						let content = `
			                <div class="review-item \${myReview}">
			                    <div class="review-stars">
			                    	\${starContent}
			                    </div>
			                    <p class="review-text">\${review.content}</p>
			                    <div class="review-info">
			                        <span class="reviewer">\${review.user.nickname}</span>
			                        <span class="review-date">\${createdAt}</span>
			                    </div>
			                </div>`;
		                    
						$list.append(content);
					}
					
					// 현재 리뷰데이터 행 개수 업데이트
					nowReviewRows += reviews.length;
						console.log(nowReviewRows);
					if (nowReviewRows == totalReviewRows){
						$("#review-view-btn").hide();
					}
				}
			});
		})
	    	
    	/*
    		-------------------------
    			별점 등록 관련 이벤트 
    	*/
    	
    	// 별점 클릭 여부 상태 변수 (true면 별점 고정됨)
    	let reviewIsClicked = false;

    	// 현재 마우스로 설정된 별점 값 (0.5 단위)
    	let reviewFormStarValue = 0;
    		// 이미 해당 사용자가 작성한 리뷰가 존재하면, 그 별점 값을 변수에 저장 
    	if($("#my-review-rating").attr("data-my-review-rating") != undefined){
    		reviewFormStarValue = $("#my-review-rating").attr("data-my-review-rating");
    		reviewIsClicked = true; // 별점위에 커서 올라가도 동작하지 않도록 
    	}
    	console.log("reviewFormStarValue :" , reviewFormStarValue);

    	// 별 위에 마우스를 움직일 때 (hover 효과)
    	$('.review-form-star').on('mousemove', function(e) {
    	    if (reviewIsClicked) {
    	        return; // 클릭으로 고정된 상태면 hover 작동 중지
    	    }

    	    const offset = $(this).offset(); // 현재 별 요소의 화면상 위치 (왼쪽 기준 좌표)
    	    const width = $(this).width();   // 별의 가로 크기
    	    const x = e.pageX - offset.left; // 마우스가 별의 왼쪽 경계에서 얼마나 떨어졌는지

    	    // 현재 별의 상태 초기화
    	    $(this).removeClass('full half');
    	    // 왼쪽의 모든 별은 전체 별(full)로 채우기
    	    $(this).prevAll().addClass("full");

    	    // 마우스가 별의 오른쪽 절반에 위치하면 full 처리
    	    if (x > width / 2) {
    	        $(this).addClass('full');
    	        reviewFormStarValue = parseInt($(this).attr("data-order")); // 예: 1, 2, 3
    	    } else {
    	        $(this).addClass('half'); // 왼쪽 절반에 위치하면 반 별
    	        reviewFormStarValue = $(this).attr("data-order") - 0.5;
    	    }

    	    console.log("reviewFormStarValue: "+ reviewFormStarValue); // 현재 선택된 별점 로그 출력
    	});

    	// 마우스가 별을 벗어났을 때 (hover 해제)
    	$('.review-form-star').on('mouseleave', function() {
    	    if (reviewIsClicked) {
    	        return; // 클릭된 상태면 초기화하지 않음
    	    }

    	    // 현재 별과 왼쪽 별들의 스타일 초기화
    	    $(this).removeClass('full half');
    	    $(this).prevAll().removeClass("full");

    	    // 별점 값도 초기화
    	    reviewFormStarValue = 0;
    	});

    	// 별 클릭 시 별점 고정 또는 해제
    	$('.review-form-star').click(function() {
    	    if (!reviewIsClicked) {
    	        reviewIsClicked = true; // 클릭 상태로 전환 (고정)
    	        $("#rating-input").val(reviewFormStarValue); // 숨겨진 input에 값 저장
    	    } else {
    	        // 이미 클릭된 상태에서 다시 클릭하면 취소
    	        reviewIsClicked = false;
    	        $(this).siblings().removeClass('full half'); // 형제 별들 초기화
    	        $("#rating-input").val(0); // 값 초기화
    	    }
    	});
    	/*
			--------------------------
			리뷰 폼과 관련된 이벤트
		*/
    	
    	// 리뷰 제출 버튼 클릭시 발생하는 이벤트 
    	$("#review-form-btn").click(function(){
    		$form = $("#review-form");
    		if(reviewFormStarValue == 0){
    			alert("별점을 설정해주세요")
    			return false;
    		}
    		$("#my-collection-check-Modal").addClass("show");
    		return false;
    	});
    	
    	/* 
    		리뷰 수정 제출 버튼 클릭시 발생하는 이벤트 
    			- 해당 버튼을 감싸는 form 태그인 review-update-btn의 action 속성을 review-update.jsp로 설정 
    			- 사용자가 별점을 수정하지 않았을 떄도 원래의 별점이 폼전달값에 반영되어야하기 때문에, 제출 버튼을 눌렀을 때 별점값이 현재의 값으로 설정되도록 함
    			- review-edit.jsp로 요청이 전달 
    	*/
    	$("#review-update-btn").click(function(){
    		$("#my-review-form").attr("action","../review/review-update.jsp");
    		
    		$("#rating-input").val(reviewFormStarValue);
    		
    		if(reviewFormStarValue == 0){
    			alert("별점을 설정해주세요")
    			return false;
    		}
    		
    		return confirm("리뷰를 수정하시겠습니까?");
    	})
    	
    	/* 
    		리뷰 삭제 제출 버튼 클릭시 발생하는 이벤트 
    		- 해당 버튼을 감싸는 form 태그인 review-update-btn의 action 속성을 review-update.jsp로 설정 
    			- review-edit.jsp로 요청이 전달 
    	*/
    	$("#review-delete-btn").click(function(){
    		$("#my-review-form").attr("action","../review/review-delete.jsp");
    		
    		return confirm("리뷰를 삭제하시겠습니까?");
    	})
    	
    	/*
    		위시리스트 저장 버튼 클릭 시 발생하는 이벤트
    		- 버튼의 색상이 이미 채워져 있으면 -> AJAX로 위시리스트에서 삭제하고 fill 제거, 숫자 +1 
    		- 버튼의 색상이 채워져 있지 않으면 -> AJAX로 위시리스트에 추가하고 fill 추가, 숫자 +1
    		
    	*/
    	$("#wishlist-btn").click(function(){
    		const $icon = $(this).find("path")
    		
    		// 위시리스트에 추가되어 있지 않다면 
    		if($icon.attr("fill") == "#ffffff"){
    			
    		} else if ($icon.attr("fill") == "#628868"){ // 위시리스트에 이미 추가가 되어 있다면 
    			
    		}
    		
    	})
    	
    	/*
    		---------------
    		판매상품과 관련된 이밴트 
    	*/
    	
    	// 마지막 페이지인지 여부 확인하는 변수들
    	const totalSaleRows = parseInt($("#album-info").attr("data-total-sale-rows"));
    	let nowPage = 1;
    	const totalPages = Math.ceil(totalSaleRows/8);
    	
    	disabledBtn();
    	
    	const saleRows = 8;
    	let saleSort= "newest";
    	
    	// 버튼의 비활성 여부를 체크해서 설정해주는 함수 
    	function disabledBtn(){
    		if(totalPages == nowPage){
        		$("#sales-next-btn").prop("disabled", true);
        	} else {
        		$("#sales-next-btn").prop("disabled", false);
        	} 
    		if (nowPage == 1){
        		$("#sales-prev-btn").prop("disabled", true);
        	} else {
        		$("#sales-prev-btn").prop("disabled", false);
        	}
    	}
    	
    	/* 다음 상품 페이지네이션 버튼 클릭시 발생하는 이벤트
    		- product-grid의 모든 요소 제거하기
    		- condition의 offset 값을 변경해서 다시 요청 보내기 
    		- json으로 데이터를 받아서 append하기 
    		- 마지막페이지면 disabled 처리하기
    	*/
    	$("#sales-next-btn").click(function(){
    		// 마지막 페이지면 동작하지 않도록 설정 
    		if(nowPage == totalPages) {
    			return false;
    		}
    		// 오프셋 값 수정 
    		nowPage++;
    		const saleOffset = (nowPage-1)*saleRows;
    		
    		$.ajax({
				type: 'post',
				url: 'album-sale-list.jsp',
				data: {albumNo: albumNo, offset: saleOffset, rows: saleRows, sort: saleSort},
				dataType: 'json',
				success: function(sales){
					const $saleList =  $("#sales-list").empty();
					
					for(const sale of sales){
						const content = `
			                <div class="product-card">
			                	<a href="../sale/sale-detail.jsp?sno=\${sale.no}">
				                    <div class="product-image">
				                        <img src="\${sale.photoPath}" alt="\${sale.album.title}>">
				                    </div>
			                    </a>
			                    <h3 class="card-title">\${sale.album.title}</h3>
			                    <p class="card-price">\${sale.price.toLocaleString()}원</p>
		                	</div>`
		                
		                $saleList.append(content);	
					}
				}
    		});
    		
    		disabledBtn();
    	});
    	
   	/* 이전 상품 페이지네이션 버튼 클릭시 발생하는 이벤트
		- product-grid의 모든 요소 제거하기
		- condition의 offset 값을 변경해서 다시 요청 보내기 
		- json으로 데이터를 받아서 append하기 
		- 첫페이지면 disabled 처리하기
	*/
    	$("#sales-prev-btn").click(function(){
    		// 첫 페이지면 동작하지 않도록 설정 
    		if(nowPage == 1) {
    			return false;
    		}
    		// 오프셋 값 수정 
    		nowPage--;
    		const saleOffset = (nowPage-1)*8;
    		
    		$.ajax({
				type: 'post',
				url: 'album-sale-list.jsp',
				data: {albumNo: albumNo, offset: saleOffset, rows: saleRows, sort: saleSort},
				dataType: 'json',
				success: function(sales){
					console.log(sales);
					const $saleList =  $("#sales-list").empty();
					
					for(const sale of sales){
						const content = `
			                <div class="product-card">
			                	<a href="../sale/sale-detail.jsp?sno=\${sale.no}">
				                    <div class="product-image">
				                        <img src="\${sale.photoPath}" alt="\${sale.album.title}>">
				                    </div>
			                    </a>
			                    <h3 class="card-title">\${sale.album.title}</h3>
			                    <p class="card-price">\${sale.price.toLocaleString()}원</p>
		                	</div>`
		                
		                $saleList.append(content);	
					}
				}
    		});
    		
    		disabledBtn();
    	});
   	
   	/*
   		정렬 select창의 값이 변경되었을 때 발생하는 이벤트 
   			- saleSort의 값을 변경하여 요청보내기
   	*/
   	
   	$("#sale-sort-btn").change(function(){
   		saleSort = $(this).val();
   		
   		const saleOffset = 0;
   		nowPage = 1;
   		
   		$.ajax({
			type: 'post',
			url: 'album-sale-list.jsp',
			data: {albumNo: albumNo, offset: saleOffset, rows: saleRows, sort: saleSort},
			dataType: 'json',
			success: function(sales){
				console.log(sales);
				const $saleList =  $("#sales-list").empty();
				
				for(const sale of sales){
					const content = `
		                <div class="product-card">
		                	<a href="../sale/sale-detail.jsp?sno=\${sale.no}">
			                    <div class="product-image">
			                        <img src="\${sale.photoPath}" alt="\${sale.album.title}>">
			                    </div>
		                    </a>
		                    <h3 class="card-title">\${sale.album.title}</h3>
		                    <p class="card-price">\${sale.price.toLocaleString()}원</p>
	                	</div>`
	                
	                $saleList.append(content);	
				}
			}
		});
   		
   		disabledBtn();
   	});
    	
    
    
    	
    </script>
</body>

</html>