<%@page import="java.util.concurrent.locks.Condition"%>
<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="kr.co.cdtrade.vo.Album"%>
<%@page import="kr.co.cdtrade.utils.Pagination"%>
<%@page import="kr.co.cdtrade.vo.Genre"%>
<%@page import="kr.co.cdtrade.mapper.GenreMapper"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.mapper.AlbumMapper"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	int pageNo = StringUtils.strToInt(request.getParameter("page"), 1);
	String sort = StringUtils.nullToStr(request.getParameter("sort"), "newest");
	String isOpened = StringUtils.nullToStr(request.getParameter("isOpened"), "");
	String isSold = StringUtils.nullToStr(request.getParameter("isSold"), "");
	String keyword = StringUtils.nullToStr(request.getParameter("keyword"), "");

	Map<String, Object> condition = new HashMap<>();
	
	condition.put("page", pageNo);
	condition.put("sort", sort);
	
	if (!keyword.isEmpty()) {
	    condition.put("keyword", "%" + keyword + "%");  // MyBatis에서 LIKE로 검색하기 위함
	}
	if (!isOpened.isEmpty()) {
		condition.put("isOpened", isOpened);
	}
	
	if (!isSold.isEmpty()) {
		condition.put("isSold", isSold);
	}
	
	SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);		
	
	int totalRows = salesMapper.getTotalRows(condition);
	
	Pagination pagination = new Pagination(pageNo, totalRows, 4);
	
	condition.put("offset", pagination.getOffset());
	condition.put("rows", 4);
	
	List<Sale> sales = salesMapper.getSales(condition);
	
	
%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
    .album-title {
    color: black !important;
    text-decoration: none !important; /* 밑줄 제거도 원할 경우 */
	}
	.album-title:hover {
	    color: black !important; /* 마우스 오버 시에도 색 유지 */
	}
</style>
    <title>판매 목록</title>
    <%@include file="../common/nav.jsp" %>
    <link rel="stylesheet" href="../resources/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>
    <div class="container">
        <!-- 검색바 -->
        <div class="search-bar">
            <i class="fas fa-search search-icon"></i>
           <input type="text" class="search-input" id="search-input" placeholder="앨범명, 가수명, 소속사명 등" value="<%=request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">

        </div>
        <br>

        <!-- 필터 버튼 -->
		<div class="filter-buttons">
			<button type="button"
				class="btn btn-outline-primary filter-button  <%= "f".equals(isOpened) ? "active" : "" %>"
				data-type="isOpened" data-value="f">미개봉</button>
			<button type="button"
				class="btn btn-outline-primary filter-button <%= "t".equals(isOpened) ? "active" : "" %>"
				data-type="isOpened" data-value="t">중고</button>
			<button type="button"
				class="btn btn-outline-danger filter-button <%= "f".equals(isSold) ? "active" : "" %>"
				data-type="isSold" data-value="f">판매완료상품 제외</button>
		</div>

		<!-- 목록 헤더 -->
		<div class="list-header">
		    <div class="total-items">전체 2424개</div>
		
		    
		<!-- 필터 버튼 -->
        <div class="filter-buttons">
	        <form id="form-filter" method="get" action="sale-list.jsp">
			  <input type="hidden" name="page" value="1">
			  <input type="hidden" name="isOpened" id="input-isOpened" value="<%=isOpened%>">
			  <input type="hidden" name="isSold" id="input-isSold" value="<%=isSold%>">
			  <input type="hidden" name="sort" id="input-sort" value="<%=sort%>">
			  <input type="hidden" name="keyword" id="input-keyword" value="<%=request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
			  
		     <select name="sort" class="form-select" onchange="document.getElementById('form-filter').submit();">

			  	<option value="newest" <%="newest".equals(sort) ? "selected" : "" %>>신규등록순</option>
			    <option value="price-desc" <%="price-desc".equals(sort) ? "selected" : "" %>>높은가격순</option>
			    <option value="price-asc" <%="price-asc".equals(sort) ? "selected" : "" %>>낮은가격순</option>
		       </select>
			   
			</form>
		        </div>
		    </div>
		   
        <!-- 앨범 그리드 -->
        <div class="album-grid">
