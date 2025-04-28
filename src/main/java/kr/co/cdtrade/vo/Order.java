package kr.co.cdtrade.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Alias("Order")
@NoArgsConstructor
public class Order {

	private int no;
	private int price;
	private int deliveryFee;
	private String paymentMethod;
	private String status;
	private Date createdAt;
	private Date updatedAt;
	private Address address;
	private Sale sale;
	private Album album;
	private User user;
}
