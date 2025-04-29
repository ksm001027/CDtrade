<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매 목록</title>
    <link rel="stylesheet" href="resources/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>
    <div class="container">
        <!-- 검색바 -->
        <div class="search-bar">
            <i class="fas fa-search search-icon"></i>
            <input type="text" class="search-input" placeholder="앨범명, 가수명, 소속사명 등">
        </div>
        <br>

        <!-- 필터 버튼 -->
        <div class="filter-buttons">
            <button class="filter-button">
                미개봉
            </button>
            <button class="filter-button">
                중고
            </button>
            <button class="filter-button">
                판매완료상품 제외
            </button>
        </div>

        <!-- 목록 헤더 -->
        <div class="list-header">
            <div class="total-items">전체 2424개</div>
            <button class="sort-button" id="sortButton">
                <span>신규등록순</span>
                <i class="fas fa-chevron-down"></i>
            </button>
        </div>

        <!-- 앨범 그리드 -->
        <div class="album-grid">
            <!-- 앨범 카드 1 -->
            <div class="album-card">
                <img src="https://image.yes24.com/goods/92147169/XL" alt="HYBS - Making Steak" class="album-image">
                <div class="album-info">
                    <h3 class="album-title">HYBS - Making Steak (2024, Opaque Pink)</h3>
                    <div class="album-status">개봉</div>
                    <div class="album-price-label">구매가</div>
                    <div class="album-price">65,000원</div>
                </div>
            </div>

            <!-- 앨범 카드 2 -->
            <div class="album-card">
                <img src="https://image.yes24.com/goods/92147169/XL" alt="존박 - 정규 2집 PSST!" class="album-image">
                <div class="album-info">
                    <h3 class="album-title">존박 (John Park) - 정규 2집 PSST!</h3>
                    <div class="album-status">개봉</div>
                    <div class="album-price-label">구매가</div>
                    <div class="album-price">74,500원</div>
                </div>
            </div>

            <!-- 앨범 카드 3 -->
            <div class="album-card">
                <img src="https://image.yes24.com/goods/92147169/XL" alt="적재 - 2집 THE LIGHTS" class="album-image">
                <div class="album-info">
                    <h3 class="album-title">적재 - 2집 THE LIGHTS (실버)</h3>
                    <div class="album-status">개봉</div>
                    <div class="album-price-label">구매가</div>
                    <div class="album-price">45,000원</div>
                </div>
            </div>

            <!-- 앨범 카드 4 -->
            <div class="album-card">
                <img src="https://image.yes24.com/goods/92147169/XL" alt="루시 - 정규 10집" class="album-image">
                <div class="album-info">
                    <h3 class="album-title">루시드폴 - 정규 10집 목소리와 기타 (옐로우)</h3>
                    <div class="album-status">개봉</div>
                    <div class="album-price-label">구매가</div>
                    <div class="album-price">40,000원</div>
                </div>
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

        // 필터 버튼 기능
        const filterButtons = document.querySelectorAll('.filter-button');

        filterButtons.forEach(button => {
            button.addEventListener('click', () => {
                button.classList.toggle('active');
            });
        });
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</body>
</html>