<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.cdtrade.vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.OrderMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int albumNo = StringUtils.strToInt(request.getParameter("albumNo"));
	int offset = StringUtils.strToInt(request.getParameter("offset"));
	int rows = StringUtils.strToInt(request.getParameter("rows"));
	
	OrderMapper orderMapper = MybatisUtils.getMapper(OrderMapper.class);
	List<Order> orders = orderMapper.getOrdersByAlbumNo(albumNo, offset, rows);
	
	Gson gson = new Gson();
	String json = gson.toJson(orders);
	
	out.write(json);
%>