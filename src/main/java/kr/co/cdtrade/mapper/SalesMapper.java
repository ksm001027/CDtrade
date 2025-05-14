package kr.co.cdtrade.mapper;

import java.util.List;
import java.util.Map;

import kr.co.cdtrade.vo.Album;
import kr.co.cdtrade.vo.Genre;
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
	
	/**
	 * 모든 판매정보를 조회해서 반환한다.
	 * @param 필터링 조건
	 * @return 판매정보 목록
	 */
	List<Sale> getSales(Map<String, Object> condition);
	
	/**
	 * 필터링 조건에 맞는 데이터의 개수 조회하기
	 * @param condition 필터링 조건
	 * @return 도서정보 목록
	 */
	int getTotalRows(Map<String, Object> condition);
	
}
