package kr.co.cdtrade.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Alias("SaleOption")
@NoArgsConstructor
public class SaleOption {

	private Sale sale;
	private Option option;


}
