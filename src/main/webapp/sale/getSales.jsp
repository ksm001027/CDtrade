<%@ page contentType="application/json;charset=UTF-8" %>
<%@ page import="java.util.*, com.google.gson.Gson" %>
<%@ page import="kr.co.cdtrade.mapper.SalesMapper" %>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils" %>
<%@ page import="kr.co.cdtrade.utils.StringUtils" %>

<%
    int pageNo = StringUtils.strToInt(request.getParameter("page"), 1);
    String sort = StringUtils.nullToStr(request.getParameter("sort"), "newest");
    String isOpened = StringUtils.nullToStr(request.getParameter("isOpened"), "");
    String isSold = StringUtils.nullToStr(request.getParameter("isSold"), "");

    Map<String, Object> condition = new HashMap<>();
    condition.put("page", pageNo);
    condition.put("sort", sort);
    if (!isOpened.isEmpty()) condition.put("isOpened", isOpened);
    if (!isSold.isEmpty()) condition.put("isSold", isSold);
    condition.put("offset", (pageNo - 1) * 4);
    condition.put("rows", 4);

    SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);
    List<kr.co.cdtrade.vo.Sale> sales = salesMapper.getSales(condition);

    Gson gson = new Gson();
    out.print(gson.toJson(sales));
%>
