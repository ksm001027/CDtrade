<%@page import="kr.co.cdtrade.vo.Album"%>
<%@page import="kr.co.cdtrade.mapper.AlbumMapper"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.ReviewMapper"%>
<%@page import="kr.co.cdtrade.vo.Review"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	/*
		요청 파라미터 : albumNo, reviewNo, rating, content
		
		요청처리절차 
		1. reviewNo로 해당 리뷰 조회
		2. 리뷰 객체 수정 후  updateReview로 리뷰 수정 
		3. albumNo로 해당 리뷰가 달린 앨범을 조회 
		4. 앨범의 avgRating을 적절히 변경 후 수정 적용 
	*/

	double newRating = Double.parseDouble(request.getParameter("rating"));
	String content = request.getParameter("content");
	int albumNo = StringUtils.strToInt(request.getParameter("albumNo"));
	
	int reviewNo = StringUtils.strToInt(request.getParameter("reviewNo")); 
	
	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
	
	Review review = reviewMapper.getReviewByNo(reviewNo);
	double oldRating = review.getRating();
	
	review.setRating(newRating);
	review.setContent(content);
	
	reviewMapper.updateReview(review);
	
	// 앨범번호로 앨범 조회 
	// 앨범 reviewCount 와 avgRating 변경 및 적용 
	AlbumMapper albumMapper = MybatisUtils.getMapper(AlbumMapper.class);
	Album album = albumMapper.getAlbumByNo(albumNo);
	
	double oldAvg = album.getAvgRating();
	int count = album.getReviewCount();
	
	double newAvg = (oldAvg*count - oldRating + newRating) / count; 	
	
	album.setAvgRating(newAvg);
	
	albumMapper.updateAlbum(album);
	
	response.sendRedirect("../album/detail.jsp?albumNo=" + albumNo);
%>