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
	// String userId = (String) session.getAttribute("LOGINED_USER_ID");
	int userNo = 1;
	String sort = "완료";
	Map<String, Object> condition = new HashMap<>();
	condition.put("sort", sort); 
	condition.put("userNo", userNo);
   
	OrderMapper orderMapper = MybatisUtils.getMapper(OrderMapper.class);
	List<Order> orders = orderMapper.getOrderByUserNo(condition);   
	Gson gson = new Gson();
	String json = gson.toJson(orders);
	
	out.write(json);       
%>