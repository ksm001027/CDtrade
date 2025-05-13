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

    JsonArray jsonArray = new JsonArray(); 
    Gson gson = new Gson();
    out.print(gson.toJson(sales));
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
