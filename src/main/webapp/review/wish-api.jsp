<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils" %>
<%@ page import="kr.co.cdtrade.mapper.WishItemMapper" %>
<%@ page import="kr.co.cdtrade.vo.WishItem" %>
<%@ page import="kr.co.cdtrade.vo.User" %>
<%@ page import="kr.co.cdtrade.vo.Album" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>

<%
User loginUser = (User) session.getAttribute("loginUser");
if (loginUser == null) {
    out.print("{\"status\":\"error\",\"message\":\"로그인이 필요합니다.\"}");
    return;
}

String action = request.getParameter("action");
String albumParam = request.getParameter("albumNo");

if (albumParam == null || albumParam.isEmpty()) {
    out.print("{\"status\":\"error\",\"message\":\"앨범 번호가 없습니다.\"}");
    return;
}

int albumNo = Integer.parseInt(albumParam);
String jsonResponse = "";

try (SqlSession sqlSession = MybatisUtils.getSqlSession()) {
    WishItemMapper wishItemMapper = sqlSession.getMapper(WishItemMapper.class);

    if ("add".equals(action)) {
        WishItem existingItem = wishItemMapper.findByUserAndAlbum(loginUser.getNo(), albumNo);
        if (existingItem == null) {
            WishItem newItem = new WishItem();
            User user = new User();
            user.setNo(loginUser.getNo());

            Album album = new Album();
            album.setNo(albumNo);

            newItem.setUser(user);
            newItem.setAlbum(album);

            wishItemMapper.addWishItem(newItem);
            sqlSession.commit();  // ✅ 반드시 커밋 필요

            jsonResponse = "{\"status\":\"success\",\"message\":\"위시리스트에 추가되었습니다.\",\"isInWishlist\":true}";
        } else {
            jsonResponse = "{\"status\":\"info\",\"message\":\"이미 위시리스트에 있습니다.\",\"isInWishlist\":true}";
        }
    } else if ("remove".equals(action)) {
        WishItem existingItem = wishItemMapper.findByUserAndAlbum(loginUser.getNo(), albumNo);
        if (existingItem != null) {
            wishItemMapper.deleteWishItem(existingItem.getNo());
            sqlSession.commit();  // ✅ 반드시 커밋 필요
            jsonResponse = "{\"status\":\"success\",\"message\":\"위시리스트에서 제거되었습니다.\",\"isInWishlist\":false}";
        } else {
            jsonResponse = "{\"status\":\"info\",\"message\":\"위시리스트에 존재하지 않습니다.\",\"isInWishlist\":false}";
        }
    } else if ("check".equals(action)) {
        WishItem existingItem = wishItemMapper.findByUserAndAlbum(loginUser.getNo(), albumNo);
        jsonResponse = "{\"status\":\"success\",\"isInWishlist\":" + (existingItem != null) + "}";
    } else {
        jsonResponse = "{\"status\":\"error\",\"message\":\"잘못된 요청입니다.\"}";
    }
} catch (Exception e) {
    e.printStackTrace();
    jsonResponse = "{\"status\":\"error\",\"message\":\"서버 오류가 발생했습니다.\"}";
}

out.print(jsonResponse);
%>
