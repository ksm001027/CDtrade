<%@page import="kr.co.cdtrade.vo.User"%>
<%@page import="kr.co.cdtrade.vo.Review"%>
<%@page import="kr.co.cdtrade.vo.Album"%>
<%@page import="kr.co.cdtrade.vo.MyCollectionItem"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.MyCollectionMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int albumNo = StringUtils.strToInt(request.getParameter("albumNo"));
	int reviewNo = StringUtils.strToInt(request.getParameter("reviewNo"));
	// int userNo = (int) session.getAttribute("LOGINED_USER_NO");
	int userNo = 1;
	
	MyCollectionMapper myCollectionMapper = MybatisUtils.getMapper(MyCollectionMapper.class);
	
	MyCollectionItem item = new MyCollectionItem();
	
	Album album = new Album();
	album.setNo(albumNo);
	item.setAlbum(album);
	
	Review review = new Review();
	review.setNo(reviewNo);
	item.setReview(review);
	
	User user = new User();
	user.setNo(userNo);
	item.setUser(user);
	
	myCollectionMapper.addCollectionItem(item);
%>