<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.cdtrade.mapper.AlbumMapper"%>
<%@page import="kr.co.cdtrade.mapper.SaleMapper"%>
<%@page import="kr.co.cdtrade.mapper.OrderMapper"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.vo.Order"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//String userNo = (String) session.getAttribute("LOGINED_USER_NO");

	int no = StringUtils.strToInt(request.getParameter("no"));
	int price = StringUtils.strToInt(request.getParameter("price"));
	int deliveryFee = StringUtils.strToInt(request.getParameter("deliveryFee"));
	String paymentMethod = request.getParameter("paymentMethod");
	String status = request.getParameter("status");
	int addrNo = StringUtils.strToInt(request.getParameter("addrNo"));
	int saleNo = StringUtils.strToInt(request.getParameter("saleNo"));
	int albumNo = StringUtils.strToInt(request.getParameter("albumNo"));
	int userNo = StringUtils.strToInt(request.getParameter("userNo"));
	
	Order order = new Order();   
	order.setNo(no);  
	order.setPrice(price);
	order.setDeliveryFee(deliveryFee);
	order.setStatus(status);
	order.setAddressNo(addrNo);
	order.setSaleNo(saleNo);
	order.setAlbumNo(albumNo);
	order.setuserNo(userNo);  
	 
	
	OrderMapper orderMapper = MybatisUtils.getMapper(OrderMapper.class);
	orderMapper.insertOrder(order);		
	int avgOrderPrice = orderMapper.getOrderAvgPriceByAlbumNo(albumNo);
	
	SaleMapper saleMapper = MybatisUtils.getMapper(SaleMapper.class);
	saleMapper.updateSaleIsSold(saleNo);
	int avgSalePrice = saleMapper.getSaleAvgPriceByAlbumNo(albumNo);
	Map<String, Object> condition = new HashMap<>();
	condition.put("avgOrderPrice", avgOrderPrice); 
	condition.put("avgSalePrice", avgSalePrice); 
	condition.put("recentOrderPrice", price); 
	condition.put("albumNo", albumNo); 
	
	AlbumMapper albumMapper = MybatisUtils.getMapper(AlbumMapper.class);
	albumMapper.updateAlbumPrice(condition);
	
	response.sendRedirect("order-complete.jsp?ono=" + order.getNo());
%>