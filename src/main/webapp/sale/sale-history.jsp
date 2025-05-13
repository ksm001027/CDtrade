<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@include file="../common/nav.jsp" %>
    <title>판매내역</title>
    <link rel="stylesheet" href="../resources/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
 	<style>
		a:link,
		a:visited,
		a:hover,
		a:active {
		    color: black; /* 방문 여부와 관계없이 항상 검정색 */
		    text-decoration: none;
		    font-weight: bold;
		}
	</style>
</head>

<body>
    <div class="container">
        <div class="sale-history-title">판매내역</div>
        <div class="sale-history-tabs">
            <button class="sale-history-tab active" data-status="onSale"><span class="sale-history-tab-count">1</span>판매중</button>
            <button class="sale-history-tab" data-status="completed"><span class="sale-history-tab-count">2</span>판매완료</button>
        </div>
        <div class="sale-history-search-row">
            <div class="sale-history-search">
                <i class="fas fa-search"></i>
                <input type="text" id="searchKeyword" placeholder="앨범명, 가수명, 소속사명 등">
            </div>
            <div class="sale-history-periods">
                <button class="period-btn active">기간 전체</button>
                <button class="period-btn">최근 1주일</button>
                <button class="period-btn">최근 1개월</button>
                <button class="period-btn">최근 3개월</button>
            </div>
        </div>
        <table class="sale-history-table">
            <thead>
                <tr>
                    <th style="width:40%">상품정보</th>
                    <th style="width:15%">상태</th>
                    <th style="width:15%">판매가</th>
                    <th style="width:15%">등록일</th>
                </tr>
            </thead>
            <tbody>
            
            </tbody>
        </table>
        <div class="sale-history-pagination">
            <button class="sale-history-pagination-btn active">1</button>
        </div>
    </div>
	<%@include file="../common/footer.jsp" %>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
let selectedPeriod = "all";  // 기본값
let currentPage = 1;         // 현재 페이지
function updateTabCounts() {
    const keyword = $("#searchKeyword").val();
    
    ["onSale", "completed"].forEach(status => {
        $.ajax({
            url: "fetchSaleHistory.jsp",
            type: "GET",
            data: {
                status: status,
                period: selectedPeriod,
                page: 1,
                size: 1, // 개수만 확인할 목적이므로 1개만 요청
                keyword: keyword
            },
            dataType: "json",
            success: function (data) {
                $(".sale-history-tab[data-status='" + status + "'] .sale-history-tab-count").text(data.totalCount);
            }
        });
    });
}

// 기간 버튼 클릭 처리
$(".period-btn").click(function () {
    $(".period-btn").removeClass("active");
    $(this).addClass("active");

    const text = $(this).text();
    selectedPeriod = text.includes("1주일") ? "1w"
                  : text.includes("1개월") ? "1m"
                  : text.includes("3개월") ? "3m"
                  : "all";

    currentPage = 1;
    updateTabCounts();
    $(".sale-history-tab.active").trigger("click");
});

// 검색 엔터 처리
$("#searchKeyword").on("keyup", function (e) {
    if (e.key === "Enter") {
        currentPage = 1;
        updateTabCounts();
        $(".sale-history-tab.active").trigger("click");
    }
});

$(document).ready(function () {
	updateTabCounts();
    $(".sale-history-tab").click(function () {
        $(".sale-history-tab").removeClass("active");
        $(this).addClass("active");

        const status = $(this).text().includes("판매중") ? "onSale" : "completed";
        const keyword = $("#searchKeyword").val();

        $.ajax({
            url: "fetchSaleHistory.jsp",
            type: "GET",
            data: {
                status: status,
                period: selectedPeriod,
                page: currentPage,
                size: 10,
                keyword: keyword
            },
            dataType: "json",
            success: function (data) {
                const tbody = $(".sale-history-table tbody").empty();
                const sales = data.data;
                const totalCount = data.totalCount;
                const totalPages = Math.ceil(totalCount / 10);

                if (status === "onSale") {
                    $(".sale-history-tab[data-status='onSale'] .sale-history-tab-count").text(data.totalCount);
                } else {
                    $(".sale-history-tab[data-status='completed'] .sale-history-tab-count").text(data.totalCount);
                }

                if (!sales || sales.length === 0) {
                    tbody.append(`<tr><td colspan="4" style="text-align:center;">판매내역이 없습니다.</td></tr>`);
                    $(".sale-history-pagination").empty();
                    return;
                }

                sales.forEach(item => {
                    const createdDate = new Date(item.createdAt).toLocaleDateString('ko-KR');
                    const shortDesc = item.description.length > 30 ? item.description.substring(0, 30) + '...' : item.description;
                    const shortTitle = item.album.title.length > 30 ? item.album.title.substring(0, 30) + '...' : item.album.title;

                    const row = `
                        <tr>
                            <td>
                                <div class="sale-history-product">
                                <a href="/CDtrade/sale/sale-detail.jsp?sno=\${item.no}">
                                    <img src="\${item.photoPath.split(',')[0]}" alt="상품 이미지" style="width:80px; height:80px; object-fit:cover; border-radius:8px;">
                                    <div style="margin-left:10px; display:inline-block; vertical-align:top;">
                                    <strong style="display:block; font-size:14px;">\${shortTitle}</strong>
                                </a>
                                    <span class="badge">\${item.isOpened == 't' ? '중고' : '미개봉'}</span><br>
                                    ${shortDesc}
                                    </div>
                                </div>
                            </td>
                            <td>\${item.isSold == 't' ? '판매완료' : '판매중'}</td>
                            <td style="font-weight:bold;">\${Number(item.price).toLocaleString()}원</td>
                            <td>\${createdDate}</td>
                        </tr>
                    `;
                    tbody.append(row);
                });

                // 페이지 버튼 생성
                const pagination = $(".sale-history-pagination").empty();
                for (let i = 1; i <= totalPages; i++) {
                    const btn = $("<button>")
                        .addClass("sale-history-pagination-btn")
                        .toggleClass("active", i === currentPage)
                        .text(i)
                        .on("click", function () {
					        currentPage = i;
					        $(".sale-history-tab.active").trigger("click");
					    });
                    pagination.append(btn);
                }
            },
            error: function () {
                alert("데이터 로드 실패");
            }
        });
    });

    // 페이지 로딩 시 기본 탭 자동 클릭
    $(".sale-history-tab.active").trigger("click");
});
</script>

</body>
</html>


