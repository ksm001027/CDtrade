<%@page import="kr.co.cdtrade.vo.Album"%>
<%@page import="kr.co.cdtrade.vo.User"%>
<%@page import="kr.co.cdtrade.vo.WishItem"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.WishItemMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
     trimDirectiveWhitespaces="true"%>
<%
	int albumNo = StringUtils.strToInt(request.getParameter("albumNo"));
	int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
	
	WishItemMapper wishItemMapper = MybatisUtils.getMapper(WishItemMapper.class);
	WishItem item = new WishItem();
	User user = new User();
	user.setNo(userNo);
	item.setUser(user);
	
	Album album = new Album();
	album.setNo(albumNo);
	item.setAlbum(album);
	
	wishItemMapper.addWishItem(item);
	
	out.write(String.valueOf(item.getNo()));
%> 