package kr.co.cdtrade.mapper;

import kr.co.cdtrade.vo.Sale;

public interface SalesMapper {

	/**
	 * 신규 주문정보를 저장한다.
	 * @param order 주문정보
	 */
	void insertSale(Sale sale);
	
	/**
	 * 신규 주문상품정보를 저장한다.
	 * @param orderItem 주문상품정보
	 */
	void insertSaleItem(Sale sale);
}
