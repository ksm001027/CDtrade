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
    <%@include file="../common/nav.jsp" %>
    <title>구매내역</title>
    <link rel="stylesheet" href="../resources/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>
    <div class="container">
        <div class="sale-history-title">구매내역</div>
        <div class="sale-history-tabs">
            <button class="sale-history-tab active" id="tmp1"><span class="sale-history-tab-count" id="allCount"></span>전체</button>
            <button class="sale-history-tab" id="tmp2"><span class="sale-history-tab-count" id="continueCount"></span>진행중</button>
            <button class="sale-history-tab" id="tmp3"><span class="sale-history-tab-count" id="completeCount"></span>구매완료</button>
        </div>
        <div class="sale-history-search-row">
            <div class="sale-history-search">
                <i class="fas fa-search"></i>
                <input type="text" id="search" placeholder="앨범명, 가수명">
            </div>
            <div class="sale-history-periods">
                <button class="period-btn active" id="pr1">최근 1주일</button>
                <button class="period-btn" id="pr2">최근 1개월</button>
                <button class="period-btn" id="pr3">최근 3개월</button>
                <button class="period-btn" id="pr4">전체</button>
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
    <%@include file="../common/footer.jsp" %>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
    	let status = "all";
    	let period = "1w";
    	let keyword = $("#search").val();
    	let completeCountValue = 0;
    	let continueCountValue = 0;
    function updatekeyword(){
    	keyword = $("#search").val();
    }	
    	
    
    function logic(){
    	$.ajax({
			type: "get",
			data: {
				status: status,
				period: period,
				keyword: keyword
			},
			url: "order-history-ajax.jsp",
			dataType: "json",  
			success: function(result){
				let $div = $("#address-list").empty();
				for (let item of result){
					let tr = `  
			               <tr>
	                    		<td>
	                        		<div class="sale-history-product">
	                            		<img src="\${item?.album?.coverImageUrl}" alt="\${item?.album?.title}">
	                            		<div>
	                                		<span class="badge">
	                                		\${item?.sale?.isOpened == 't' ? '개봉' : '미개봉'}
	                                		</span>      
	                                		\${item?.album?.title}
	                            		</div>
	                        		</div>
	                    		</td>
	                    		<td><span class="sale-history-status">\${item?.status}</span></td>
	                    		<td style="font-weight:bold;">\${item?.price.toLocaleString()}원</td>
	                    		<td>\${item?.createdAt}</td>
	                		</tr>`
					$("#address-list").append(tr);
				}
				//console.log(Object.keys(result).length);
			}});
    };
    
    $("#search").on("keyup", function (e) {
        if (e.key === "Enter") {
        	//let $div = $("#address-list").empty();
            updatekeyword();
            console.log(5);
            logic();
        }
    });
    
    function completeCount(){
    	$.ajax({
			type: "get",
			data: {
				status: "complete",
				period: "all",
				keyword: keyword
			},
			url: "order-history-ajax.jsp",
			dataType: "json",  
			success: function(result){		
				completeCountValue = Object.keys(result).length;
				$("#completeCount").text(Object.keys(result).length);
			}});
    };
    
    function continueCount(){
    	$.ajax({
			type: "get",
			data: {
				status: "continue",
				period: "all",
				keyword: keyword
			},
			url: "order-history-ajax.jsp",
			dataType: "json",  
			success: function(result){				
				continueCountValue =  Object.keys(result).length;
				$("#continueCount").text(Object.keys(result).length);
				$("#allCount").text(completeCountValue+continueCountValue);
			}});
    };
    
    completeCount();  
    continueCount();
    logic();
     
     $("#tmp1").click(function() {
   	  	//let $div = $("#address-list").empty();
   	  	status = "all";
   	  	$(".sale-history-tab").removeClass("active");
   	    $("#tmp1").addClass("active");
   	  	logic();
     });
    
     $("#tmp2").click(function() {
    	 //let $div = $("#address-list").empty();
    	 status = "continue";
    	 $(".sale-history-tab").removeClass("active");
    	 $("#tmp2").addClass("active");
    	 logic();
     });
     $("#tmp3").click(function() {
    	 //let $div = $("#address-list").empty();
    	 status = "complete";
    	 $(".sale-history-tab").removeClass("active");
    	 $("#tmp3").addClass("active");
    	 logic();
     });
     
     $("#pr1").click(function() {
    	 //let $div = $("#address-list").empty();
    	 period = "1w";
    	 $(".period-btn").removeClass("active");
    	 $("#pr1").addClass("active");
    	 logic();
     });
     $("#pr2").click(function() {
    	 //let $div = $("#address-list").empty();
    	 period = "1m";
    	 $(".period-btn").removeClass("active");
    	 $("#pr2").addClass("active");
    	 logic();
     });
     $("#pr3").click(function() {
    	 //let $div = $("#address-list").empty();
    	 period = "3m";
    	 $(".period-btn").removeClass("active");
    	 $("#pr3").addClass("active");
    	 logic();
     });
     $("#pr4").click(function() {
    	 //let $div = $("#address-list").empty();
    	 period = "all";
    	 $(".period-btn").removeClass("active");
    	 $("#pr4").addClass("active");
    	 logic();
     });
    </script>
</body>

</html>