package kr.co.cdtrade.mapper;

import kr.co.cdtrade.vo.Album;

public interface AlbumMapper {
	void insertAlbum(Album album);
	
	Album getAlbumByNo(int albumNo);
	
	void updateAlbum(Album album);
}
