<%@page import="kr.co.cdtrade.mapper.MyCollectionMapper"%>
<%@page import="kr.co.cdtrade.vo.Album"%>
<%@page import="kr.co.cdtrade.mapper.AlbumMapper"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.ReviewMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
	요청 파라미터 : albumNo, reviewNo, rating
	
	요청처리절차 
	0. mycollection에 해당 리뷰번호를 가진 데이터가 있다면 삭제하기 
	1. reviewNo로 해당 리뷰 삭제 
	2. albumNo로 해당 리뷰가 달린 앨범을 조회 
	3. 앨범의 avgRating을 적절히 변경 후 수정 적용 
	
	*/

	
	int albumNo = StringUtils.strToInt(request.getParameter("albumNo"));
	int reviewNo = StringUtils.strToInt(request.getParameter("reviewNo"));
	double rating = Double.parseDouble(request.getParameter("rating"));
	
	// 마이컬렉션 아이템 삭제 
	MyCollectionMapper myCollectionMapper = MybatisUtils.getMapper(MyCollectionMapper.class);
	myCollectionMapper.deleteCollectionItemByReviewNo(reviewNo);
	
	// 리뷰 삭제
	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
	reviewMapper.deleteReviewByNo(reviewNo);
	
	
	// 앨범번호로 앨범 조회 
	// 앨범 reviewCount 와 avgRating 변경 및 적용 
	AlbumMapper albumMapper = MybatisUtils.getMapper(AlbumMapper.class);
	Album album = albumMapper.getAlbumByNo(albumNo);
	
	double oldAvg = album.getAvgRating(); 
	int oldCount = album.getReviewCount();
	int newCount = oldCount - 1;
	double newAvg = 0;
	if(newCount != 0){ // 해당 리뷰가 삭제된 후의 앨범 리뷰수가 0이라면, 평점도 0이 되게 설정 
		newAvg = (oldAvg*oldCount - rating) / (oldCount - 1); 	
	}
	
	album.setReviewCount(newCount);
	album.setAvgRating((newAvg));
	
	albumMapper.updateAlbum(album);
	

	response.sendRedirect("../album/detail.jsp?albumNo=" + albumNo);
%>