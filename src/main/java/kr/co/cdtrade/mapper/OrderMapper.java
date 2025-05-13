package kr.co.cdtrade.mapper;

import java.util.List;
import java.util.Map;

import kr.co.cdtrade.vo.Order;

public interface OrderMapper {

	void insertOrder(Order order);
	Order getOrderByNo(int no);
	List<Order> getOrderByUserNo(Map<String, Object> condition);

	List<Order> getTotalRows(int no);

	List<Order> getOrders(Map<String, Object> condition);

}
