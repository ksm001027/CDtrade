package kr.co.cdtrade.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.co.cdtrade.vo.Order;

public interface OrderMapper {
	List<Order> getOrdersByAlbumNo(@Param("albumNo") int albumNo, @Param("offset") int offset, @Param("rows") int rows);
	
	int getTotalRows(Map<String, Object> condition);
	void insertOrder(Order order);
	Order getOrderByNo(int no);
	List<Order> getOrderByUserNo(Map<String, Object> condition);

	List<Order> getTotalRows(int no);

	List<Order> getOrders(Map<String, Object> condition);

}
