package kr.co.cdtrade.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.co.cdtrade.vo.Album;

public interface AlbumGenreMapper {
	void insertAlbumGenre(@Param("albumNo") int albumNo, @Param("genreNo") int genreNo);
	
	List<Integer> getGenreNosByAlbumNo(int albumNo); 
	
	/**
	 * 특정 장르에 속하는 앨범 정보를 반환한다 
	 * @param condition의 요소들 rows. offset. genreNo, sort
	 * @return
	 */
	List<Album> getAlbumsByGenreNo(Map<String, Object> condition); 
	
	/**
	 * 조건에 맞는 행의 개수를 반환한다 
	 * @param condition의 요소들 gernreNo
	 * @return
	 */
	int getTotalRows(Map<String, Object> condition);
	
}

