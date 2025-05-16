<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@ page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page import="kr.co.cdtrade.mapper.WishItemMapper"%>
<%@ page import="kr.co.cdtrade.vo.WishItem"%>
<%@ page import="kr.co.cdtrade.vo.User"%>
<%@ page import="java.util.List"%>
<%@include file="../common/nav.jsp" %>
<%
User loginUser = (User) session.getAttribute("LOGINED_USER");

//로그인 상태 확인
if (loginUser == null) {
// 로그인되지 않은 경우 로그인 페이지로 리다이렉트
response.sendRedirect("../login/login-form.jsp?from=mycollection");
return;
}


// 정렬 옵션 파라미터 가져오기
String sortOption = request.getParameter("sort");
System.out.println("요청 파라미터 - sort: " + sortOption);

if (sortOption == null || sortOption.isEmpty()) {
    sortOption = "newest"; // 기본 정렬: 신규등록순
    System.out.println("기본 정렬 옵션으로 설정: " + sortOption);
}

// 위시리스트 아이템 조회
WishItemMapper wishItemMapper = MybatisUtils.getMapper(WishItemMapper.class);
List<WishItem> wishItems = null;

System.out.println("사용자 ID: " + loginUser.getNo());
System.out.println("정렬 옵션: " + sortOption);

// 정렬 옵션에 따른 조회
try {
    if ("newest".equals(sortOption)) {
        System.out.println("신규등록순 정렬 실행");
        wishItems = wishItemMapper.getItemsByUserIdSorted(loginUser.getNo(), "newest");
    } else if ("popular".equals(sortOption)) {
        System.out.println("인기순 정렬 실행");
        wishItems = wishItemMapper.getItemsByUserIdSorted(loginUser.getNo(), "popular");
    } else if ("priceHigh".equals(sortOption)) {
        System.out.println("높은가격순 정렬 실행");
        wishItems = wishItemMapper.getItemsByUserIdSorted(loginUser.getNo(), "priceHigh");
    } else if ("priceLow".equals(sortOption)) {
        System.out.println("낮은가격순 정렬 실행");
        wishItems = wishItemMapper.getItemsByUserIdSorted(loginUser.getNo(), "priceLow");
    } else {
        System.out.println("기본 정렬 실행");
        wishItems = wishItemMapper.getItemsByUserId(loginUser.getNo());
    }

    // 결과 확인
    if (wishItems != null) {
        System.out.println("조회된 위시리스트 항목 수: " + wishItems.size());
        if (wishItems.size() > 0) {
            System.out.println("첫 번째 항목 정보: " + wishItems.get(0).getAlbum().getTitle() + 
                ", 가격: " + wishItems.get(0).getAlbum().getReleasePrice());
        }
    } else {
        System.out.println("위시리스트 항목이 null입니다.");
    }
} catch(Exception e) {
    System.out.println("정렬 조회 중 오류 발생: " + e.getMessage());
    e.printStackTrace();
    wishItems = wishItemMapper.getItemsByUserId(loginUser.getNo()); // 오류 시 기본 조회
}

