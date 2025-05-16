<%@page import="kr.co.cdtrade.vo.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.co.cdtrade.vo.Genre"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.vo.Album"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int saleNo = StringUtils.strToInt(request.getParameter("sno"));   
    SalesMapper saleMapper = MybatisUtils.getMapper(SalesMapper.class);
	User seller = saleMapper.getUserBySaleNo(saleNo);
    Sale sale = saleMapper.getSaleBySaleNo(saleNo);

    saleMapper.increaseViewCount(saleNo);
    
    List<Genre> genres = saleMapper.getGenresBySaleNo(saleNo);
    sale.setGenres(genres);

    Album album = saleMapper.getAlbumBySaleNo(saleNo);
    sale.setAlbum(album);

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    String formattedReleaseDate = album.getReleaseDate() != null ? dateFormat.format(album.getReleaseDate()) : "발매일 정보 없음";
    Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO"); 
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=sale.getAlbumTitle()%></title>
    <link rel="stylesheet" href="../resources/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <%@include file="../common/nav.jsp"%>
    <style>
        .slider-container {
            position: relative;
            width: 100%;
            max-width: 500px;
            margin: 50px auto;
            overflow: hidden;
            border-radius: 8px;
            border: 2px solid #ccc;
        }
        .slider {
            display: flex;
            transition: transform 0.5s ease-in-out;
            width: 100%;
        }
        .slide {
            min-width: 100%;
            box-sizing: border-box;
        }
        .slide img {
            width: 100%;
            max-height: 500px;
            object-fit: contain;
            display: block;
            border-radius: 8px;
        }
        .nav-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            padding: 10px;
            border-radius: 50%;
            cursor: pointer;
            z-index: 10;
        }
        .prev { left: 10px; }
        .next { right: 10px; }
        .dots {
            text-align: center;
            margin-top: 10px;
        }
        .dot {
            height: 12px;
            width: 12px;
            margin: 0 5px;
            background-color: #bbb;
            border-radius: 50%;
            display: inline-block;
            cursor: pointer;
        }
        .dot.active {
            background-color: #717171;
        }
    </style>
</head>

