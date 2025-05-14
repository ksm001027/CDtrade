<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.mapper.UserMapper" %>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils" %>
<%@ page import="kr.co.cdtrade.utils.StringUtils" %>
<%
    int userNo = StringUtils.strToInt(request.getParameter("userNo"));
    String accountNumber = request.getParameter("accountNumber");

    UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
    userMapper.updateAccountNumber(userNo, accountNumber);

    // 돌아가기
    response.sendRedirect("sale-form.jsp?ano=" + request.getParameter("ano") + "&uno=" + userNo);
%>
