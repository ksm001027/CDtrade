<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@ page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page import="kr.co.cdtrade.mapper.ReviewMapper"%>
<%@ page import="kr.co.cdtrade.vo.Review"%>
<%@ page import="java.util.List"%>

<%
// 1. 요청파라미터 조회하기
int pageNo = StringUtils.strToInt(request.getParameter("page"), 1);
int genreNo = StringUtils.strToInt(request.getParameter("genreNo"), 0);
String keyword = request.getParameter("keyword");

// 디버깅: 요청 파라미터 출력
System.out.println("=== Review API Debug ===");
System.out.println("Page No: " + pageNo);
System.out.println("Genre No: " + genreNo);
System.out.println("Keyword: " + keyword);

// 2. Mapper 인터페이스의 구현객체를 획득한다.
ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);

// 3. 총 데이터갯수를 조회한다.
int totalRows = 0;
if (genreNo > 0) {
    totalRows = reviewMapper.getTotalRowsByGenre(genreNo);
} else if (keyword != null && !keyword.isBlank()) {
    totalRows = reviewMapper.getTotalRowsByKeyword(keyword);
} else {
    totalRows = reviewMapper.getTotalRows();
}

// 디버깅: 총 로우 수 출력
System.out.println("Total Rows: " + totalRows);

// 페이징 처리
int offset = (pageNo - 1) * 10;
int rows = 10;

// 디버깅: 오프셋 및 로우 수 출력
System.out.println("Offset: " + offset);
System.out.println("Rows per Page: " + rows);

List<Review> reviews = null;
if (genreNo > 0) {
    reviews = reviewMapper.getReviewsByGenreWithPage(genreNo, offset, rows);
} else if (keyword != null && !keyword.isBlank()) {
    reviews = reviewMapper.searchReviewsWithPage(keyword, offset, rows);
} else {
    reviews = reviewMapper.getReviewsByPage(offset, rows);
}

// 디버깅: 리뷰 수 출력
System.out.println("Reviews Found: " + (reviews != null ? reviews.size() : "null"));
%>

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
<div class="no-more-reviews" style="text-align:center; padding:20px;">
    <p>더 이상 로드할 리뷰가 없습니다.</p>
</div>
<%
}
%>