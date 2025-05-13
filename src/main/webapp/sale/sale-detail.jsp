<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.AlbumMapper"%>
<%@page import="kr.co.cdtrade.vo.Album"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	int saleNo = StringUtils.strToInt(request.getParameter("sno"));
	SalesMapper saleMapper = MybatisUtils.getMapper(SalesMapper.class);
	Sale sale = saleMapper.getSaleBySaleNo(saleNo);
%>    
    
  
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=sale.getAlbumTitle() %></title>
    <link rel="stylesheet" href="../resources/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@include file="../../common/nav.jsp"%>
<title><%=sale.getAlbumTitle()%></title>
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
<link rel="stylesheet" href="../resources/css/common.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>
    <div class="container">
        <div class="detail-container">
            <!-- 상품 이미지 -->
            <div class="detail-image">
                <!-- 이미지 슬라이더 인디케이터 -->
                <div class="image-slider">
                    <img src="<%=sale.getPhotoPath() %>">
                    <div class="slider-indicators">
                        <span class="indicator active"></span>
                        <span class="indicator"></span>
                        <span class="indicator"></span>
                        <span class="indicator"></span>
                        <span class="indicator"></span>
                    </div>
                </div>
            </div>

            <!-- 상품 정보 -->
            <div class="detail-info">
                <!-- 제목과 공유 버튼 -->
                <div class="detail-header">
                    <div>
                        <h1 class="detail-title"><%=sale.getAlbumTitle() %></h1>
                        <p class="artist-name"><%=sale.getArtistName() %></p>
                    </div>
                    <button class="share-button">
                        <i class="fas fa-share-alt"></i>
                    </button>
                </div>

                <!-- 가격 -->
                <div class="detail-price">
                    <span class="price-label">즉시 구매가</span>
                    <span class="price-value"><%=sale.getPrice() %>원</span>
                </div>

                <!-- 상태 뱃지 -->
                <div class="detail-badge"><%="t".equals(sale.getIsOpened()) ? "중고" : "미개봉" %></div>
                <div class="condition-info">음반 NM / 커버 NM</div>

                <!-- 상품 설명 -->
                <div class="product-description">
                    <%=sale.getDescription() %>
                </div>

                <!-- 상품 정보 테이블 -->
                <div class="info-section">
                    <h2>Information</h2>
                    <table class="info-table">
                        <tr>
                            <th>발매일</th>
                            <td><%=sale.getReleaseDate() %></td>
                        </tr>
                        <tr>
                            <th>발매사</th>
                            <td>카카오M</td>
                        </tr>
                        <tr>
                            <th>장르</th>
                            <td>Korean,Indie</td>
                        </tr>
                        <tr>
                            <th>수입국</th>
                            <td></td>
                        </tr>
                        <tr>
                            <th>Cat.No / BARCODE</th>
                            <td>L20000193O</td>
                        </tr>
                        <tr>
                            <th>추가정보</th>
                            <td>그린</td>
                        </tr>
                    </table>
                </div>

                <!-- 버튼 영역 -->
                <div class="button-group">
                    <button class="purchase-button" onclick="location.href='order-form.jsp?sno=<%=sale.getNo() %>'">즉시 구매</button>
                </div>
            </div>
        </div>
    </div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <% if (photoPaths.length > 1) { %>
    <button class="nav-btn prev" onclick="moveSlide(-1)">
        <i class="fas fa-chevron-left"></i>
    </button>
    <button class="nav-btn next" onclick="moveSlide(1)">
        <i class="fas fa-chevron-right"></i>
    </button>
    <div class="dots">
        <% for (int i = 0; i < photoPaths.length; i++) { %>
        <span class="dot <%= i == 0 ? "active" : "" %>" onclick="goToSlide(<%=i%>)"></span>
        <% } %>
    </div>
    <% } %>
</div>			</div>

			<!-- 상품 정보 -->
			<div class="detail-info">
				<!-- 제목과 공유 버튼 -->
				<div class="detail-header">
					<div>
						<h1 class="detail-title"><%=sale.getAlbumTitle()%></h1>
						<p class="artist-name"><%=sale.getArtistName()%></p>
					</div>
					<button class="share-button">
						<i class="fas fa-share-alt"></i>
					</button>
				</div>

				<!-- 가격 -->
				<div class="detail-price">
					<span class="price-label">즉시 구매가</span> <span class="price-value"><%=String.format("%,d", sale.getPrice())%>원</span>
				</div>

				<!-- 상태 뱃지 -->
				<div class="detail-badge"><%="t".equals(sale.getIsOpened()) ? "중고" : "미개봉"%></div>


				<!-- 상품 설명 -->
				<div class="product-description">
					<%=sale.getDescription()%>
				</div>

				<!-- 상품 정보 테이블 -->
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
										if (i < sale.getGenres().size() - 1)
									out.print(", ");
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
										if (i < sale.getGenres().size() - 1)
									out.print(", ");
									}
								} else {
									out.print("장르 번호 없음");
								}
								%>
							</td>
						</tr>
						<tr>
							<th>발매가</th>
							<td><%=String.format("%,d", album.getReleasePrice()) %></td>
						</tr>
						<tr>
							<th>판매가</th>
							<td><%=String.format("%,d", sale.getPrice()) %></td>
						</tr>
					</table>
				</div>

				<!-- 버튼 영역 -->
				<div class="button-group">
					<button class="purchase-button"
						onclick="location.href='order-form.jsp?sno=<%=sale.getNo() %>'">즉시
						구매</button>
				</div>
			</div>
		</div>
	</div>
	<%@include file="../../common/footer.jsp"%>
	<script>
	const slider = document.getElementById('slider');
	const slides = document.querySelectorAll('.slide');
	const prevBtn = document.querySelector('.prev');
	const nextBtn = document.querySelector('.next');
	const dots = document.querySelectorAll('.dot');
	let currentIndex = 0;

	function updateSlider() {
	    const slideWidth = document.querySelector('.slider-container').clientWidth;
	    
	    
	    slider.style.transform = `translateX(-${currentIndex * slideWidth}px)`;
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



	
</body>
</html>