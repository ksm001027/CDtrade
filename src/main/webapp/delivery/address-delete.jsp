<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils" %>
<%@ page import="kr.co.cdtrade.mapper.AddressMapper" %>

<%
	Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
	if (userNo == null) {
		response.sendRedirect("../login/login-form.jsp");
		return;
	}

	int addrNo = Integer.parseInt(request.getParameter("addrNo"));

	AddressMapper addressMapper = MybatisUtils.getMapper(AddressMapper.class);
	addressMapper.deleteAddress(addrNo);

	response.sendRedirect("delivery-form.jsp");
%>
