<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="kr.co.cdtrade.vo.Order"%>
<%@page import="kr.co.cdtrade.mapper.OrderMapper"%>
<%@page import="kr.co.cdtrade.vo.Address"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.AddressMapper"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%  
	int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
	
	String status = request.getParameter("status");
	String period = request.getParameter("period");
	String keyword = request.getParameter("keyword");
	Map<String, Object> condition = new HashMap<>();
	condition.put("status", status); 
	condition.put("period", period); 
	condition.put("userNo", userNo);
	
	if (keyword != null && !keyword.trim().isEmpty()) {
        keyword = "%" + keyword.trim() + "%";
    } else {
        keyword = null;
    }
	
	
	condition.put("keyword", keyword);
   
	OrderMapper orderMapper = MybatisUtils.getMapper(OrderMapper.class);
	List<Order> orders = orderMapper.getOrderByUserNo(condition);   
	
	Gson gson = new Gson();
	String json = gson.toJson(orders);
	
	out.write(json);       
%>