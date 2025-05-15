<%@page import="kr.co.cdtrade.vo.User"%>
<%@page import="kr.co.cdtrade.vo.Album"%>
<%@page import="kr.co.cdtrade.mapper.SaleMapper"%>
<%@page import="kr.co.cdtrade.vo.Sale"%>
<%@page import="kr.co.cdtrade.utils.MybatisUtils"%>
<%@page import="kr.co.cdtrade.mapper.SalesMapper"%>
<%@page import="kr.co.cdtrade.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
if (session.getAttribute("LOGINED_USER_NO") == null) {
    session.setAttribute("LOGINED_USER_NO", 1);  // 테스트 계정 번호
}
	Integer loginedUserNo = (Integer) session.getAttribute("LOGINED_USER_NO");

	int saleNo = StringUtils.strToInt(request.getParameter("sno"));
	int albumNo = StringUtils.strToInt(request.getParameter("ano"));
	String description = request.getParameter("description");
	String photoPath = request.getParameter("photoPath");
	String isOpened = request.getParameter("sno");
	// ["url1", "url2"] 형태에서 []와 " 제거
	if (photoPath != null) {
	    photoPath = photoPath.replaceAll("\\[|\\]|\"", "");  // 정규식으로 [ ] " 제거
	}
	// 값 검증 및 변환
	if ("true".equalsIgnoreCase(isOpened)) {
	    isOpened = "t";
	} else if ("false".equalsIgnoreCase(isOpened)) {
	    isOpened = "f";
	}
	if (!"t".equals(isOpened) && !"f".equals(isOpened)) {
	    isOpened = "f"; // 잘못된 값 들어올 때 기본값
	}
	int price = StringUtils.strToInt(request.getParameter("price"));
	String accountNumber = request.getParameter("sno");

	SalesMapper salesMapper = MybatisUtils.getMapper(SalesMapper.class);
	
	 // 수정할 Sale 객체 생성 및 값 설정
    Sale sale = salesMapper.getSaleBySaleNo(saleNo);
    sale.setDescription(description);
    sale.setPhotoPath(photoPath);
    sale.setIsOpened(isOpened);
    sale.setPrice(price);

 // Album 정보 세팅 (album_no 필요)
    Album album = new Album();
    album.setNo(albumNo);
    sale.setAlbum(album);

    // User 정보 세팅 (user_no 필요)
    User user = new User();
    user.setNo(loginedUserNo);
    sale.setUser(user);
    
    // DB 업데이트 처리
    salesMapper.updateSaleBySaleNo(sale);

    // 수정 후 상세 페이지로 이동
    response.sendRedirect("sale-detail.jsp?sno=" + saleNo);
%>