package kr.co.cdtrade.mapper;

import kr.co.cdtrade.vo.Sale;

public interface SaleMapper {

	int getSaleAvgPriceByAlbumNo(int no);
	Sale getSaleByNo(int no);
	void updateSaleIsSold(int no);
	

}
