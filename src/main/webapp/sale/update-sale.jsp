<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int saleNo = StringUtils.strToInt(request.getParameter("sno"));
	int albumNo = StringUtils.strToInt(request.getParameter("ano"));
	String description = request.getParameter("description");
	String photoPath = request.getParameter("sno");
	String isOpened = request.getParameter("sno");
	int price = StringUtils.strToInt(request.getParameter("price"));
	String accountNumber = request.getParameter("sno");

	SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);
	
	 // 수정할 Sale 객체 생성 및 값 설정
    Sale sale = new Sale();
    sale.setDescription(description);
    sale.setPhotoPath(photoPath);
    sale.setIsOpened(isOpened);
    sale.setPrice(price);

    // DB 업데이트 처리
    salesMapper.updateSaleBySaleNo(saleNo);

    // 수정 후 상세 페이지로 이동
    response.sendRedirect("sale-detail.jsp?sno=" + saleNo);
%>