<%@page import="kr.co.cdtrade.vo.Address"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.AddressMapper"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%  
	// String userId = (String) session.getAttribute("LOGINED_USER_ID");
	int userNo = 1;
   
	AddressMapper addressMapper = MybatisUtils.getMapper(AddressMapper.class);
	List<Address> addressList = addressMapper.getAllAddressByUserNo(userNo);  
	
	Gson gson = new Gson();
	String json = gson.toJson(addressList);
	
	// out은 jsp의 내장객체(JspWriter 객체)가 저장되어 있는 변수다.
	// JspWriter의 write(데이터) 메소드를 실행하면 데이터가 브라우저로 보내진다.
	out.write(json);       
%>