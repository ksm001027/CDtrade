<%@page import="kr.co.cdtrade.mapper.AlbumMapper"%>
<%@page import="kr.co.cdtrade.vo.User"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@page import="kr.co.cdtrade.vo.Album"%>
<%@page import="kr.co.cdtrade.vo.Review"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.ReviewMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
	
		- 리뷰 추가 
		- album의 reviewCount , avgRating 변경 
	*/
	double rating = Double.parseDouble(request.getParameter("rating"));
	int albumNo = StringUtils.strToInt(request.getParameter("albumNo"));
	String content = request.getParameter("content");
	// int userNo = (int) session.getAttribute("LOGINED_USER_NO");
	int userNo = 1;
	
	Review review = new Review();
	review.setRating(rating);
	review.setContent(content);
	
	Album album = new Album();
	album.setNo(albumNo);
	review.setAlbum(album);
	
	User user = new User();
	user.setNo(userNo);
	review.setUser(user);
	
	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
	reviewMapper.insertReview(review);
	
	response.sendRedirect("../album/detail.jsp?albumNo=" + albumNo);
	
	// 앨범번호로 앨범 조회 
	// 앨범 reviewCount 와 avgRating 변경 및 적용 
	AlbumMapper albumMapper = MybatisUtils.getMapper(AlbumMapper.class);
	album = albumMapper.getAlbumByNo(albumNo);
	
	double oldAvg = album.getAvgRating();
	int oldCount = album.getReviewCount();
	double newAvg = (oldAvg*oldCount + rating) / (oldCount + 1); 
	
	album.setReviewCount(oldCount + 1);
	album.setAvgRating((newAvg));
	
	albumMapper.updateAlbum(album);
%>