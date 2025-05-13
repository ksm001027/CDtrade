package kr.co.cdtrade.mapper;

import java.util.List;
import java.util.Map;

import kr.co.cdtrade.vo.Album;
import kr.co.cdtrade.vo.Genre;

public interface AlbumMapper {
	
	void insertAlbum(Album album);
	
	Album getAlbumByNo(int albumNo);
	
	void updateAlbum(Album album);
	/**
	 * 앨번번호를 전달받아서 해당 앨벙정보를 반환한다.
	 * @param no 앨번번호
	 * @return 앨범 상세정보
	 */
	Album getAlbumByAlbumNo(int no);
	
	/**
	 * 모든 앨범 정보를 조회해서 반환한다.
	 * @param condition의 요소 - minReviewCount, offset, rows, sort
	 * @return 앨범정보 목록
	 */
	List<Album> getAlbums(Map<String, Object> condition);
	
	/**
	 * 필터링 조건에 맞는 데이터의 개수 조회하기
	 * @param condition 필터링 조건
	 * @return 앨범정보 목록
	 */
	int getTotalRows(Map<String, Object> condition);
	
	/**
	 * 앨범번호를 받아서 장르를 조회하기
	 * @param albumNo
	 * @return 장르정보
	 */
	List<Genre> getGenreNameByAlbumNo(int albumNo);

}

