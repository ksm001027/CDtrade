<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.cdtrade.vo.Review"%>
<%@page import="kr.co.cdtrade.mapper.ReviewMapper"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	/*
		요청파라미터 : albumNo, offset, rows, sort
	*/
	int albumNo = StringUtils.strToInt(request.getParameter("albumNo"));
	int offset = StringUtils.strToInt(request.getParameter("offset"));
	int rows = StringUtils.strToInt(request.getParameter("rows"));
	String sort =request.getParameter("sort");
	
	Map<String, Object> condition = new HashMap<>();
	condition.put("albumNo", albumNo);
	condition.put("sort", sort);
	condition.put("offset", offset);
	condition.put("rows", rows);
	
	SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);
	List<Sale> sales = salesMapper.getSales(condition);
	
	Gson gson = new Gson();
	String json = gson.toJson(sales);
	
	out.write(json);
%>