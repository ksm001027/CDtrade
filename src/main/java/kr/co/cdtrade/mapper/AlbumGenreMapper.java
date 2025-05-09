package kr.co.cdtrade.mapper;

import org.apache.ibatis.annotations.Param;

public interface AlbumGenreMapper {
	void insertAlbumGenre(@Param("albumNo") int albumNo, @Param("genreNo") int genreNo);
}

