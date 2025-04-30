<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.cdtrade.vo.Order"%>
<%@page import="kr.co.cdtrade.mapper.OrderMapper"%>
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
		앨범 상세 페이지 
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
			- 페이지네이션도 처리해야함 -> 고민해보기
		4. albumNo로 리뷰 목록 조회 및 표현
			- 사용자 본인의 댓글이면 수정, 삭제버튼 추가 
			- 리뷰 더보기 누를때마다 리뷰 더 불러오기 -> AJAX로 처리 
		5. 리뷰 등록 시 review-add.jsp로 요청 폼 보내기 
		6. 위시리스트 테이블에 해당 albumNo, 해당 사용자의 userNo를 가진 행이 존재유무에 따라 위시리스트 버튼 스타일 설정 
		
		++ 위시리스트 찜 개수 표현할지 말지 결정 
		++ 절반 하트 구현하기 
		++ 장르 클릭하면 장르별 앨범 목록 페이지로 이동 
	*/
	
	// int albumNo = StringUtils.strToInt(request.getParameter("albumNo"));
	int albumNo = 100;
	
	// 앨범 상세 정보 조회 
	AlbumMapper albumMapper = MybatisUtils.getMapper(AlbumMapper.class);
	Album album = albumMapper.getAlbumByNo(albumNo);
	
	// 앨범의 장르 조회
	AlbumGenreMapper albumGenreMapper = MybatisUtils.getMapper(AlbumGenreMapper.class);
	List<Integer> genres = albumGenreMapper.getGenreNosByAlbumNo(albumNo);
	
	// 앨범 거래 내역 조회 
	int orderOffset = 0;
	int rows = 5;
	
	OrderMapper orderMapper = MybatisUtils.getMapper(OrderMapper.class);
	List<Order> orders = orderMapper.getOrdersByAlbumNo(albumNo, 0, 5);
	// 조회된 거래 내역 개수
	int nowOrderRows = orders.size();
	
	// 앨범 거래 내역 전체 행 개수 조회 
	Map<String, Object> condition = new HashMap<>();
	condition.put("albumNo", albumNo);
	int totalOrderRows = orderMapper.getTotalRows(condition);
	
	// 전체 거래내역 행 개수와 조회된 거래내역 행 개수를 비교해서, 모든 데이터가 조회된건지 식별하는 변수 정의하기 
	boolean hasMoreOrders = (nowOrderRows == totalOrderRows) ? false : true;
	
	
	// 최근거래가 변수 정의 
	int recentPrice = orders.size() != 0? orders.get(0).getPrice() : 0;
	
	
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
	<!-- 
		페이지가 로딩되는 시점에 자바스크립트에서 albumNo를 알고있어야함 -> 화면에 나타나지 않는 태그에 데이터 심어두고, 자바스크립트에서 가져오기 
	 -->
	<div id="album-info" data-album-no="<%=albumNo %>"></div>
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
                    <div class="share-buttons">
                        <button class="icon-button">
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

                    <button class="purchase-btn">판매</button>

                    <div class="recent-trades">
                        <h3>최근거래</h3>
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

        <!-- 추천 상품 목록 -->
        <div class="recommended-products">
            <h2 class="section-title">판매 상품 목록</h2>
            <div class="section-header">
                <div class="product-count">전체 앨범 120개</div>
                <button class="sort-button">
                    정렬
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                            stroke-linejoin="round" />
                    </svg>
                </button>
            </div>

            <div class="product-grid">
                <!-- 상품 1 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://image.yes24.com/goods/92147169/XL" alt="BLACKPINK Album">
                    </div>
                    <h3 class="card-title">BLACKPINK 2nd VINYL LP (BORN PINK)</h3>
                    <p class="card-price">95,000원</p>
                </div>

                <!-- 상품 2 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://image.yes24.com/goods/92147169/XL" alt="BLACKPINK Album">
                    </div>
                    <h3 class="card-title">BLACKPINK 2nd VINYL LP (BORN PINK)</h3>
                    <p class="card-price">90,000원</p>
                </div>

                <!-- 상품 3 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://image.yes24.com/goods/92147169/XL" alt="BLACKPINK Album">
                    </div>
                    <h3 class="card-title">BLACKPINK 2nd VINYL LP (BORN PINK)</h3>
                    <p class="card-price">92,000원</p>
                </div>

                <!-- 상품 4 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://image.yes24.com/goods/92147169/XL" alt="BLACKPINK Album">
                    </div>
                    <h3 class="card-title">BLACKPINK 2nd VINYL LP (BORN PINK)</h3>
                    <p class="card-price">88,000원</p>
                </div>
            </div>
        </div>

        <!-- 앨범 리뷰 섹션 -->
        <div class="album-reviews">
        	<form>
        	</form>
            <div class="review-header">
                <h2>앨범리뷰</h2>
                <div class="review-stats">
                    <div class="stars">
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                    </div>
                    <div class="review-count">전체 2424개</div>
                </div>
            </div>

            <div class="review-write">
                <textarea placeholder="리뷰를 작성해주세요" class="review-textarea"></textarea>
                <button class="review-submit">등록</button>
            </div>
            

            <div class="review-list">
                <!-- 리뷰 아이템 1 -->
                <div class="review-item">
                    <div class="review-stars">
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                    </div>
                    <p class="review-text">가격 왜케 비싸? 쨌더니 18곡이네 ^^</p>
                    <div class="review-info">
                        <span class="reviewer">kurt1967</span>
                        <span class="review-date">2022-09-08</span>
                    </div>
                </div>

                <!-- 리뷰 아이템 2 -->
                <div class="review-item">
                    <div class="review-stars">
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star">★</span>
                        <span class="star">★</span>
                    </div>
                    <p class="review-text">내가 니이가 든 걸까? 맨 정신에 들어서 그런 걸까? 별로다.</p>
                    <div class="review-info">
                        <span class="reviewer">에로이카</span>
                        <span class="review-date">2023-01-14</span>
                    </div>
                </div>

                <!-- 리뷰 아이템 3 -->
                <div class="review-item">
                    <div class="review-stars">
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                    </div>
                    <p class="review-text">이런앨범은 행복합니다</p>
                    <div class="review-info">
                        <span class="reviewer">백수희</span>
                        <span class="review-date">2022-09-08</span>
                    </div>
                </div>

                <!-- 리뷰 아이템 4 -->
                <div class="review-item">
                    <div class="review-stars">
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                    </div>
                    <p class="review-text">긴 말 필요없이 명반이라고 생각합니다.<br>조슈일 시가 1시간 넘는 이야기를 준비했을 줄이야..<br>울해에 들은것중 완성도 있는
                        작품이었어요.</p>
                    <div class="review-info">
                        <span class="reviewer">hdjs.han1499</span>
                        <span class="review-date">2022-11-30</span>
                    </div>
                </div>
            </div>

            <button class="more-reviews">더보기</button>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
    	let orderViewClickCount = 0;
    	
    	// album-info 태그에서 albumNo 획득 (이 작업을 위해 심어둔 태그)
    	// totalOrderRows를 ajax로 알아오기 
    	// nowOrderRows를 order 더보기 조회해올때마다 누적하기 
    	// order-view-btn 내에서, 만약 totalOrderRows == nowOrderRows 라면 더보기 버튼 없애기 
    	let totalOrderRows = 0;
    	let nowOrderRows = 5; // 이 변수는 버튼클릭이벤트에서만 사용함 -> 버튼클릭이벤트는 첫 로딩시점에 조회된 구매데이터가 5개여야만 발생할 수 있는 이벤트임 (5개 미만이면 더보기버튼이 없음)
    	
    	let albumNo = parseInt($("#album-info").attr("data-album-no"));
    	
    	$.ajax({
			type: 'get',
			url: 'order-history-total-rows.jsp',
			data: {albumNo: albumNo},
			dataType: 'text',
			success: function(totalRows){
				console.log("totalRows" + totalRows);
				totalOrderRows = parseInt(totalRows);
				console.log("totalOrderRows" + totalOrderRows);
				
			}
		});
    	
    	
    	/*
    		최근거래내역에서 더보기 버튼을 클릭했을 때 발생하는 이벤트 함수 정의 
    	*/
    	$("#order-view-btn").click(function(){
    		// 버튼 클릭 횟수 업데이트 
    		orderViewClickCount++;
    		
    		const offset = orderViewClickCount*5;
    		
    		let $tableBody=$("#order-table-body");
    		
    		// order-history.jsp로 요청을 보내고, json 응답받기 
    		$.ajax({
				type: 'get',
				url: 'order-history.jsp',
				data: {albumNo: albumNo, offset: offset, rows: 5},
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
    </script>
</body>

</html>