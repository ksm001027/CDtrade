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
	private String isOpend;
	private String isSold;
	private int viewCount;
	private User user;
	private Album album;
	private Date createdAt;
	private Date updatedAt;

	public String getAlbumTitle() {
		return album.getTitle();
	}
	public String getArtistName() {
		return album.getArtistName();
	}
	public int getAlbumNo() {
		return album.getNo();
	}
	public int getUserNo() {
		return user.getNo();
	}

}
