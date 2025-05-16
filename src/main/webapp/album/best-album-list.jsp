<%@page import="java.io.IOException"%>
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
		베스트 앨범 20 목록 페이지 
		조회되는 데이터 : 최소리뷰수 이상의 리뷰수를 가진 앨범을 평점순으로 조회 
		장르 필터링 기능 추가 
		무한스크롤 페이지 
		
		요청파라미터 : genreNo
		
		
	*/
	// 장르 전체 조회는 0으로 설정 
	int genreNo = StringUtils.strToInt(request.getParameter("genreNo"), 0);
	// 최소 리뷰수 정의 
	int minReviewCount = 5;
	
	// 한번에 가져오는 데이터의 개수 
	int rows = 20;
	
	// 베스트앨범 전체 데이터 개수 (###선) 
	int totalRows = 20;
	
	String sort = "rating";
	
	
	Map<String, Object> condition = new HashMap<>();
	condition.put("minReviewCount", minReviewCount);
	condition.put("offset", 0);
	condition.put("rows", rows);
	condition.put("sort", sort);
	
	List<Album> albums;
	if (genreNo == 0){
		AlbumMapper albumMapper = MybatisUtils.getMapper(AlbumMapper.class);
		albums = albumMapper.getAlbums(condition);		
	} else {
		condition.put("genreNo", genreNo);
		AlbumGenreMapper albumGenreMapper = MybatisUtils.getMapper(AlbumGenreMapper.class);
		albums = albumGenreMapper.getAlbumsByGenreNo(condition);	
	}
	
	// 첫 시점에서 가져와진 데이터 개수
	int nowRows = albums.size();
	
	
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
		data-genre-no="<%=genreNo %>"
		data-min-review-count="<%=minReviewCount%>"
		data-rows="<%=rows%>"
		data-sort="<%=sort%>"
		data-total-rows="<%=totalRows%>"
		data-now-rows="<%=nowRows%>"></div>
    <div class="container"> 
        <header class="album-list-header">
            <h1 class="album-list-title">베스트 앨범 <%=totalRows %>선</h1>
        </header>

        <!-- 장르 선택 헤더 -->
        <form method="get" action="best-album-list.jsp" id="form-filter">
	        <div class="list-header">
	            <select class="sort-select" style="width: 160px;" id="genre-btn" name="genreNo">
				  <option value="0" <%= 0 == genreNo ? "selected":"" %>>장르 전체</option>
<%
	for (Map.Entry<Integer, String> entry : genreMap.entrySet()) {
%>	
				  <option value="<%=entry.getKey() %>" <%=entry.getKey() == genreNo ?"selected":"" %>><%=entry.getValue() %></option>
<%
	};
%>
				</select>
	        </div>
        </form>

<%
	if(albums.isEmpty()){
%>
			<div style="text-align: center; height: 100px;">
				<div style="font-size: 20px; padding-bottom: 20px;]"> 베스트 앨범이 없습니다 </div>
				<div>* 베스트 앨범 기준 : 리뷰수 <%=minReviewCount %>개 이상</div>
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
		let rows = parseInt($("#list-info").attr("data-rows"));
		const totalRows = parseInt($("#list-info").attr("data-total-rows"));
		const nowRows = parseInt($("#list-info").attr("data-now-rows"));
		const minReviewCount = parseInt($("#list-info").attr("data-min-review-count"));
	
		// 정렬 선택창의 값이 변경될 때 발생하는 이벤트 핸들러 
        $("#genre-btn").change(function(){
        	$("#form-filter").trigger("submit");
        });
        
        /*
		무한스크롤로 페이지네이션 처리하는 이벤트 정의 
			- 최대 totalRows 만큼만 데이터를 조회해야함
				ㄴ offset값-> 현재 조회된 데이터의 개수 (jsp에서 넘겨주기 )
			- totalRows - offset이 rows보다 작으면 -> rows = totalRows - offset
			- offset >= totalRows면 동작하지 않도록 
		*/
		let offset = nowRows;
			
		// 만약 첫 시점 조회되는 데이터가 기본적으로 불러오는 데이터의 개수보다 작다면. 즉, 전체 데이터의 수가 rows보다 더 작음 
		let isLastAlbum;
		if(nowRows < rows){
			isLastAlbum = true;
		} else {
			isLastAlbum = false;
		}
		
	   $(function(){
		   const $target = $("#load-more-trigger")[0];
		   
		   /* IntersectionObserver
		   		이 API는 비동기적으로 target document가 뷰포트에 포함되는지 여부를 확인 
		   		기본 생성자
		   		const observer = new IntersectionObserver(callback, options);
		   		* 이 API는 callback 함수에 IntersectionObserverEntry 객체를 전달한다 -> 대상과 관련한 다양한 정보 반환
		   */
		   const observer = new IntersectionObserver((entryList) => {
			   
				// 불러온 데이터 수가 totalRows 보다 크거나 같고 || 모든 데이터를 조회했다면 -> 무한스크롤 이벤트 실행하지 않는다 
			   if(offset < totalRows && !isLastAlbum){ 
	    		  	const entry = entryList[0];
	    		  	if(entry.isIntersecting){ // true면 화면에 해당 태그가 보인다는 뜻 
	    		  		console.log("새로운 데이터를 불러옵니다")
	    		  		loadMoreAlbum();
	    		  	}
			   }
		   })
		   
		   observer.observe($target);
	   })
	   
	   function loadMoreAlbum() {
		   console.log(genreNo,  offset, rows, sort, minReviewCount);
		   $.ajax({
				type: 'get',
				url: 'get-album-best-list.jsp',
				data: {genreNo: genreNo, offset: offset, rows: rows, sort: sort, minReviewCount: minReviewCount},
				dataType: 'json',
				success: function(albums){
					const $albumList = $("#album-list");
					
					// 불러온 데이터의 개수가 0개면 -> 더이상 스크롤 이벤트가 발생하지 않아야함
					if(albums.length == 0){
						isLastAlbum = true;
					}
					
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
		    	   	
		    	   	//totalRows - offset이 rows보다 작으면 -> rows = totalRows - offset
		    	   	if(totalRows - offset < rows){
		    	   		rows = totalRows - offset;
		    	   	}
				}
		   });
	   }
		
	</script>
	
	

</body>

</html>