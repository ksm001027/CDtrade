<%@page import="kr.co.cdtrade.vo.MyCollectionItem"%>
<%@page import="kr.co.cdtrade.mapper.MyCollectionMapper"%>
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
		요청 파라미터 
		albumNo, rating, content, isAddMyCollection
		
		- 리뷰 추가 
		- album의 reviewCount , avgRating 변경 
		- isAddMyCollection 이 true면 해당유저의 마이컬렉션에 데이터 추가 
	*/
	double rating = Double.parseDouble(request.getParameter("rating"));
	int albumNo = StringUtils.strToInt(request.getParameter("albumNo"));
	String content = request.getParameter("content");
	String isAddMyCollection = request.getParameter("isAddMyCollection") ;
	int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
	
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
	
	// 마이컬렉션에 데이터 추가하기  
	if("true".equals(isAddMyCollection)){
		MyCollectionMapper myCollectionMapper = MybatisUtils.getMapper(MyCollectionMapper.class);
		
		MyCollectionItem item = new MyCollectionItem();
		item.setAlbum(album);
		item.setReview(review);
		item.setUser(user);
		
		myCollectionMapper.addCollectionItem(item);
	}
	
	response.sendRedirect("../album/detail.jsp?albumNo=" + albumNo);
	
%>