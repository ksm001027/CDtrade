package kr.co.cdtrade.dto;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.google.gson.annotations.SerializedName;

import kr.co.cdtrade.vo.Album;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ToAlbumDto {
	private String title;
	private String author;
	private String pubDate;
	private String cover;
	private String categoryName;

	@SerializedName("priceStandard")
	private int priceStandard;


	/*
	 * toalbumDto의 값들을 저장한 album 객체를 반환하는메소드
	 */
	public Album toAlbum() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

		// String인 pubDate를 Date로 변환
		Date releaseDate = null;
		try {
			releaseDate = simpleDateFormat.parse(pubDate);
		} catch (ParseException e) {
			 System.out.println("날짜 형식이 잘못되었습니다: " + e.getMessage());
		}
		
		// cover를 coverSum에서 cover500으로 변환 
		cover = cover.replace("coversum", "cover500");
		
		Album album = new Album();
		album.setTitle(title);


		if(author == null || author.trim().isEmpty()) {
	        author = "Unknown Artist";
	    }
		album.setArtistName(author);
		album.setReleaseDate(releaseDate);
		album.setCoverImageUrl(cover);
		album.setReleasePrice(priceStandard);

		return album;
	}
}
