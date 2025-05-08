package kr.co.cdtrade.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface AlbumGenreMapper {
	void insertAlbumGenre(@Param("albumNo") int albumNo, @Param("genreNo") int genreNo);
	
	List<Integer> getGenreNosByAlbumNo(int albumNo); 
}

