<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="kr.co.cdtrade.utils.MybatisUtils" %>
<%@ page import="kr.co.cdtrade.mapper.AddressMapper" %>
<%@ page import="kr.co.cdtrade.vo.Address" %>

<%
	Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
	if (userNo == null) {
		response.sendRedirect("../login/login-form.jsp");
		return;
	}

	AddressMapper addressMapper = MybatisUtils.getMapper(AddressMapper.class);
	List<Address> addresses = addressMapper.getAllAddressByUserNo(userNo);
%>

<div class="address-list">
	<% if (addresses == null || addresses.isEmpty()) { %>
		<div class="address-item">등록된 배송지가 없습니다.</div>
	<% } else { 
		for (Address addr : addresses) { %>
			<div class="address-item">
				<div>
					<span class="address-name"><%= addr.getName() %></span>
					<% if ("t".equalsIgnoreCase(addr.getIsDefaultAddress())) { %>
						<span class="address-basic">(기본배송지)</span>
					<% } %>
				</div>
				<div class="address-info"><%= addr.getZipCode() %></div>
				<div class="address-info"><%= addr.getAddrBasic() %> <%= addr.getAddrDetail() %></div>
				<div class="address-phone">
					<%= addr.getReceiverName() %> | <%= addr.getReceiverTel() %>
				</div>
				<button type="button" class="edit-address-btn address-btn"
					data-addr-no="<%= addr.getNo() %>"
					data-addr-name="<%= addr.getName() %>"
					data-receiver-name="<%= addr.getReceiverName() %>"
					data-receiver-tel="<%= addr.getReceiverTel() %>"
					data-zip-code="<%= addr.getZipCode() %>"
					data-addr-basic="<%= addr.getAddrBasic() %>"
					data-addr-detail="<%= addr.getAddrDetail() %>"
					data-is-default="<%= addr.getIsDefaultAddress() %>">
					수정
				</button>
				
				<form action="address-delete.jsp" method="post" style="display:inline;">
					<input type="hidden" name="addrNo" value="<%= addr.getNo() %>">
							<button type="submit" class="address-btn">삭제</button>
				</form>
			</div>
	<% 	}
		}
	%>
</div>
