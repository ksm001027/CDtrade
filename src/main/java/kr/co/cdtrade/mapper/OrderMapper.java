package kr.co.cdtrade.mapper;

import kr.co.cdtrade.vo.Order;

public interface OrderMapper {

	void insertOrder(Order order);
	Order getOrderByNo(int no);

}
