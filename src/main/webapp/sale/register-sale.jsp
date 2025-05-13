<%@page import="kr.co.cdtrade.vo.Album"%>
<%@page import="kr.co.cdtrade.vo.User"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	int userNo = 1;/* (int) userNoAttr; */
	int albumNo = StringUtils.strToInt(request.getParameter("ano"));
	String description = request.getParameter("description");
	String photoPath = request.getParameter("photoPath");
	int price = StringUtils.strToInt(request.getParameter("price"), 0);
	String isOpened = request.getParameter("isOpened");
	
	
	if (isOpened == null || isOpened.trim().isEmpty()) {
	    isOpened = "N";  // 기본값 설정: N (미개봉), 필요에 따라 "Y"로 설정
	}
	if (photoPath != null) {
	    photoPath = photoPath.replace("[", "").replace("]", "").replace("\"", "");
	}

	
	SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);
	
	Sale sale = new Sale();
	sale.setPrice(price);
	sale.setDescription(description);
	sale.setPhotoPath(photoPath);
	sale.setUserNo(userNo);
	sale.setAlbumNo(albumNo);
	sale.setIsOpened(isOpened);

	
	salesMapper.insertSale(sale);
	
	
	response.sendRedirect("sale-complete.jsp?sno=" + sale.getNo());
	
	

%>