<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@ page import="kr.co.cdtrade.mapper.WishItemMapper"%>
<%@ page import="kr.co.cdtrade.vo.User"%>

<%
int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");

String wishNoParam = request.getParameter("wishNo");
if (wishNoParam == null || wishNoParam.isEmpty()) {
    response.setContentType("text/plain");
    out.print("invalid");
    return;
}

try {
    int wishNo = Integer.parseInt(wishNoParam);
    
    WishItemMapper wishItemMapper = MybatisUtils.getMapper(WishItemMapper.class);
    wishItemMapper.deleteWishItem(wishNo);
    
    response.setContentType("text/plain");
    out.print("success");
} catch (Exception e) {
    e.printStackTrace();
    response.setContentType("text/plain");
    out.print("error");
}
%>