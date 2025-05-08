package kr.co.cdtrade.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Alias("Address")
public class Address {

	private int no;
	private String name;
	private String receiverName;
	private String receiverTel;
	private String addrBasic;
	private String addrDetail;
	private String zipCode;
	private String isDefaultAddress;
	private User user;
	private Date createdAt;
	private Date updatedAt;
}
