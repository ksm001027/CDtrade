<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");

    String status = request.getParameter("status");
    if (status == null || status.isEmpty()) {
        status = "all"; // ✅ 기본값 설정
    }
    String isSold = null;
    if ("onSale".equals(status)) {
        isSold = "f"; // 판매중
    } else if ("completed".equals(status)) {
        isSold = "t"; // 판매완료
    } 
    // "all"일 때는 isSold를 그대로 null로 유지 (전체 조회)
    String period = request.getParameter("period");
    String keyword = request.getParameter("keyword");
	
    int pageNo = 1;
    int size = 10;
    try{
    	pageNo = Integer.parseInt(request.getParameter("page"));
    	size = Integer.parseInt(request.getParameter("size"));
    } catch (NumberFormatException e) {
    	
    }
    // ✅ Mapper 호출 준비
    SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);
    
    // ✅ Param 설정
    Map<String, Object> param = new HashMap<>();
    param.put("userNo", userNo);
    if (isSold != null) {
    param.put("isSold", isSold);
    }
    param.put("period", (period != null && !"all".equals(period)) ? period : null);
    param.put("keyword", (keyword != null && !keyword.trim().isEmpty()) ? "%" + keyword.trim() + "%" : null);

    int totalCount = salesMapper.getTotalRows(param);
    int totalPages = (int) Math.ceil(totalCount / (double) size);

    // ✅ 페이지 번호 보정
    if (pageNo < 1) pageNo = 1;
    if (pageNo > totalPages && totalPages > 0) pageNo = totalPages;

    int offset = (pageNo - 1) * size;

    param.put("offset", offset);
    param.put("rows", size);

    // ✅ 데이터 조회
    List<Sale> salesList = salesMapper.getSalesByIsSoldAndUserNo(param);

    // ✅ JSON 응답 생성
    Map<String, Object> result = new HashMap<>();
    result.put("data", salesList);
    result.put("totalCount", totalCount);

    Gson gson = new Gson();
    out.write(gson.toJson(result));
%>
