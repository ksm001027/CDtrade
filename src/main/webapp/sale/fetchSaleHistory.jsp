<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");

    int userNo = 1;

    String status = request.getParameter("status");
    String isSold = "completed".equals(status) ? "t" : "f";
    String period = request.getParameter("period");

    String keyword = request.getParameter("keyword");


    int pageNo = Integer.parseInt(request.getParameter("page"));
    int size = Integer.parseInt(request.getParameter("size"));
    int offset = (pageNo - 1) * size;

    // ✅ 여기에서 param 객체 생성해서 Mapper 호출
    Map<String, Object> param = new HashMap<>();
    param.put("userNo", userNo);
    param.put("isSold", isSold);
    param.put("offset", offset);
    param.put("rows", size);
    param.put("period", period);

    
    if (keyword != null && !keyword.trim().isEmpty()) {
        keyword = "%" + keyword.trim() + "%";
    } else {
        keyword = null;
    }
    param.put("keyword", keyword);


    SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);
    List<Sale> salesList = salesMapper.getSalesByIsSoldAndUserNo(param);  // 여기를 바꿨음!
    int totalCount = salesMapper.getTotalRows(param); // 필요 시 여기도 수정 필요

    Map<String, Object> result = new HashMap<>();
    result.put("data", salesList);
    result.put("totalCount", totalCount);

    Gson gson = new Gson();
    out.write(gson.toJson(result));
%>
