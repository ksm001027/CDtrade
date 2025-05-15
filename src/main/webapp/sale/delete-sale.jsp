<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    int saleNo = StringUtils.strToInt(request.getParameter("sno"));

    SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);
    salesMapper.deleteSaleBySaleNo(saleNo);
    

    // 삭제 후 목록 페이지로 리다이렉트
    response.sendRedirect("sale-list.jsp");
%>
