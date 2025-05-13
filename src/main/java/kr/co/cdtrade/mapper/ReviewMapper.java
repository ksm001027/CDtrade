package kr.co.cdtrade.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.cdtrade.vo.Review;

@Mapper
public interface ReviewMapper {

    /**
     * 모든 리뷰 정보를 반환한다.
     * @return 리뷰 목록
     */
    List<Review> getAllReviews();

    /**
     * 장르별 리뷰 정보를 반환한다.
     * @param genreNo 장르번호
     * @return 해당 장르의 리뷰 목록
     */
    List<Review> getReviewsByGenre(int genreNo);

    /**
     * 키워드로 리뷰 정보를 검색해서 반환한다.
     * @param keyword 검색어
     * @return 검색조건에 해당하는 리뷰 목록
     */
    List<Review> searchReviews(String keyword);

    /**
     * 페이징 처리된 리뷰 목록을 반환한다.
     * @param offset 조회 시작 위치
     * @param rows 조회할 행 개수
     * @return 리뷰 목록
     */
    List<Review> getReviewsByPage(@Param("offset") int offset, @Param("rows") int rows);

    /**
     * 장르별 페이징 처리된 리뷰 목록을 반환한다.
     * @param genreNo 장르번호
     * @param offset 조회 시작 위치
     * @param rows 조회할 행 개수
     * @return 해당 장르의 리뷰 목록
     */
    List<Review> getReviewsByGenreWithPage(@Param("genreNo") int genreNo,
                                         @Param("offset") int offset,
                                         @Param("rows") int rows);

    /**
     * 키워드로 검색한 페이징 처리된 리뷰 목록을 반환한다.
     * @param keyword 검색어
     * @param offset 조회 시작 위치
     * @param rows 조회할 행 개수
     * @return 검색조건에 해당하는 리뷰 목록
     */
    List<Review> searchReviewsWithPage(@Param("keyword") String keyword,
                                     @Param("offset") int offset,
                                     @Param("rows") int rows);

    /**
     * 전체 리뷰 수를 반환한다.
     * @return 전체 리뷰 수
     */
    int getTotalRows();

    /**
     * 장르별 리뷰 수를 반환한다.
     * @param genreNo 장르번호
     * @return 해당 장르의 리뷰 수
     */
    int getTotalRowsByGenre(int genreNo);

    /**
     * 검색 조건에 해당하는 리뷰 수를 반환한다.
     * @param keyword 검색어
     * @return 검색 조건에 해당하는 리뷰 수
     */
    int getTotalRowsByKeyword(String keyword);
}