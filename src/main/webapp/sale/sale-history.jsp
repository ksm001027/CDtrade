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
                <input type="text" placeholder="앨범명, 가수명, 소속사명 등">
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
     
     let selectedPeriod = "all";  // 기본값: 기간 전체

  // 기간 버튼 클릭 처리
  $(".period-btn").click(function () {
      $(".period-btn").removeClass("active");
      $(this).addClass("active");

      // 버튼 텍스트로 기간 코드 설정
      const text = $(this).text();
      if (text.includes("1주일")) selectedPeriod = "1w";
      else if (text.includes("1개월")) selectedPeriod = "1m";
      else if (text.includes("3개월")) selectedPeriod = "3m";
      else selectedPeriod = "all";

      // 현재 활성화된 탭 자동 클릭 (데이터 다시 로드)
      $(".sale-history-tab.active").trigger("click");
  });


     
     $(document).ready(function() {

    	    // 탭 클릭시
    	    $(".sale-history-tab").click(function() {
    	        $(".sale-history-tab").removeClass("active");
    	        $(this).addClass("active");

    	        // 판매중 or 판매완료 구분
    	        const tabText = $(this).text().trim();
    	        const status = tabText.includes("판매중") ? "onSale" : "completed";

    	        // 서버에 ajax 요청
    	        $.ajax({
    	            url: "fetchSaleHistory.jsp",
    	            type: "GET",
    	            data: { status: status, 
    	            		period: selectedPeriod,
    	            		page : 1,
    	            		size: 10},
    	            dataType: "json", 
    	            success: function(data) {
    	                const tbody = $(".sale-history-table tbody");
    	                tbody.empty();

    	                const sales = data.data; // ✅ 여기서 배열 추출

    	                // ✅ 탭 카운트 업데이트
    	                if (status === "onSale") {
    	                    $(".sale-history-tab[data-status='onSale'] .sale-history-tab-count").text(sales.length);
    	                } else {
    	                    $(".sale-history-tab[data-status='completed'] .sale-history-tab-count").text(sales.length);
    	                }

    	                if (!sales || sales.length === 0) {
    	                    tbody.append(`<tr><td colspan="4" style="text-align:center;">판매내역이 없습니다.</td></tr>`);
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
    	            },
    	            error: function() {
    	                alert("데이터 로드 실패");
    	            }
    	        });
    	    });
    	    

    	    // 페이지 로딩 시 판매완료로 자동 클릭
    	    $(".sale-history-tab.active").trigger("click");
    	});
    </script>
</body>
</html>


