package kr.co.cdtrade.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Alias("Order")
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

	public void setAddressNo(int no) {
		Address address = new Address();
		address.setNo(no);
		this.address = address;
	}

	public void setSaleNo(int no) {
		Sale sale = new Sale();
		sale.setNo(no);
		this.sale = sale;
	}

	public void setAlbumNo(int no) {
		Album album = new Album();
		album.setNo(no);
		this.album = album;
	}

	public void setuserNo(int no) {
		User user = new User();
		user.setNo(no);
		this.user = user;
	}

	public String getAlbumTitle() {
		return album.getTitle();
	}
	public String getArtistName() {
		return album.getArtistName();
	}
	public String getcoverImageUrl() {
		return album.getCoverImageUrl();
	}
	public String getaddrBasic() {
		return address.getAddrBasic();
	}
	public String getreceiverName() {
		return address.getReceiverName();
	}
	public String getreceiverTel() {
		return address.getReceiverTel();
	}
	public String getIsOpened() {
		return sale.getIsOpened();
	}




}
