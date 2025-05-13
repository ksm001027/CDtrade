<%@page import="kr.co.cdtrade.vo.Review"%>
<%@page import="kr.co.cdtrade.mapper.ReviewMapper"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int albumNo = StringUtils.strToInt(request.getParameter("albumNo"));
	int offset = StringUtils.strToInt(request.getParameter("offset"));
	int rows = StringUtils.strToInt(request.getParameter("rows"));
	
	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
	List<Review> reviews = reviewMapper.searchReviewsByAlbumNo(albumNo, offset, rows);
	
	Gson gson = new Gson();
	String json = gson.toJson(reviews);
	
	out.write(json);
%>