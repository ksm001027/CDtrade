<%@page import="kr.co.cdtrade.utils.Pagination"%>
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
		키워드별 검색 페이지
		페이지네이션 버튼으로 페이징 처리  
		요청 파라미터 : genreNo, sort, keyword, page
		
		요청처리 절차 
		-- 앨범카드에 별점 표시하기 
		-- 
	*/
	
	int genreNo = StringUtils.strToInt(request.getParameter("genreNo"), 0);
	int pageNo = StringUtils.strToInt(request.getParameter("pageNo"), 1);
	String sort = request.getParameter("genreNo") == null ? "newest" : request.getParameter("sort");
	String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");
	
	int rows = 12;
	
	Map<String, Object> condition = new HashMap<>();
	condition.put("genreNo", genreNo);
	condition.put("rows", rows);
	condition.put("sort", sort);
	condition.put("keyword", keyword);
	
	int totalRows = 0;
	Pagination pagination;
	
	List<Album> albums;
	if (genreNo == 0){
		AlbumMapper albumMapper = MybatisUtils.getMapper(AlbumMapper.class);
		
		totalRows = albumMapper.getTotalRows(condition);
		pagination = new Pagination(pageNo, totalRows, rows);
		condition.put("offset", pagination.getOffset());
		
		albums = albumMapper.getAlbums(condition);		
	} else {
		condition.put("genreNo", genreNo);
		AlbumGenreMapper albumGenreMapper = MybatisUtils.getMapper(AlbumGenreMapper.class);
		
		totalRows = albumGenreMapper.getTotalRows(condition);
		pagination = new Pagination(pageNo, totalRows, rows);
		condition.put("offset", pagination.getOffset());

		albums = albumGenreMapper.getAlbumsByGenreNo(condition);	
	}
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
            <h1 class="album-list-title"><%= keyword %>에 대한 검색결과입니다.</h1>
        </header>
        
   
        <!-- 정렬 헤더 -->
        <form method="get" action="keyword-album-list.jsp" id="form-filter">
        	<input type="hidden" name="keyword" value=<%= keyword %>>
        	<input type="hidden" name="pageNo" value="1">
	        <div class="list-header">
	            <div class="total-items">전체 <%=totalRows %>개</div>
	            <div>
		            <!--  장르 필터링 -->
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
					<!-- 정렬 버튼 -->
		            <select class="sort-select" id="sort-btn" name="sort">
					  <option value="newest" <%="newest".equals(sort)?"selected":"" %>>최신발매순</option>
					  <option value="price-desc" <%="price-desc".equals(sort)?"selected":"" %>>높은가격순</option>
					  <option value="price-asc" <%="price-asc".equals(sort)?"selected":"" %>>낮은가격순</option>
					  <option value="rating" <%="rating".equals(sort)?"selected":"" %>>평점순</option>
					</select>
		        </div>
	            </div>
        </form>

<%
	if(albums.isEmpty()){
%>
			<div style="text-align: center; height: 100px;">
				검색 결과가 없습니다
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

<%
	if (totalRows != 0){
%>
		<!-- 페이지네이션 버튼 -->
	  	 <div class="pagination">
		    <button class="prev-next <%=pagination.getBeginPage()==1 ? "disabled" : "" %>" data-page-no=<%=pagination.getBeginPage() - 1 %>><</button>
<%
	for (int i = pagination.getBeginPage(); i <= pagination.getEndPage(); i++) {
%>
		    <button data-page-no=<%=i %> class="<%= pageNo == i ? "active" : "" %>"><%=i %></button>
<%
	}
%>
		    <button class="prev-next <%=pagination.getEndPage() == pagination.getTotalPages()? "disabled" : "" %>" data-page-no=<%=pagination.getEndPage() + 1 %>>></button>
		 </div>
<%
	}
%>
		 
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
		
     	// 장르 선택창의 값이 변경될 때 발생하는 이벤트 핸들러 
        $("#genre-btn").change(function(){
        	$("#form-filter").trigger("submit");
        });
     	
     	// 페이지네이션 버튼이 클릭될 때 발생하는 이벤트 핸들러
     	$(".pagination button").click(function(){
     		const pageNo = $(this).attr("data-page-no");
     		
     		$("#form-filter input[name=pageNo]").val(pageNo);
     		$("#form-filter").trigger("submit");
     	})
     	
        
		
	</script>
	
	

</body>

</html>