// 총 위시리스트 아이템 개수
int totalItems = wishItemMapper.countByUserId(loginUser.getNo());
System.out.println("총 위시리스트 항목 수: " + totalItems);
System.out.println("===== 위시리스트 디버깅 종료 =====");
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>위시리스트</title>
<link rel="stylesheet" href="../resources/css/common.css">
<link rel="stylesheet" href="../resources/css/wishlist.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
    <div class="wishlist-title">위시리스트</div>
    <div class="wishlist-header">
        <div class="list-header">
            <div class="total-items">전체 <b><%=totalItems%></b>개</div>
            <button class="sort-button" id="sortButton">
                <span>
                <%
                // 정렬 옵션 표시 텍스트 설정 (SQL 쿼리 실행 없음)
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
                </span>
                <i class="fas fa-chevron-down"></i>
            </button>
        </div>
    </div>

    <div class="album-grid">
        <%
        if (wishItems != null && !wishItems.isEmpty()) {
            for (WishItem item : wishItems) {
        %>
        <div class="album-card">
            <a href="${pageContext.request.contextPath}/album/detail.jsp?albumNo=<%=item.getAlbum().getNo()%>">
                <img src="<%=item.getAlbum().getCoverImageUrl()%>" 
                     alt="<%=item.getAlbum().getTitle()%>" 
                     class="album-image"
                     onerror="this.src='/CDtrade/resources/images/default-album.jpg'">
            </a>
            <div class="album-info">
                <h3 class="album-title">
                    <a href="${pageContext.request.contextPath}/album/detail.jsp?albumNo=<%=item.getAlbum().getNo()%>">
                        <%=item.getAlbum().getArtistName()%> - <%=item.getAlbum().getTitle()%>
                    </a>
                </h3>
                <div class="album-price-label">구매가</div>
                <div class="album-price"><%=String.format("%,d", item.getAlbum().getReleasePrice())%>원</div>
                <button class="remove-wishlist-btn" data-wishno="<%=item.getNo()%>">
                    <i class="fas fa-heart"></i> 위시리스트에서 제거
                </button>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="empty-wishlist">
            <p>위시리스트에 추가된 앨범이 없습니다.</p>
            <a href="${pageContext.request.contextPath}/album/best-album-list.jsp" class="btn-primary">앨범 둘러보기</a>
        </div>
        <%
        }
        %>
    </div>

    <!-- 정렬 모달 -->
    <div class="modal-backdrop" id="sortModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">정렬</h2>
                <button class="modal-close" id="modalClose">&times;</button>
            </div>
            <div class="modal-body">
                <ul class="sort-list">
                    <li class="sort-item <%="newest".equals(sortOption) ? "active" : ""%>" data-sort="newest">신규등록순</li>
                    <li class="sort-item <%="popular".equals(sortOption) ? "active" : ""%>" data-sort="popular">인기순</li>
                    <li class="sort-item <%="priceHigh".equals(sortOption) ? "active" : ""%>" data-sort="priceHigh">높은가격순</li>
                    <li class="sort-item <%="priceLow".equals(sortOption) ? "active" : ""%>" data-sort="priceLow">낮은가격순</li>
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
                
                // 현재 URL을 가져와서 정렬 파라미터만 변경
                const currentUrl = new URL(window.location.href);
                currentUrl.searchParams.set('sort', sortValue);
                
                console.log('이동할 URL:', currentUrl.toString());
                window.location.href = currentUrl.toString();
            });
        });
        // 위시리스트 아이템 제거 버튼 처리
        $(document).on('click', '.remove-wishlist-btn', function(e) {
            e.preventDefault(); // 기본 이벤트 방지
            
            const wishNo = $(this).data('wishno');
            
            if (confirm('위시리스트에서 삭제하시겠습니까?')) {
                $.ajax({
                    url: 'delete-wishlist-item.jsp',
                    type: 'POST',
                    data: { wishNo: wishNo },
                    success: function(response) {
                        if (response.trim() === 'success') {
                            // 성공 시 화면에서 해당 아이템 제거
                            $('[data-wishno="' + wishNo + '"]').closest('.album-card').fadeOut(300, function() {
                                $(this).remove();
                                
                                // 남은 아이템이 없으면 메시지 표시
                                if ($('.album-card').length === 0) {
                                    $('.album-grid').html(`
                                        <div class="empty-wishlist">
                                            <p>위시리스트에 추가된 앨범이 없습니다.</p>
                                            <a href="${pageContext.request.contextPath}/album/list" class="btn-primary">앨범 둘러보기</a>
                                        </div>
                                    `);
                                }
                                
                                // 총 아이템 수 업데이트
                                $('.total-items b').text($('.album-card').length);
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