package kr.co.cdtrade.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Alias("Option")
@NoArgsConstructor
public class Option {

	private int no;
	private String name;
	
}
