<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>구매내역</title>
    <link rel="stylesheet" href="../resources/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>
    <div class="container">
        <div class="sale-history-title">구매내역</div>
        <div class="sale-history-tabs">
            <button class="sale-history-tab"><span class="sale-history-tab-count">1</span>판매중</button>
            <button class="sale-history-tab"><span class="sale-history-tab-count">0</span>진행중</button>
            <button class="sale-history-tab active"><span class="sale-history-tab-count">2</span>판매완료</button>
        </div>
        <div class="sale-history-search-row">
            <div class="sale-history-search">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="앨범명, 가수명, 소속사명 등">
            </div>
            <div class="sale-history-periods">
                <button class="period-btn active">기간 전체</button>
                <button class="period-btn">최근 1일</button>
                <button class="period-btn">최근 1주일</button>
                <button class="period-btn">최근 1개월</button>
                <button class="period-btn">최근 3개월</button>
            </div>  
            <select class="sale-history-filter">
                <option>전체</option>
            </select>
        </div>
        <table class="sale-history-table">
            <thead>
                <tr>
                    <th style="width:40%">상품정보</th>
                    <th style="width:15%">상태</th>
                    <th style="width:15%">구매가</th>
                    <th style="width:15%">등록일</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <div class="sale-history-product">
                            <img src="https://image.yes24.com/goods/92147169/XL" alt="너드커넥션">
                            <div>
                                <span class="badge">미개봉</span>
                                너드커넥션 - 2021 신세기 명화극장 라…
                            </div>
                        </div>
                    </td>
                    <td><span class="sale-history-status">취소완료</span></td>
                    <td style="font-weight:bold;">230,000원</td>
                    <td>2023-12-16</td>
                </tr>
                <tr>
                    <td>
                        <div class="sale-history-product">
                            <img src="https://image.yes24.com/goods/92147169/XL" alt="데이먼스이어">
                            <div>
                                <span class="badge">미개봉</span>
                                데이먼스이어 - Mondegreeen
                            </div>
                        </div>
                    </td>
                    <td><span class="sale-history-status">취소완료</span></td>
                    <td style="font-weight:bold;">99,000원</td>
                    <td>2024-09-07</td>
                </tr>
            </tbody>
        </table>
        <div class="sale-history-pagination">
            <button class="sale-history-pagination-btn active">1</button>
        </div>
    </div>
</body>

</html>