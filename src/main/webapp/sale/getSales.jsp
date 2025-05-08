<%@page contentType="application/json;charset=UTF-8" %>
<%@page import="java.util.*, com.google.gson.Gson, com.google.gson.JsonArray, com.google.gson.JsonObject" %>
<%@page import="kr.co.cdtrade.mapper.SalesMapper" %>
<%@page import="kr.co.cdtrade.utils.MybatisUtils" %>
<%@page import="kr.co.cdtrade.utils.StringUtils" %>
<%@page import="kr.co.cdtrade.vo.Sale" %>

<%
    int pageNo = StringUtils.strToInt(request.getParameter("page"), 1);
    int offset = (pageNo - 1) * 4;

    Map<String, Object> condition = new HashMap<>();
    condition.put("offset", offset);
    condition.put("rows", 4);

    SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);
    List<Sale> sales = salesMapper.getSales(condition);

    JsonArray jsonArray = new JsonArray();
    for (Sale sale : sales) {
        if (sale.getAlbum() == null) continue;  // ✅ 앨범 정보 없는 경우 생략

        JsonObject obj = new JsonObject();
        obj.addProperty("photoPath", sale.getPhotoPath());
        obj.addProperty("price", sale.getPrice());
        obj.addProperty("isOpened", sale.getIsOpened());
        obj.addProperty("albumTitle", sale.getAlbumTitle());
        obj.addProperty("albumNo", sale.getAlbum().getNo());

        jsonArray.add(obj);
    }

    out.print(jsonArray.toString());
%>
