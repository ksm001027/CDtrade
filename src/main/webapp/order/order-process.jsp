<%@page import="kr.co.cdtrade.mapper.OrderMapper"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.vo.Order"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		    
	*/ 
	int no = StringUtils.strToInt(request.getParameter("no"));
	int price = StringUtils.strToInt(request.getParameter("price"));
	int deliveryFee = StringUtils.strToInt(request.getParameter("deliveryFee"));
	String paymentMethod = request.getParameter("paymentMethod");
	String status = request.getParameter("status");
	int addrNo = StringUtils.strToInt(request.getParameter("addrNo"));
	int saleNo = StringUtils.strToInt(request.getParameter("saleNo"));
	int albumNo = StringUtils.strToInt(request.getParameter("albumNo"));
	int userNo = StringUtils.strToInt(request.getParameter("userNo"));
	
   
	
	//String userNo = (String) session.getAttribute("LOGINED_USER_NO");
	 
	Order order = new Order();   
	order.setNo(no);  
	order.setPrice(price);
	order.setDeliveryFee(deliveryFee);
	order.setStatus(status);
	order.setAddressNo(addrNo);
	order.setSaleNo(saleNo);
	order.setAlbumNo(albumNo);
	order.setuserNo(userNo);  
	 
	//System.out.println("저장 전: " + order.getNo());
	
	OrderMapper orderMapper = MybatisUtils.getMapper(OrderMapper.class);
	orderMapper.insertOrder(order);		// 주문정보 저장
	//System.out.println("저장 후: " + order.getNo());
	
	
	response.sendRedirect("order-complete.jsp?ono=" + order.getNo());
%>