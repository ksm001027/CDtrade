<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@ page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page import="kr.co.cdtrade.mapper.GenreMapper"%>
<%@ page import="kr.co.cdtrade.mapper.ReviewMapper"%>
<%@ page import="kr.co.cdtrade.vo.Genre"%>
<%@ page import="kr.co.cdtrade.vo.Review"%>
<%@ page import="java.util.List"%>
<!-- 네비게이션 바 -->
<%@include file="common/nav.jsp" %>
<%
// AJAX 요청인지 확인
String ajaxParam = request.getParameter("ajax");
if (ajaxParam != null && ajaxParam.equals("true")) {
	// AJAX 요청 처리 로직
	int pageNo = StringUtils.strToInt(request.getParameter("page"), 1);
	int genreNo = StringUtils.strToInt(request.getParameter("genreNo"), 0);
	String keyword = request.getParameter("keyword");

	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);

	// 페이징 처리
	int offset = (pageNo - 1) * 10;
	int rows = 10;

	List<Review> moreReviews = null;
	if (genreNo > 0) {
		moreReviews = reviewMapper.getReviewsByGenreWithPage(genreNo, offset, rows);
	} else if (keyword != null && !keyword.isBlank()) {
		moreReviews = reviewMapper.searchReviewsWithPage(keyword, offset, rows);
	} else {
		moreReviews = reviewMapper.getReviewsByPage(offset, rows);
	}

	// AJAX 요청에 대한 응답 렌더링
	if (moreReviews != null && !moreReviews.isEmpty()) {
		for (Review review : moreReviews) {
%>
<div class="review-block"
	onclick="location.href='album-detail.jsp?albumNo=<%=review.getAlbum().getNo()%>'">
	<div class="review-album-cover">
		<img
			src="${pageContext.request.contextPath}/<%=review.getAlbum().getCoverImageUrl()%>"
			alt="앨범 커버"
			onerror="this.src='${pageContext.request.contextPath}/resources/images/default-album.jpg'">
	</div>
	<div class="review-content">
		<div class="review-album-info">
			<h3 class="album-title"><%=review.getAlbum().getTitle()%></h3>
			<p class="album-artist"><%=review.getAlbum().getArtistName()%></p>
		</div>
		<div class="review-user-info">
			<i class="fas fa-user-circle"></i> <span class="user-name"><%=review.getUser().getNickname() != null ? review.getUser().getNickname() : review.getUser().getName()%></span>
		</div>
		<div class="review-rating">
			<div class="stars">
				<%=StringUtils.toStar(review.getRating())%>
				<span class="rating-number"><%=review.getRating()%></span>
			</div>
		</div>
		<div class="review-text"><%=review.getContent()%></div>
	</div>
</div>
<%
}
}

// 추가 로드할 내용이 없으면 빈 문자열 반환
if (moreReviews == null || moreReviews.isEmpty()) {
out.print("");
}

// AJAX 요청의 경우 더 이상 진행하지 않음
return;
}

// 일반 페이지 로드 로직
int genreNo = StringUtils.strToInt(request.getParameter("genreNo"), 0);
String keyword = request.getParameter("keyword");

GenreMapper genreMapper = MybatisUtils.getMapper(GenreMapper.class);
ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);

// 장르 목록 조회
List<Genre> genres = genreMapper.getAllGenres();

// 총 데이터 수 계산
int totalRows = 0;
if (genreNo > 0) {
totalRows = reviewMapper.getTotalRowsByGenre(genreNo);
} else if (keyword != null && !keyword.isBlank()) {
totalRows = reviewMapper.getTotalRowsByKeyword(keyword);
} else {
totalRows = reviewMapper.getTotalRows();
}

// 초기 리뷰 로드
int offset = 0;
int rows = 10;
List<Review> reviews = null;

