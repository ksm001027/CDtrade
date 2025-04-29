package kr.co.cdtrade.mapper;

import kr.co.cdtrade.vo.Album;
import kr.co.cdtrade.vo.Sale;

public interface SalesMapper {

	/**
	 * 신규 판매정보를 저장한다.
	 * @param order 주문정보
	 */
	void insertSale(Sale sale);

	/**
	 * 판매번호를 조회해서 판매정보를 반환한다.
	 * @param albumNo 앨범번호
	 */
	Sale getSaleBySaleNo(int no);
	
	/**
	 * 변경된 판매정보 전달받아서 테이블에 저장시킨다.
	 * @param sale
	 */
	void updateSale(Sale sale);
}
