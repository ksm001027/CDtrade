<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@page import="kr.co.cdtrade.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils" %>
<%@ page import="kr.co.cdtrade.mapper.AddressMapper" %>
<%@ page import="kr.co.cdtrade.vo.Address" %>

<%
	Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
	if (userNo == null) {
		response.sendRedirect("../login/login-form.jsp");
		return;
	} 
	
	User user = new User();
	user.setNo(userNo);

	int saleNo = StringUtils.strToInt(request.getParameter("sno"));
	String addrNoStr = request.getParameter("addrNo");
	String isDefault = request.getParameter("isDefaultAddress") != null ? "t" : "f";
	
	Address address = new Address();
	address.setName(request.getParameter("addrName"));
	address.setReceiverName(request.getParameter("receiverName"));
	address.setReceiverTel(request.getParameter("receiverTel"));
	address.setAddrBasic(request.getParameter("addrBasic"));
	address.setAddrDetail(request.getParameter("addrDetail"));
	address.setZipCode(request.getParameter("zipCode"));
	address.setIsDefaultAddress(request.getParameter("isDefaultAddress") != null ? "t" : "f");
	address.setUser(user);

	AddressMapper addressMapper = MybatisUtils.getMapper(AddressMapper.class);
	
	if ("t".equals(isDefault)) {
		// 기본배송지로 설정한 경우, 다른 배송지들은 전부 기본 해제
		addressMapper.updateAllAddressToNonDefault(userNo);
	}
	
	if (addrNoStr != null && !addrNoStr.isEmpty()) {
		address.setNo(Integer.parseInt(addrNoStr));
		addressMapper.updateAddress(address);
	} else {
		addressMapper.insertAddress(address);
	}
	
	response.sendRedirect("order-form.jsp?sno="+saleNo);
%>
    