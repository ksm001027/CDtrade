package kr.co.cdtrade.vo;

import java.util.Date;
import java.util.List;

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
	private Date createdAt;
	private Date updatedAt;
	private User user;
	private Album album;
	private List<Genre> genres;

	public String getAlbumTitle() {
		return album.getTitle(); 
	}
	public String getArtistName() {
		return album.getArtistName();
	}
	public Date getReleaseDate() {
		return album.getReleaseDate();
	}
	
	}
