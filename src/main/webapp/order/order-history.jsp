<%@page import="kr.co.cdtrade.utils.Pagination"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="kr.co.cdtrade.vo.Order"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.OrderMapper"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

%>      
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
            <button class="sale-history-tab active" id="tmp1"><span class="sale-history-tab-count">2</span>전체</button>
            <button class="sale-history-tab"><span class="sale-history-tab-count">0</span>진행중</button>
            <button class="sale-history-tab"><span class="sale-history-tab-count">2</span>구매완료</button>
        </div>
        <div class="sale-history-search-row">
            <div class="sale-history-search">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="앨범명, 가수명, 소속사명 등">
            </div>
            <div class="sale-history-periods">
                <button class="period-btn active">최근 1주일</button>
                <button class="period-btn">최근 1개월</button>
                <button class="period-btn">최근 3개월</button>
                <button class="period-btn">전체</button>
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
            <tbody id="address-list">
              
            </tbody>    
        </table>   
    </div>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
    
   
    	$.ajax({
			type: "get",		
			url: "order-history-ajax.jsp",
			dataType: "json",  
			success: function(result){
				//let $div = $("#address-list").empty();
				for (let item of result){
					let tr = `
			               <tr>
	                    		<td>
	                        		<div class="sale-history-product">
	                            		<img src="\${item?.album?.coverImageUrl}" alt="\${item?.album?.title}">
	                            		<div>
	                                		<span class="badge">
	                                		\${item?.sale?.isOpened}
	                                		</span>      
	                                		\${item?.album?.title}
	                            		</div>
	                        		</div>
	                    		</td>
	                    		<td><span class="sale-history-status">\${item?.status}</span></td>
	                    		<td style="font-weight:bold;">\${item?.price}원</td>
	                    		<td>\${item?.createdAt}</td>
	                		</tr>`
					
					$("#address-list").append(tr);
				}
			}});
				
    </script>
</body>

</html>