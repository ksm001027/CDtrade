<%@page import="kr.co.cdtrade.vo.Address"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.AddressMapper"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%  
	int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
   
	AddressMapper addressMapper = MybatisUtils.getMapper(AddressMapper.class);
	List<Address> addressList = addressMapper.getAllAddressByUserNo(userNo);  
	
	Gson gson = new Gson();
	String json = gson.toJson(addressList);
	out.write(json);       
%>