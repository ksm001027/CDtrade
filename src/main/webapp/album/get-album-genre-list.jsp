<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.cdtrade.vo.Album"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.AlbumGenreMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		해당 장르를 가진 앨범 목록을 json으로 반환 
		
		요청파라미터 : genreNo, offset, rows, sort
	*/
	int genreNo = StringUtils.strToInt(request.getParameter("genreNo"));
	int offset = StringUtils.strToInt(request.getParameter("offset"));
	int rows = StringUtils.strToInt(request.getParameter("rows"));
	String sort =request.getParameter("sort");
	
	Map<String, Object> condition = new HashMap<>();
	condition.put("genreNo", genreNo);
	condition.put("sort", sort);
	condition.put("offset", offset);
	condition.put("rows", rows);
	
	AlbumGenreMapper albumGenreMapper = MybatisUtils.getMapper(AlbumGenreMapper.class);
	
	List<Album> albums = albumGenreMapper.getAlbumsByGenreNo(condition);
	
	Gson gson = new Gson();
	String json = gson.toJson(albums);
	
	out.write(json);
%>