if (genreNo > 0) {
reviews = reviewMapper.getReviewsByGenreWithPage(genreNo, offset, rows);
} else if (keyword != null && !keyword.isBlank()) {
reviews = reviewMapper.searchReviewsWithPage(keyword, offset, rows);
} else {
reviews = reviewMapper.getReviewsByPage(offset, rows);
}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>앨범리뷰 리스트</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/common.css">
<link rel="stylesheet" href="resources/css/review-styles.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
	<div class="review-list-layout">
		<div class="review-list-header">
			<div class="review-list-filter">
				<!-- 장르 선택 버튼 -->
				<button id="genre-selector" class="genre-selector-btn">
					장르 선택 <i class="fas fa-chevron-down"></i>
				</button>

				<!-- 장르 선택 모달 -->
				<div id="genre-modal" class="genre-modal">
					<div class="genre-modal-content">
						<div class="genre-modal-header">
							<h3>장르 선택</h3>
							<button class="genre-modal-close">&times;</button>
						</div>
						<div class="genre-modal-body">
							<ul class="genre-list">
								<li><a href="review-list.jsp"
									class="genre-item <%=genreNo == 0 ? "active" : ""%>">전체</a></li>
								<%
								for (Genre genre : genres) {
								%>
								<li><a href="review-list.jsp?genreNo=<%=genre.getNo()%>"
									class="genre-item <%=genreNo == genre.getNo() ? "active" : ""%>">
										<%=genre.getName()%>
								</a></li>
								<%
								}
								%>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<!-- 현재 선택된 장르 표시 -->
			<div class="selected-genre">
				<%
				if (genreNo > 0) {
					for (Genre genre : genres) {
						if (genre.getNo() == genreNo) {
				%>
				현재 장르: <strong><%=genre.getName()%></strong>
				<%
				break;
				}
				}
				} else {
				%>
				현재 장르: <strong>전체</strong>
				<%
				}
				%>
			</div>

			<!-- 검색바 -->
			<div class="search-bar" style="width: 300px;">
				<form action="review-list.jsp" method="get" id="search-form">
					<i class="fas fa-search search-icon"></i> <input type="text"
						class="search-input" name="keyword"
						value="<%=keyword != null ? keyword : ""%>"
						placeholder="앨범명, 가수명, 소속사명 등">
				</form>
			</div>
		</div>

		<!-- 총 데이터 수 -->
		<div class="review-genre-count">
			전체 <b><%=StringUtils.commaWithNumber(totalRows)%></b>개
		</div>
		<hr>

		<!-- 리뷰 컨테이너 -->
		<div class="review-block-list" id="review-container">
			<%
			if (reviews != null && !reviews.isEmpty()) {
				for (Review review : reviews) {
			%>
			<div class="review-block"
				onclick="location.href='album-detail.jsp?albumNo=<%=review.getAlbum().getNo()%>'">
				<div class="review-album-cover">
					<img src="<%=review.getAlbum().getCoverImageUrl()%>" alt="앨범 커버"
						onerror="this.src='/CDtrade/resources/images/default-album.jpg'">
				</div>
				<div class="review-content">
					<div class="review-album-info">
						<h3 class="album-title"><%=review.getAlbum().getTitle()%></h3>
						<p class="album-artist"><%=review.getAlbum().getArtistName()%></p>
					</div>
					<div class="review-user-info">
						<i class="fas fa-user-circle"></i> <span class="user-name"><%=review.getUser().getNickname() != null ? review.getUser().getNickname() : review.getUser().getName()%></span>
					</div>
					<div class="review-rating">
						<div class="stars">
							<%=StringUtils.toStar(review.getRating())%>
							<span class="rating-number"><%=review.getRating()%></span>
						</div>
					</div>
					<div class="review-text"><%=review.getContent()%></div>
				</div>
			</div>
			<%
			}
			} else {
			%>
			<div class="no-reviews-message"
				style="text-align: center; padding: 50px 0;">
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
$(document).ready(function() {
    let currentPage = 1;
    let loading = false;
    let allLoaded = false;
    const totalRows = <%=totalRows%>;
    const rowsPerPage = 10;
    const totalPages = Math.ceil(totalRows / rowsPerPage);
    const genreNo = <%=genreNo != 0 ? genreNo : "null"%>;
    const keyword = '<%=keyword != null ? keyword : ""%>';

    // 무한 스크롤 이벤트
    $(window).scroll(function() {
        if ($(window).scrollTop() + $(window).height() >= $(document).height() - 500 && !loading && !allLoaded) {
            loadMoreReviews();
        }
    });

    function loadMoreReviews() {
        loading = true;
        currentPage++;

        if (currentPage > totalPages) {
            allLoaded = true;
            return;
        }

        $('.loading').show();

        $.ajax({
            url: 'review-list.jsp',
            type: 'GET',
            data: {
                page: currentPage,
                genreNo: genreNo,
                keyword: keyword,
                ajax: 'true' // AJAX 요청임을 구분하기 위한 파라미터
            },
            success: function(response) {
                if (response.trim() === '') {
                    allLoaded = true;
                } else {
                    $('#review-container').append(response);
                }
                loading = false;
                $('.loading').hide();
            },
            error: function() {
                console.log('Error loading more reviews');
                loading = false;
                $('.loading').hide();
            }
        });
    }

    // 장르 선택 모달 제어
    $("#genre-selector").click(function() {
        $("#genre-modal").addClass("show");
    });

    $(".genre-modal-close").click(function() {
        $("#genre-modal").removeClass("show");
    });

    $(window).click(function(event) {
        if ($(event.target).is("#genre-modal")) {
            $("#genre-modal").removeClass("show");
        }
    });
    
    // 장르 항목 클릭 이벤트 처리 추가
    $(".genre-item").click(function(e) {
        // 모달 닫기
        $("#genre-modal").removeClass("show");
        
        // 기본 이벤트는 그대로 실행 (링크 이동)
        // 여기서는 명시적으로 아무것도 할 필요 없음, 링크 클릭 이벤트가 실행됨
    });
    
    // 모바일에서 클릭 이벤트가 제대로 작동하지 않을 수 있어, 터치 이벤트도 추가
    $(".genre-item").on("touchend", function(e) {
        // 모달 닫기
        $("#genre-modal").removeClass("show");
        
        // 지연 시간을 두어 모달이 먼저 닫히고 페이지 이동하도록 함
        setTimeout(function() {
            window.location.href = e.target.href;
        }, 100);
        
        // 기본 이벤트 중지 (두 번 실행되는 것 방지)
        e.preventDefault();
    });
});
</script>
</body>
</html>