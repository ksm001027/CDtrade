<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@ page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page import="kr.co.cdtrade.mapper.GenreMapper"%>
<%@ page import="kr.co.cdtrade.mapper.ReviewMapper"%>
<%@ page import="kr.co.cdtrade.vo.Genre"%>
<%@ page import="kr.co.cdtrade.vo.Review"%>
<%@ page import="java.util.List"%>

<%
// 1. 요청파라미터 조회하기
int genreNo = StringUtils.strToInt(request.getParameter("genreNo"), 0);
String keyword = request.getParameter("keyword");
int pageNo = 1; // 초기 페이지는 1로 고정

// 2. Mapper 인터페이스의 구현객체를 획득한다.
GenreMapper genreMapper = MybatisUtils.getMapper(GenreMapper.class);
ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
List<Review> reviews = null;
// 3. 장르목록을 조회한다.
List<Genre> genres = genreMapper.getAllGenres();

reviews = reviewMapper.getReviewsByPage(0, 1);
System.out.println(reviews);
// 4. 최초 리뷰목록을 조회한다.
// 4.1. 총 데이터갯수를 조회한다.
int totalRows = 0;
if (genreNo > 0) {
    totalRows = reviewMapper.getTotalRowsByGenre(genreNo);
} else if (keyword != null && !keyword.isBlank()) {
    totalRows = reviewMapper.getTotalRowsByKeyword(keyword);
} else {
    totalRows = reviewMapper.getTotalRows();
}

// 4.2. 첫 페이지의 리뷰목록을 조회한다.
int offset = 0;
int rows = 10; // 페이지당 10개 로드


if (genreNo > 0) {
    reviews = reviewMapper.getReviewsByGenreWithPage(genreNo, offset, rows);
} else if (keyword != null && !keyword.isBlank()) {
    reviews = reviewMapper.searchReviewsWithPage(keyword, offset, rows);
} else {
    reviews = reviewMapper.getReviewsByPage(offset, rows);
    	System.out.println(reviews);
    
    for(Review review : reviews){
    	System.out.println(review.getNo());
    }
}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>앨범리뷰 리스트</title>
    <link rel="stylesheet" href="resources/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .loading { text-align: center; padding: 20px; display: none; }
        .loading-spinner {
            display: inline-block;
            width: 40px;
            height: 40px;
            border: 3px solid rgba(98, 136, 104, 0.3);
            border-radius: 50%;
            border-top-color: var(--main-color);
            animation: spin 1s ease-in-out infinite;
        }
        @keyframes spin { to { transform: rotate(360deg); } }
    </style>
</head>
<body>
    <div class="review-list-layout">
        <div class="review-list-header">
            <div class="review-list-filter">
                <div class="review-genre-icons">
                    <a href="review-list.jsp" class="filter-button <%=genreNo == 0 ? "active" : ""%>">전체</a>
                    <%
                    for (Genre genre : genres) {
                    %>
                    <a href="review-list.jsp?genreNo=<%=genre.getNo()%>" 
                       class="filter-button <%=genreNo == genre.getNo() ? "active" : ""%>" 
                       title="<%=genre.getName()%>">
                        <%=genre.getName()%>
                    </a>
                    <%
                    }
                    %>
                </div>
            </div>
            <div class="search-bar" style="width: 300px;">
                <form action="review-list.jsp" method="get" id="search-form">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" class="search-input" name="keyword" 
                           value="<%=keyword != null ? keyword : ""%>" 
                           placeholder="앨범명, 가수명, 소속사명 등">
                </form>
            </div>
        </div>
        <div class="review-genre-count">
            전체 <b><%=StringUtils.commaWithNumber(totalRows)%></b>개
        </div>
        <hr>
        <div class="review-block-list" id="review-container">
            <%
            if (reviews != null && !reviews.isEmpty()) {
                for (Review review : reviews) {
            %>
            <div class="review-block">
                <div class="review-block-header">
                    <div class="review-block-album">
                        <i class="fas fa-user-circle"></i>
                        <%=review.getUser().getNickname() != null ? review.getUser().getNickname() : review.getUser().getName()%>
                    </div>
                    <div class="review-block-rating">
                        <div class="stars">
                            <%=StringUtils.toStar(review.getRating())%>
                            <%=review.getRating()%>
                        </div>
                    </div>
                </div>
                <div class="review-block-reviews"><%=review.getContent()%></div>
            </div>
            <%
                }
            } else {
            %>
            <div class="no-reviews-message" style="text-align: center; padding: 50px 0;">
                <p>등록된 리뷰가 없습니다.</p>
            </div>
            <%
            }
            %>
        </div>

        <!-- 로딩 표시자 -->
        <div class="loading">
            <div class="loading-spinner"></div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            let currentPage = 1;
            let loading = false;
            let allLoaded = false;
            const totalRows = <%=totalRows%>;
            const rowsPerPage = 10;
            const totalPages = Math.ceil(totalRows / rowsPerPage);
            
            console.log('Initial Page Load Debug:');
            console.log('Total Rows:', totalRows);
            console.log('Rows per Page:', rowsPerPage);
            console.log('Total Pages:', totalPages);
            
            window.addEventListener('scroll', function() {
                if (loading || allLoaded) return;
                
                const endOfPage = window.innerHeight + window.pageYOffset >= document.body.offsetHeight - 500;
                
                if (endOfPage) {
                    loadMoreReviews();
                }
            });
            
            function loadMoreReviews() {
                loading = true;
                currentPage++;
                
                console.log('Loading More Reviews:');
                console.log('Current Page:', currentPage);
                console.log('Total Pages:', totalPages);
                
                if (currentPage > totalPages) {
                    allLoaded = true;
                    return;
                }
                
                document.querySelector('.loading').style.display = 'block';
                
                const xhr = new XMLHttpRequest();
                xhr.open('GET', 'review-api.jsp?page=' + currentPage 
                    + '<%=genreNo > 0 ? "&genreNo=" + genreNo : ""%>'
                    + '<%=keyword != null && !keyword.isEmpty() ? "&keyword=" + keyword : ""%>',
                    true);

                xhr.onload = function() {
                    if (this.status === 200) {
                        const reviewContainer = document.getElementById('review-container');
                        reviewContainer.insertAdjacentHTML('beforeend', this.responseText);

                        loading = false;
                        document.querySelector('.loading').style.display = 'none';
                    }
                };

                xhr.send();
            }
        });
        
    </script>
</body>
</html>