<body>
	<div class="container">
		<div class="detail-container">
			<!-- 상품 이미지 -->
			<div class="detail-image">
				<div class="slider-container">
					<div class="slider" id="slider">
						<% 
                    String[] photoPaths = sale.getPhotoPath().split(",");
                    for (int i = 0; i < photoPaths.length; i++) { 
                    %>
						<div class="slide">
							<img src="<%=photoPaths[i].trim()%>" alt="상품 이미지">
						</div>
						<% } %>
					</div>
					<% if (photoPaths.length > 1) { %>
					<button class="nav-btn prev" onclick="moveSlide(-1)">
						<i class="fas fa-chevron-left"></i>
					</button>
					<button class="nav-btn next" onclick="moveSlide(1)">
						<i class="fas fa-chevron-right"></i>
					</button>
					<div class="dots">
						<% for (int i = 0; i < photoPaths.length; i++) { %>
						<span class="dot <%= i == 0 ? "active" : "" %>"
							onclick="goToSlide(<%=i%>)"></span>
						<% } %>
					</div>
					<% } %>
				</div>
			</div>
			<!-- 상품 정보 -->
			<div class="detail-info">
				<div class="detail-header">
					<div>
						<h1 class="detail-title"><%=sale.getAlbumTitle()%></h1>
						<p class="artist-name"><%=sale.getArtistName()%></p>
					</div>
					<button class="share-button">
						<i class="fas fa-share-alt"></i>
					</button>
				</div>
				<div class="detail-price">
					<span class="price-label">즉시 구매가</span> <span class="price-value"><%=String.format("%,d", sale.getPrice())%>원</span>
				</div>
				<div class="detail-badge-container"
					style="display: flex; justify-content: space-between; align-items: center; margin-top: 10px;">
					<div class="detail-badge"><%="t".equals(sale.getIsOpened()) ? "중고" : "미개봉"%></div>
					<div class="product-views"
						style="color: #888; font-size: 0.9em; margin: 5px 0;">
						<div class="product-views">
							조회수:
							<%=sale.getViewCount()%>회
						</div>
						<div class="product-count">
							매물수:
							<%=album.getStockQuantity()%>개
						</div>
					</div>
				</div>
				<div class="product-description">
					<%=sale.getDescription()%>
				</div>

				<div class="info-section">
					<h2>Information</h2>
					<table class="info-table">
						<tr>
							<th>발매일</th>
							<td><%=formattedReleaseDate%></td>
						</tr>
						<tr>
							<th>전체평점</th>
							<td><%=album.getAvgRating()%></td>
						</tr>
						<tr>
							<th>장르</th>
							<td>
								<%
                            if (sale.getGenres() != null && !sale.getGenres().isEmpty()) {
                                for (int i = 0; i < sale.getGenres().size(); i++) {
                                    out.print(sale.getGenres().get(i).getName());
                                    if (i < sale.getGenres().size() - 1) out.print(", ");
                                }
                            } else {
                                out.print("장르 정보 없음");
                            }
                            %>
							</td>
						</tr>
						<tr>
							<th>Cat.No / BARCODE</th>
							<td>
								<%
                            if (sale.getGenres() != null && !sale.getGenres().isEmpty()) {
                                for (int i = 0; i < sale.getGenres().size(); i++) {
                                    out.print(sale.getGenres().get(i).getNo());
                                    if (i < sale.getGenres().size() - 1) out.print(", ");
                                }
                            } else {
                                out.print("장르 번호 없음");
                            }
                            %>
							</td>
						</tr>
						<tr>
							<th>발매가</th>
							<td><%=String.format("%,d", album.getReleasePrice())%></td>
						</tr>
						<tr>
							<th>최근 거래가</th>
							<td><%=String.format("%,d", album.getRecentOrderPrice())%></td>
						</tr>
						<tr>
							<th>평균 판매가</th>
							<td><%=String.format("%,d", album.getAvgSalePrice())%></td>
						</tr>
					</table>
				</div>
				<div class="button-group">
					<% if (userNo != null && userNo == seller.getNo()) { %>
					<button class="purchase-button"
						onclick="location.href='sale-form.jsp?ano=<%=sale.getAlbumNo()%>&sno=<%=sale.getNo()%>&mode=edit'">상품
						수정</button>
					<button class="purchase-button"
						onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='delete-sale.jsp?sno=<%=sale.getNo()%>'">상품
						삭제</button>
					<% } else { %>
					<button class="purchase-button"
						onclick="<%= (userNo == null) 
				        ? "if(confirm('로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?')) location.href=\'../login/login-form.jsp\';" 
				        : "location.href=\'../order/order-form.jsp?sno=" + sale.getNo() + "\';" %>">
						즉시 구매
					</button>
					<% } %>
				</div>
			</div>
		</div>
	</div>
	<%@include file="../common/footer.jsp"%>

	<script>
    const slider = document.getElementById('slider');
    const slides = document.querySelectorAll('.slide');
    const prevBtn = document.querySelector('.prev');
    const nextBtn = document.querySelector('.next');
    const dots = document.querySelectorAll('.dot');
    let currentIndex = 0;

    function updateSlider() {
        const slideWidth = document.querySelector('.slider-container').clientWidth;
        slider.style.transform = `translateX(-\${currentIndex * slideWidth}px)`;
        dots.forEach((dot, index) => {
            dot.classList.toggle('active', index === currentIndex);
        });
    }

    function moveSlide(direction) {
        currentIndex += direction;
        if (currentIndex < 0) currentIndex = slides.length - 1;
        if (currentIndex >= slides.length) currentIndex = 0;
        updateSlider();
    }

    function goToSlide(index) {
        currentIndex = index;
        updateSlider();
    }

    window.addEventListener('load', () => {
        if (slides.length <= 1) {
            prevBtn?.style.setProperty('display', 'none');
            nextBtn?.style.setProperty('display', 'none');
            document.querySelector('.dots')?.style.setProperty('display', 'none');
        }
        updateSlider();
    });

    window.addEventListener('resize', updateSlider);
   
</script>


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</body>
</html>