<%
	for(Sale sale : sales){
%>
            <!-- 앨범 카드 1 -->
            <a href="sale-detail.jsp?sno=<%=sale.getNo() %>" class="album-card">
                <img src="<%=sale.getPhotoPath().split(",")[0] %>" alt="<%=sale.getAlbumTitle()%>" class="album-image">
                <div class="album-info">
                    <h3 class="album-title"><%=sale.getAlbumTitle() %></h3>
                    <div class="album-status"><%="t".equals(sale.getIsOpened()) ? "중고" : "미개봉" %></div>
                    <div class="album-price-label">구매가</div>
                    <div class="album-price"><%=String.format("%,d", sale.getPrice()) %>원</div>
                </div>
            </a>
<%
	}
%>
            
            </div>
        </div>

    <script>
    
    const sortButton = document.getElementById('sortButton');
    const sortList = document.getElementById('sortList');
    const sortItems = document.querySelectorAll('.sort-item');

        // 필터 버튼 기능
        const filterButtons = document.querySelectorAll('.filter-button');

        filterButtons.forEach(button => {
            button.addEventListener('click', () => {
                button.classList.toggle('active');
            });
        });
        
        let currentPage = 1;
        let isLoading = false;

        window.addEventListener('scroll', () => {
            if ((window.innerHeight + window.scrollY + 500) > document.body.scrollHeight) {
                if (!isLoading) {
                    isLoading = true;
                    currentPage++;

                    fetch(`getSales.jsp?page=\${currentPage}`)
                        .then(res => res.json())
                        .then(data => {
						    const albumGrid = document.querySelector('.album-grid');
						
						    data.forEach(sale => {
						        console.log(sale);  // ✅ 구조 확인용
						
						        const card = document.createElement('a');
						        card.href = `sale-detail.jsp?sno=\${sale.saleNo}`;
						        card.className = 'album-card';
						        card.innerHTML = `
						            <img src="\${sale.photoPath.split(",")[0]}" class="album-image">
						            <div class="album-info">
						                <h3 class="album-title">\${sale.albumTitle}</h3>
						                <div class="album-status">\${sale.isOpened == 't' ? '중고' : '미개봉'}</div>
						                <div class="album-price-label">구매가</div>
						                <div class="album-price">\${sale.price}원</div>
						            </div>
						        `;
						        albumGrid.appendChild(card);
						    });
						
						    isLoading = false;
						})
                        .catch(err => {
                            console.error('불러오기 실패:', err);
                            isLoading = false;
                        });
                }
            }
        });
        document.querySelector('select[name="sort"]').addEventListener('change', function () {
            document.getElementById('input-sort').value = this.value;
            document.getElementById('form-filter').submit();
        });

        document.querySelectorAll('.filter-button').forEach(button => {
            button.addEventListener('click', function () {
                const type = this.dataset.type;
                const value = this.dataset.value;
                const input = document.getElementById('input-' + type);

                if (input.value == value) {
                    input.value = "";
                    this.classList.remove('active');
                } else {
                    input.value = value;
                    // 같은 타입의 버튼에서 active 제거
                    document.querySelectorAll(`.filter-button[data-type="\${type}"]`)
                    		.forEach(btn => btn.classList.remove('active'));
                    this.classList.add('active');
                }

                // 페이지 1로 초기화 후 form 제출
                document.querySelector('input[name="page"]').value = 1;
                document.getElementById('form-filter').submit();
            });
        });
		
     // 자동 검색 기능 (0.5초 후 자동 제출)
        document.getElementById("search-input").addEventListener("input", function () {
            const keyword = this.value;
            document.getElementById("input-keyword").value = keyword;
            document.querySelector('input[name="page"]').value = 1;

            clearTimeout(window.searchTimeout);
            window.searchTimeout = setTimeout(() => {
                document.getElementById("form-filter").submit();
            }, 400);
        });
	
        // 최대 길이 설정 (원하는 값으로 조정하세요)
        const maxTitleLength = 40;

        // 모든 앨범 제목 요소 가져오기
        const titles = document.querySelectorAll('.album-title');

        titles.forEach(titleElement => {
            const originalText = titleElement.innerText;
            if (originalText.length > maxTitleLength) {
                const truncated = originalText.substring(0, maxTitleLength) + '...';
                titleElement.innerText = truncated;
            }
        });
        
        
        
    </script>
     <%@include file="../../common/footer.jsp" %>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</body>
</html>
