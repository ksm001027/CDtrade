<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@ page import="kr.co.cdtrade.mapper.MyCollectionMapper"%>
<%@ page import="kr.co.cdtrade.vo.User"%>

<%
User loginUser = (User)session.getAttribute("loginUser");

if (loginUser == null) {
    response.setContentType("text/plain");
    out.print("unauthorized");
    return;
}

String colNoParam = request.getParameter("colNo");
if (colNoParam == null || colNoParam.isEmpty()) {
    response.setContentType("text/plain");
    out.print("invalid");
    return;
}

try {
    int colNo = Integer.parseInt(colNoParam);
    
    MyCollectionMapper myCollectionMapper = MybatisUtils.getMapper(MyCollectionMapper.class);
    myCollectionMapper.deleteCollectionItem(colNo);
    
    response.setContentType("text/plain");
    out.print("success");
} catch (Exception e) {
    e.printStackTrace();
    response.setContentType("text/plain");
    out.print("error");
}
%>