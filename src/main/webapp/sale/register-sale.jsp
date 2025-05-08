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
	int no = StringUtils.strToInt(request.getParameter("no"), 0);
	int price = StringUtils.strToInt(request.getParameter("price"));
	String priceParam = request.getParameter("price");
	String description = request.getParameter("description");
	String photoPath = request.getParameter("photoPath");
	int userNo = (int) session.getAttribute("LOGINED_USER_NO");
	int albumNo = StringUtils.strToInt(request.getParameter("ano"));

	
	SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);
	
	Sale savedSale = salesMapper.getSaleBySaleNo(no);
	if (savedSale != null) {
		response.sendRedirect("register-form.jsp?fail=no");
	}
	
	Sale sale = new Sale();
	User user = new User();
	Album album = new Album();
	sale.setNo(no);
	sale.setPrice(price);
	sale.setDescription(description);
	sale.setPhotoPath(photoPath);
	user.setNo(userNo);
	sale.setUser(user);
	album.setNo(albumNo);
	sale.setAlbum(album);
	sale.setCreatedAt(new Date());
	sale.setUpdatedAt(new Date());
	sale.setIsOpened("Y");
	sale.setIsSold("N");
	sale.setViewCount(0);
	
	salesMapper.insertSale(sale);
	
	response.sendRedirect("sale-complete.jsp");
%>