<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이컬렉션</title>
    <link rel="stylesheet" href="resources/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>
    <div class="mycollection-title">마이컬렉션</div>
    <div class="mycollection-header">
        <div class="list-header">
            <div class="total-items">
                <i class="fas fa-check-circle" style="font-size:1rem;"></i>
                선택
            </div>
            <button class="sort-button" id="sortButton">
                <span>신규등록순</span>
                <i class="fas fa-chevron-down"></i>
            </button>
        </div>
    </div>

    <div class="mycollection-grid">
        <div class="mycollection-card">
            <img class="mycollection-album-img"
                src="https://upload.wikimedia.org/wikipedia/en/2/2c/Metallica_-_Metallica_cover.jpg" alt="Metallica">
            <div class="mycollection-card-overlay">
                <div class="review-block-rating">
                    <div class="stars">
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star filled">★</span>
                        <span class="star">★</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="mycollection-card">
            <img class="mycollection-album-img" src="https://image.yes24.com/goods/92147169/XL" alt="Pink Floyd">
            <div class="mycollection-card-overlay">
                <div class="mycollection-rating">
                    <div class="review-block-rating">
                        <div class="stars">
                            <span class="star filled">★</span>
                            <span class="star filled">★</span>
                            <span class="star filled">★</span>
                            <span class="star filled">★</span>
                            <span class="star">★</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="mycollection-card">
            <img class="mycollection-album-img"
                src="https://upload.wikimedia.org/wikipedia/en/a/a0/Blonde_-_Frank_Ocean.jpeg" alt="Blonde">
            <div class="mycollection-card-overlay">
                <div class="mycollection-rating"><i class="fas fa-star"></i> 4.7</div>
            </div>
        </div>
        <div class="mycollection-card">
            <img class="mycollection-album-img"
                src="https://upload.wikimedia.org/wikipedia/en/b/b7/NirvanaNevermindalbumcover.jpg" alt="Nirvana">
            <div class="mycollection-card-overlay">
                <div class="mycollection-rating"><i class="fas fa-star"></i> 4.6</div>
            </div>
        </div>
        <div class="mycollection-card">
            <img class="mycollection-album-img"
                src="https://upload.wikimedia.org/wikipedia/en/7/7f/My_Bloody_Valentine_-_Loveless.png" alt="Loveless">
            <div class="mycollection-card-overlay">
                <div class="mycollection-rating"><i class="fas fa-star"></i> 4.5</div>
            </div>
        </div>
        <div class="mycollection-card">
            <img class="mycollection-album-img"
                src="https://upload.wikimedia.org/wikipedia/en/6/6b/Radioheadthebends.png" alt="Radiohead The Bends">
            <div class="mycollection-card-overlay">
                <div class="mycollection-rating"><i class="fas fa-star"></i> 4.4</div>
            </div>
        </div>
        <div class="mycollection-card">
            <img class="mycollection-album-img"
                src="https://upload.wikimedia.org/wikipedia/en/a/a1/Radiohead.okcomputer.albumart.jpg"
                alt="Radiohead OK Computer">
            <div class="mycollection-card-overlay">
                <div class="mycollection-rating"><i class="fas fa-star"></i> 4.9</div>
            </div>
        </div>
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
                    <li class="sort-item active">신규등록순</li>
                    <li class="sort-item">인기순</li>
                    <li class="sort-item">높은가격순</li>
                    <li class="sort-item">낮은가격순</li>
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
                // 기존 활성화된 항목에서 active 클래스 제images거
                document.querySelector('.sort-item.active').classList.remove('active');
                // 클릭된 항목에 active 클래스 추가
                item.classList.add('active');
                // 정렬 버튼의 텍스트 업데이트
                sortButton.querySelector('span').textContent = item.textContent;
                // 모달 닫기
                sortModal.classList.remove('show');
            });
        });
    </script>
</body>

</html>