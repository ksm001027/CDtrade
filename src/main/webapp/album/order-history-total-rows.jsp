<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.OrderMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
<%
	int albumNo = StringUtils.strToInt(request.getParameter("albumNo"));
	
	Map<String, Object> condition = new HashMap<>();
	condition.put("albumNo", albumNo);

	OrderMapper orderMapper = MybatisUtils.getMapper(OrderMapper.class);
	int totalOrderRows = orderMapper.getTotalRows(condition);
	
	out.print(totalOrderRows); // write 대신 print를 사용 -> out.print()도 클라이언트(브라우저)로 응답을 반환하는 것. 모든 타입을 문자열로 변환해서 출력
%>
