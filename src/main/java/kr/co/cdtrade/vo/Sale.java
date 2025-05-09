package kr.co.cdtrade.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Alias("Sale")
@NoArgsConstructor
public class Sale {

	private int no;
	private String description;
	private String photoPath;
	private int price;
	private String isOpened;
	private String isSold;
	private int viewCount;
	private User user;
	private Album album;
	private Date createdAt;
	private Date updatedAt;

}
