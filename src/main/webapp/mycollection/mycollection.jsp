<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@ page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page import="kr.co.cdtrade.mapper.MyCollectionMapper"%>
<%@ page import="kr.co.cdtrade.vo.MyCollectionItem"%>
<%@ page import="kr.co.cdtrade.vo.User"%>
<%@ page import="java.util.List"%>
<%@include file="../common/nav.jsp" %>
<%
// 임시 로그인 처리 (개발용)
User tempUser = new User();
tempUser.setNo(1); // 임시 사용자 ID
tempUser.setName("테스트 사용자");
tempUser.setNickname("CD매니아");

// 개발 단계에서는 임시 사용자 정보 세션에 저장
session.setAttribute("loginUser", tempUser);

// 세션에서 로그인 사용자 정보 가져오기
User loginUser = (User) session.getAttribute("loginUser");

// 정렬 옵션 파라미터 가져오기
String sortOption = request.getParameter("sort");
if (sortOption == null || sortOption.isEmpty()) {
	sortOption = "newest"; // 기본 정렬: 신규등록순
}

// 마이컬렉션 아이템 조회
MyCollectionMapper myCollectionMapper = MybatisUtils.getMapper(MyCollectionMapper.class);
List<MyCollectionItem> myCollectionItems = null;

// 정렬 옵션에 따른 조회
if ("newest".equals(sortOption)) {
	myCollectionItems = myCollectionMapper.getItemsByUserIdSorted(loginUser.getNo(), "newest");
} else if ("popular".equals(sortOption)) {
	myCollectionItems = myCollectionMapper.getItemsByUserIdSorted(loginUser.getNo(), "popular");
} else if ("priceHigh".equals(sortOption)) {
	myCollectionItems = myCollectionMapper.getItemsByUserIdSorted(loginUser.getNo(), "priceHigh");
} else if ("priceLow".equals(sortOption)) {
	myCollectionItems = myCollectionMapper.getItemsByUserIdSorted(loginUser.getNo(), "priceLow");
} else {
	myCollectionItems = myCollectionMapper.getItemsByUserId(loginUser.getNo());
}

// 총 컬렉션 아이템 개수
int totalItems = myCollectionMapper.countByUserId(loginUser.getNo());
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이컬렉션</title>
<link rel="stylesheet" href="../resources/css/common.css">
<link rel="stylesheet" href="../resources/css/mycollection.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
	<div class="mycollection-title">마이컬렉션</div>
	<div class="mycollection-header">
		<div class="list-header">
			<div class="total-items">
				<i class="fas fa-check-circle" style="font-size: 1rem;"></i> 총 <b><%=totalItems%></b>개
			</div>
			<button class="sort-button" id="sortButton">
				<span> <%
 if ("newest".equals(sortOption)) {
 	out.print("신규등록순");
 } else if ("popular".equals(sortOption)) {
 	out.print("인기순");
 } else if ("priceHigh".equals(sortOption)) {
 	out.print("높은가격순");
 } else if ("priceLow".equals(sortOption)) {
 	out.print("낮은가격순");
 } else {
 	out.print("신규등록순");
 }
 %>
				</span> <i class="fas fa-chevron-down"></i>
			</button>
		</div>
	</div>

	<div class="mycollection-grid">
		<%
		if (myCollectionItems != null && !myCollectionItems.isEmpty()) {
			for (MyCollectionItem item : myCollectionItems) {
		%>
		<div class="mycollection-card"
			onclick="location.href='album-detail.jsp?albumNo=<%=item.getAlbum().getNo()%>'">
			<img class="mycollection-album-img"
				src="<%=item.getAlbum().getCoverImageUrl()%>"
				alt="<%=item.getAlbum().getTitle()%>"
				onerror="this.src='/CDtrade/resources/images/default-album.jpg'">
			<div class="mycollection-card-overlay">
				<div class="review-block-rating">
					<div class="stars">
						<%
						if (item.getReview() != null && item.getReview().getRating() > 0) {
						%>
						<%=StringUtils.toStar(item.getReview().getRating())%>
						<%
						} else {
						%>
						<span class="rating-message">리뷰 미작성</span>
						<%
						}
						%>
					</div>
				</div>
				<button class="remove-btn" data-colno="<%=item.getNo()%>">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="mycollection-card-info">
				<h3 class="album-title"><%=item.getAlbum().getTitle()%></h3>
				<p class="album-artist"><%=item.getAlbum().getArtistName()%></p>
			</div>
		</div>
		<%
		}
		} else {
		%>
		<div class="no-collection-message">
			<p>컬렉션에 추가된 앨범이 없습니다.</p>
			<a href="album-list.jsp" class="browse-albums-btn">앨범 둘러보기</a>
		</div>
		<%
		}
		%>
	</div>
