<%@page import="kr.co.cdtrade.vo.Order"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.vo.Genre"%>
<%@page import="kr.co.cdtrade.mapper.GenreMapper"%>
<%@page import="kr.co.cdtrade.vo.Album"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.AlbumMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int albumNo = StringUtils.strToInt(request.getParameter("ano"));
	AlbumMapper albumMapper = MybatisUtils.getMapper(AlbumMapper.class);
	Album album = albumMapper.getAlbumByAlbumNo(albumNo);
	
	List<Genre> genres = albumMapper.getGenreByAlbumNo(albumNo);
    String genreNames = "";
    String genreNos="";
    
   	for (int i = 0; i < genres.size(); i++) {
   		genreNames += genres.get(i).getName();
   		if (i < genres.size() - 1) {
   			genreNames += ", ";
   		}
   	}
   	
   	for (int i = 0; i < genres.size(); i++) {
   		genreNos += genres.get(i).getNo();
   		if (i < genres.size() - 1)
   			genreNos += ", ";
   	}
   	
   
   
%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=album.getTitle() %></title>
    <link rel="stylesheet" href="../resources/css/common.css">
</head>

<body>
    <div class="container">
        <div class="detail-container">
            <!-- 왼쪽: 앨범 이미지 -->
            <div class="detail-image">
                <img src="<%=album.getCoverImageUrl() %>" alt="<%=album.getTitle() %>">
            </div>
            <!-- 오른쪽: 앨범 정보 -->
            <div class="detail-info">
                <div class="detail-header">
                    <div>
                        <h1 class="detail-title"><%=album.getTitle() %></h1>
                        <p class="artist-name"><%=album.getArtistName() %></p>
                    </div>
                    <div class="share-buttons">
                        <button class="icon-button">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M18 8C19.6569 8 21 6.65685 21 5C21 3.34315 19.6569 2 18 2C16.3431 2 15 3.34315 15 5C15 6.65685 16.3431 8 18 8Z"
                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" />
                                <path
                                    d="M6 15C7.65685 15 9 13.6569 9 12C9 10.3431 7.65685 9 6 9C4.34315 9 3 10.3431 3 12C3 13.6569 4.34315 15 6 15Z"
                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" />
                                <path
                                    d="M18 22C19.6569 22 21 20.6569 21 19C21 17.3431 19.6569 16 18 16C16.3431 16 15 17.3431 15 19C15 20.6569 16.3431 22 18 22Z"
                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" />
                                <path d="M8.59 13.51L15.42 17.49" stroke="currentColor" stroke-width="2"
                                    stroke-linecap="round" stroke-linejoin="round" />
                                <path d="M15.41 6.51L8.59 10.49" stroke="currentColor" stroke-width="2"
                                    stroke-linecap="round" stroke-linejoin="round" />
                            </svg>
                        </button>
                        <button class="icon-button">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path d="M3 3H10V10H3V3Z" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" />
                                <path d="M14 3H21V10H14V3Z" stroke="currentColor" stroke-width="2"
                                    stroke-linecap="round" stroke-linejoin="round" />
                                <path d="M14 14H21V21H14V14Z" stroke="currentColor" stroke-width="2"
                                    stroke-linecap="round" stroke-linejoin="round" />
                                <path d="M3 14H10V21H3V14Z" stroke="currentColor" stroke-width="2"
                                    stroke-linecap="round" stroke-linejoin="round" />
                            </svg>
                        </button>
                        <button class="icon-button">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M19 21L12 16L5 21V5C5 4.46957 5.21071 3.96086 5.58579 3.58579C5.96086 3.21071 6.46957 3 7 3H17C17.5304 3 18.0391 3.21071 18.4142 3.58579C18.7893 3.96086 19 4.46957 19 5V21Z"
                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>
                            <span class="bookmark-count">32</span>
                        </button>
                    </div>
                </div>

                <div class="rating">
                    <div class="stars">
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star">★</span>
                        <span class="rating-score">4.25 (92)</span>
                    </div>
                </div>

                <div class="product-details">
                    <h2>Information</h2>
                    <dl class="info-list">
                        <div class="info-item">
                            <dt>발매일</dt>
                            <dd>2021.01.19</dd>
                        </div>
                        <div class="info-item">
                            <dt>발매사</dt>
                            <dd>YG PLUS</dd>
                        </div>
                        <div class="info-item">
                            <dt>장르</dt>
                            <dd><%=genreNames %></dd>
                        </div>
                        <div class="info-item">
                            <dt>Cat.No / BARCODE</dt>
                            <dd><%=genreNos %></dd>
                        </div>
                        <div class="info-item">
                            <dt>추가정보</dt>
                            <dd>패키지 박스+포토북+가이드북드+바이닐보호커버+코로그래프+양면접지포스터+대형포토카드세트(6종)+랜덤셀피 포토카드(랜덤 4종)&포토카드 보드+포토 스티커
                                세트(4종)+팬엽서드</dd>
                        </div>
                        <div class="info-item">
                            <dt>최근거래</dt>
                            <dd><%=album.getRecentOrderPrice() %>원</dd>
                        </div>
                    </dl>

                    <button class="purchase-btn" onclick="location.href='sale-form.jsp?ano=<%=album.getNo()%>'">판매</button>

                    <div class="recent-trades">
                        <h3>최근거래</h3>
                        <table class="trades-table">
                            <thead>
                                <tr>
                                    <th>컨디션</th>
                                    <th>거래일</th>
                                    <th>거래가격</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><%= %></td>
                                    <td>2025-01-17</td>
                                    <td>95,000원</td>
                                </tr>
                                <tr>
                                    <td>미개봉 (결함)</td>
                                    <td>2024-11-01</td>
                                    <td>65,000원</td>
                                </tr>
                                <tr>
                                    <td>미개봉</td>
                                    <td>2024-10-14</td>
                                    <td>90,000원</td>
                                </tr>
                                <tr>
                                    <td>미개봉</td>
                                    <td>2024-10-03</td>
                                    <td>90,000원</td>
                                </tr>
                                <tr>
                                    <td>미개봉</td>
                                    <td>2024-08-30</td>
                                    <td>90,000원</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <button class="view-all-btn">전체보기</button>
                </div>
            </div>
        </div>

        <!-- 추천 상품 목록 -->
        <div class="recommended-products">
            <h2 class="section-title">판매 상품 목록</h2>
            <div class="section-header">
                <div class="product-count">전체 앨범 120개</div>
                <button class="sort-button">
                    정렬
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                            stroke-linejoin="round" />
                    </svg>
                </button>
            </div>

            <div class="product-grid">
                <!-- 상품 1 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://image.yes24.com/goods/92147169/XL" alt="BLACKPINK Album">
                    </div>
                    <h3 class="card-title">BLACKPINK 2nd VINYL LP (BORN PINK)</h3>
                    <p class="card-price">95,000원</p>
                </div>

                <!-- 상품 2 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://image.yes24.com/goods/92147169/XL" alt="BLACKPINK Album">
                    </div>
                    <h3 class="card-title">BLACKPINK 2nd VINYL LP (BORN PINK)</h3>
                    <p class="card-price">90,000원</p>
                </div>

                <!-- 상품 3 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://image.yes24.com/goods/92147169/XL" alt="BLACKPINK Album">
                    </div>
                    <h3 class="card-title">BLACKPINK 2nd VINYL LP (BORN PINK)</h3>
                    <p class="card-price">92,000원</p>
                </div>

                <!-- 상품 4 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://image.yes24.com/goods/92147169/XL" alt="BLACKPINK Album">
                    </div>
                    <h3 class="card-title">BLACKPINK 2nd VINYL LP (BORN PINK)</h3>
                    <p class="card-price">88,000원</p>
                </div>
            </div>
        </div>

        <!-- 앨범 리뷰 섹션 -->
        <div class="album-reviews">
            <div class="review-header">
                <h2>앨범리뷰</h2>
                <div class="review-stats">
                    <div class="stars">
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                    </div>
                    <div class="review-count">전체 2424개</div>
                </div>
            </div>

            <div class="review-write">
                <textarea placeholder="리뷰를 작성해주세요" class="review-textarea"></textarea>
                <button class="review-submit">등록</button>
            </div>

            <div class="review-list">
                <!-- 리뷰 아이템 1 -->
                <div class="review-item">
                    <div class="review-stars">
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                    </div>
                    <p class="review-text">가격 왜케 비싸? 쨌더니 18곡이네 ^^</p>
                    <div class="review-info">
                        <span class="reviewer">kurt1967</span>
                        <span class="review-date">2022-09-08</span>
                    </div>
                </div>

                <!-- 리뷰 아이템 2 -->
                <div class="review-item">
                    <div class="review-stars">
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star">★</span>
                        <span class="star">★</span>
                    </div>
                    <p class="review-text">내가 니이가 든 걸까? 맨 정신에 들어서 그런 걸까? 별로다.</p>
                    <div class="review-info">
                        <span class="reviewer">에로이카</span>
                        <span class="review-date">2023-01-14</span>
                    </div>
                </div>

                <!-- 리뷰 아이템 3 -->
                <div class="review-item">
                    <div class="review-stars">
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                    </div>
                    <p class="review-text">이런앨범은 행복합니다</p>
                    <div class="review-info">
                        <span class="reviewer">백수희</span>
                        <span class="review-date">2022-09-08</span>
                    </div>
                </div>

                <!-- 리뷰 아이템 4 -->
                <div class="review-item">
                    <div class="review-stars">
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                    </div>
                    <p class="review-text">긴 말 필요없이 명반이라고 생각합니다.<br>조슈일 시가 1시간 넘는 이야기를 준비했을 줄이야..<br>울해에 들은것중 완성도 있는
                        작품이었어요.</p>
                    <div class="review-info">
                        <span class="reviewer">hdjs.han1499</span>
                        <span class="review-date">2022-11-30</span>
                    </div>
                </div>
            </div>

            <button class="more-reviews">더보기</button>
        </div>
    </div>
</body>

</html>