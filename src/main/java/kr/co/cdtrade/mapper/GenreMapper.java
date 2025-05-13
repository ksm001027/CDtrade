package kr.co.cdtrade.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.cdtrade.vo.Genre;

@Mapper
public interface GenreMapper {

    /**
     * 모든 장르 정보를 반환한다.
     * @return 장르 목록
     */
    List<Genre> getAllGenres();

    /**
     * 지정된 장르번호에 해당하는 장르정보를 반환한다.
     * @param genreNo 장르번호
     * @return 장르정보
     */
    Genre getGenreByNo(int genreNo);
    
    
    int getReviewCountByGenre();
    
    int getTotalReviewCount();
}