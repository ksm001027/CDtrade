<%@page import="kr.co.cdtrade.mapper.AlbumMapper"%>
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
		베스트 앨범 목록을 json으로 반환 
		genreNo == 0이면 -> albumMapper.getAlbums
		genreNo != 0이면 -> albumMapper.getAlbumsByGenreNo
		
		요청파라미터 : genreNo, offset, rows, sort, minReviewCount
	*/
	int genreNo = StringUtils.strToInt(request.getParameter("genreNo"));
	int offset = StringUtils.strToInt(request.getParameter("offset"));
	int rows = StringUtils.strToInt(request.getParameter("rows"));
	String sort =request.getParameter("sort");
	int minReviewCount = StringUtils.strToInt(request.getParameter("minReviewCount"));
	
	Map<String, Object> condition = new HashMap<>();
	condition.put("sort", sort);
	condition.put("offset", offset);
	condition.put("rows", rows);
	condition.put("minReviewCount", minReviewCount);
	
	
	List<Album> albums;
	if (genreNo == 0){
		AlbumMapper albumMapper = MybatisUtils.getMapper(AlbumMapper.class);
		albums = albumMapper.getAlbums(condition);		
	} else {
		condition.put("genreNo", genreNo);
		AlbumGenreMapper albumGenreMapper = MybatisUtils.getMapper(AlbumGenreMapper.class);
		albums = albumGenreMapper.getAlbumsByGenreNo(condition);	
	}
	
	Gson gson = new Gson();
	String json = gson.toJson(albums);
	
	out.write(json);
%>