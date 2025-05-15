<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int userNo = 1; // 테스트용, 실제 사용 시 세션에서 받아와야 함.

    String status = request.getParameter("status");
    String isSold = (status != null && "completed".equals(status)) ? "t" : "f";
    String period = request.getParameter("period");
    String keyword = request.getParameter("keyword");

    int pageNo = Integer.parseInt(request.getParameter("page"));
    int size = Integer.parseInt(request.getParameter("size"));

    // ✅ Mapper 호출 준비
    SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);

    // ✅ Param 설정
    Map<String, Object> param = new HashMap<>();
    param.put("userNo", userNo);
    param.put("isSold", isSold);
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
