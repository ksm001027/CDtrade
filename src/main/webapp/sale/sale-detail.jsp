<%@page import="lombok.EqualsAndHashCode.Include"%>
<%@page import="kr.co.cdtrade.vo.Genre"%>
<%@page import="java.util.List"%>
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
	
	List<Genre> genres = saleMapper.getGenresBySaleNo(saleNo);
	sale.setGenres(genres);
	
	Album album = saleMapper.getAlbumBySaleNo(saleNo);
	sale.setAlbum(album);
%>    
    
  
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@include file="../../common/nav.jsp"%>
    <title><%=sale.getAlbumTitle() %></title>
    <link rel="stylesheet" href="../resources/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                            <td><%=album.getReleaseDate() %></td>
                        </tr>
                        <tr>
                            <th>전체평점</th>
                            <td><%=album.getAvgRating() %></td>
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
                            <td><%=album.getReleasePrice() %></td>
                        </tr>
                        <tr>
                            <th>판매가</th>
                            <td><%=sale.getPrice() %></td>
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
    <%@include file="../../common/footer.jsp" %>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</body>
</html>