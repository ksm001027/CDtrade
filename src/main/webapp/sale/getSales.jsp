<%@page contentType="application/json;charset=UTF-8" %>
<%@page import="java.util.*, com.google.gson.Gson, com.google.gson.JsonArray, com.google.gson.JsonObject" %>
<%@page import="kr.co.cdtrade.mapper.SalesMapper" %>
<%@page import="kr.co.cdtrade.utils.MybatisUtils" %>
<%@page import="kr.co.cdtrade.utils.StringUtils" %>
<%@page import="kr.co.cdtrade.vo.Sale" %>

<%
	int maxTitleLength = 40;	

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

        String albumTitle = sale.getAlbumTitle();
        // ✅ 서버에서 문자열 자르기 처리
        if (albumTitle.length() > maxTitleLength) {
            albumTitle = albumTitle.substring(0, maxTitleLength) + "...";
        }
        
        JsonObject obj = new JsonObject();
        obj.addProperty("photoPath", sale.getPhotoPath());
        obj.addProperty("price", String.format("%,d", sale.getPrice()));
        obj.addProperty("isOpened", sale.getIsOpened());
        obj.addProperty("albumTitle", albumTitle);
        obj.addProperty("albumNo", sale.getAlbum().getNo());
        obj.addProperty("saleNo", sale.getNo());

        jsonArray.add(obj);
    }

    out.print(jsonArray.toString());
    
    
%>