<%
System.out.println("마이컬렉션 디버깅 시작");
System.out.println("사용자 ID: " + loginUser.getNo());
System.out.println("컬렉션 개수: " + totalItems);

if (myCollectionItems != null) {
    System.out.println("컬렉션 목록 크기: " + myCollectionItems.size());
    for (MyCollectionItem item : myCollectionItems) {
        System.out.println("아이템 ID: " + item.getNo() + 
                           ", 앨범: " + (item.getAlbum() != null ? item.getAlbum().getTitle() : "null") + 
                           ", 리뷰: " + (item.getReview() != null ? item.getReview().getNo() : "null"));
    }
} else {
    System.out.println("컬렉션 목록이 null입니다.");
}
%>
	<!-- 정렬 모달 -->
	<div class="modal-backdrop" id="sortModal">
		<div class="modal-content">
			<div class="modal-header">
				<h2 class="modal-title">정렬</h2>
				<button class="modal-close" id="modalClose">&times;</button>
			</div>
			<div class="modal-body">
				<ul class="sort-list">
					<li
						class="sort-item <%="newest".equals(sortOption) ? "active" : ""%>"
						data-sort="newest">신규등록순</li>
					<li
						class="sort-item <%="popular".equals(sortOption) ? "active" : ""%>"
						data-sort="popular">인기순</li>
					<li
						class="sort-item <%="priceHigh".equals(sortOption) ? "active" : ""%>"
						data-sort="priceHigh">높은가격순</li>
					<li
						class="sort-item <%="priceLow".equals(sortOption) ? "active" : ""%>"
						data-sort="priceLow">낮은가격순</li>
				</ul>
			</div>
		</div>
	</div>


	<script>
        // 모달 관련 요소
        const sortButton = document.getElementById('sortButton');
        const sortModal = document.getElementById('sortModal');
        const modalClose = document.getElementById('modalClose');
        const sortItems = document.querySelectorAll('.sort-item');

        // 정렬 버튼 클릭 시 모달 표시
        sortButton.addEventListener('click', () => {
            sortModal.classList.add('show');
        });

        // 모달 닫기 버튼 클릭 시 모달 숨김
        modalClose.addEventListener('click', () => {
            sortModal.classList.remove('show');
        });

        // 모달 외부 클릭 시 모달 숨김
        sortModal.addEventListener('click', (e) => {
            if (e.target === sortModal) {
                sortModal.classList.remove('show');
            }
        });

        // 정렬 옵션 클릭 시 처리
        sortItems.forEach(item => {
            item.addEventListener('click', () => {
                // 정렬 옵션 값 가져오기
                const sortValue = item.getAttribute('data-sort');
                // 페이지 이동
                window.location.href = 'mycollection.jsp?sort=' + sortValue;
            });
        });
        
        // 컬렉션 아이템 제거 버튼 처리
        $(document).on('click', '.remove-btn', function(e) {
            e.stopPropagation(); // 부모 요소 클릭 이벤트 방지
            
            const colNo = $(this).data('colno');
            
            if (confirm('컬렉션에서 삭제하시겠습니까?')) {
                $.ajax({
                    url: 'delete-collection-item.jsp',
                    type: 'POST',
                    data: { colNo:  colNo },
                    success: function(response) {
                        if (response.trim() === 'success') {
                            // 성공 시 화면에서 해당 아이템 제거
                            $('[data-colno="' + colNo + '"]').closest('.mycollection-card').fadeOut(300, function() {
                                $(this).remove();
                                
                                // 남은 아이템이 없으면 메시지 표시
                                if ($('.mycollection-card').length === 0) {
                                    $('.mycollection-grid').html(`
                                        <div class="no-collection-message">
                                            <p>컬렉션에 추가된 앨범이 없습니다.</p>
                                            <a href="album-list.jsp" class="browse-albums-btn">앨범 둘러보기</a>
                                        </div>
                                    `);
                                }
                                
                                // 총 아이템 수 업데이트
                                $('.total-items b').text($('.mycollection-card').length);
                            });
                        } else {
                            alert('삭제 중 오류가 발생했습니다.');
                        }
                    },
                    error: function() {
                        alert('서버 오류가 발생했습니다.');
                    }
                });
            }
        });
    </script>
</body>
</html>