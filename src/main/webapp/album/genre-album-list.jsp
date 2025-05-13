<%@page import="kr.co.cdtrade.mapper.AlbumGenreMapper"%>
<%@page import="kr.co.cdtrade.vo.Album"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.AlbumMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 
	/*
		장르별 검색 페이지
		무한스크롤 페이지 
		요청 파라미터 : genreNo, sort
		
		요청처리 절차 
		-- 앨범카드에 별점 표시하기 
		-- 
	*/
	
	int genreNo = StringUtils.strToInt(request.getParameter("genreNo"), 0);
	String sort = request.getParameter("genreNo") == null ? "newest" : request.getParameter("sort");
	
	int rows = 12;
	
	AlbumGenreMapper albumGenreMapper = MybatisUtils.getMapper(AlbumGenreMapper.class);
	Map<String, Object> condition = new HashMap<>();
	condition.put("genreNo", genreNo);
	condition.put("offset", 0);
	condition.put("rows", rows);
	condition.put("sort", sort);
	
	List<Album> albums = albumGenreMapper.getAlbumsByGenreNo(condition);
	
	// 전체 데이터의 개수 구하기 
	Map<String, Object> rowsCondition = new HashMap<>();
	rowsCondition.put("genreNo", genreNo);
	int totalRows = albumGenreMapper.getTotalRows(rowsCondition);
%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>앨범 목록</title>
    <link rel="stylesheet" href="../resources/css/common.css" />
</head>

<body>
	<%@ include file="../common/nav.jsp" %>
	
	<div id="list-info" 
		data-genre-no="<%=genreNo%>"
		data-rows="<%=rows%>"
		data-sort="<%=sort%>"
		data-total-rows="<%=totalRows %>"></div>
    <div class="container">
        <header class="album-list-header">
            <h1 class="album-list-title"><%= GenreMappingUtils.GENRE_NO_TO_NAME.get(genreNo) %>에 대한 검색결과입니다.</h1>
        </header>

        <!-- 목록 헤더 -->
        <form method="get" action="genre-album-list.jsp" id="form-filter">
        	<input type="hidden" name="genreNo" value="<%=genreNo%>">
	        <div class="list-header">
	            <div class="total-items">전체 <%=totalRows %>개</div>
	            <select class="sort-select" id="sort-btn" name="sort">
				  <option value="newest" <%="newest".equals(sort)?"selected":"" %>>최신발매순</option>
				  <option value="price-desc" <%="price-desc".equals(sort)?"selected":"" %>>높은가격순</option>
				  <option value="price-asc" <%="price-asc".equals(sort)?"selected":"" %>>낮은가격순</option>
				  <option value="rating" <%="rating".equals(sort)?"selected":"" %>>평점순</option>
				</select>
	        </div>
        </form>

<%
	if(albums.isEmpty()){
%>
			<div style="text-align: center; height: 100px;">
				해당 장르의 앨범이 없습니다 
			</div>
			
<%
	} else {
%>
			<div class="album-grid" id="album-list">
<%
		for(Album album : albums) {
			double reviewRating = album.getAvgRating();
%>
            <div class="album-card">
            	<a href="detail.jsp?albumNo=<%=album.getNo()%>">
	                <img src="<%= album.getCoverImageUrl() %>" alt="<%= album.getTitle() %>" class="album-image">
            	</a>
                <div class="album-info">
                    <h3 class="album-title"><%= album.getTitle() %></h3>
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
            			 <span class="rating-score"><%= album.getReviewCount() == 0 ? "" :album.getAvgRating() %> (<%= album.getReviewCount() %>)</span>
                    </div>
                    <div class="album-price-label">구매가</div>
                    <div class="album-price"><%= album.getAvgOrderPrice() != 0 ? StringUtils.commaWithNumber(album.getAvgOrderPrice())+ "원" : "-" %></div>
                </div>
            </div>
<%
		}
%>
        </div>
<%
	}
%>
	  	<div id="load-more-trigger"></div>
    </div>
    
   	<%@ include file="../common/footer.jsp" %>
    
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
		const genreNo = parseInt($("#list-info").attr("data-genre-no"));
		const sort = $("#list-info").attr("data-sort");
		const rows = parseInt($("#list-info").attr("data-rows"));
		const totalRows = parseInt($("#list-info").attr("data-total-rows"));
		
	
		// 정렬 선택창의 값이 변경될 때 발생하는 이벤트 핸들러 
        $("#sort-btn").change(function(){
        	$("#form-filter").trigger("submit");
        });
        
		
		/*
			무한스크롤로 페이지네이션 처리하는 이벤트 정의 
		*/
       let offset = rows;
		
       $(function(){
    	   const $target = $("#load-more-trigger")[0];
    	   
    	   /* IntersectionObserver
    	   		이 API는 비동기적으로 target document가 뷰포트에 포함되는지 여부를 확인 
    	   		기본 생성자
    	   		const observer = new IntersectionObserver(callback, options);
    	   		* 이 API는 callback 함수에 IntersectionObserverEntry 객체를 전달한다 -> 대상과 관련한 다양한 정보 반환
    	   */
    	   const observer = new IntersectionObserver((entryList) => {
    		   if(offset < totalRows){ // 불러온 데이터 수가 totalRows 보다 크다면 더이상 함수를 호출하지 않는다 
	    		  	const entry = entryList[0];
	    		  	if(entry.isIntersecting){ // true면 화면에 해당 태그가 보인다는 뜻 
	    		  		// 작업 수행 
	    		  		console.log("새로운 데이터를 불러옵니다")
	    		  		loadMoreAlbum();
	    		  	}
    		   }
    	   })
    	   
    	   observer.observe($target);
       })
       
       function loadMoreAlbum() {
    	   console.log(genreNo,  offset, rows, sort)
    	   $.ajax({
				type: 'get',
				url: 'get-album-genre-list.jsp',
				data: {genreNo: genreNo, offset: offset, rows: rows, sort: sort},
				dataType: 'json',
				success: function(albums){
					const $albumList = $("#album-list");
					
					for (let album of albums ){
						const albumPrice = album.avgOrderPrice != 0 ? album.avgOrderPrice.toLocaleString() + "원" : "-";
						const ratingScore = (album.reviewCount == 0 ? "" : album.avgRating) + "(" + album.reviewCount + ")";
						
						let starContent = "";
						for (let i = 1 ; i <= 5 ; i ++){
							if (i <= parseInt(album.avgRating)){
								starContent += `<span class="star filled">★</span>`;
							} else if ( i - album.avgRating <= 0.5 ){
								starContent += `<span class="star half">★</span>`;
							} else {
								starContent += `<span class="star">★</span>`;
							}
						}
						
						const content = `
							 <div class="album-card">
			            	<a href="detail.jsp?albumNo=\${album.no}">
				                <img src="\${album.coverImageUrl}" alt="\${album.title}" class="album-image">
			            	</a>
			                <div class="album-info">
			                    <h3 class="album-title">\${album.title}</h3>
			                     <div class="review-stars">
			            			\${starContent}
			            			 <span class="rating-score">\${ratingScore}</span>
			                    </div>
			                    <div class="album-price-label">구매가</div>
			                    <div class="album-price">\${albumPrice}</div>
			                </div>
			            </div>`;
			            
			            $albumList.append(content);
					}
	    	   	offset += rows;
				}
    	   });
       }
	</script>
	
	

</body>

</html>