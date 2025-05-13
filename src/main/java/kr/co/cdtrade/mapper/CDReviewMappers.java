package kr.co.cdtrade.mapper;

import java.util.List;

import kr.co.cdtrade.vo.Review;

public interface CDReviewMappers {

    /**
     * 리뷰 등록
     * @param review 등록할 리뷰 정보
     * @return 성공 시 1, 실패 시 0
     */
    public int insertReview(Review review);

    /**
     * 모든 리뷰 목록 조회 (앨범 정보 포함)
     * @return 리뷰 목록
     */
    public List<Review> selectReviewList();

    /**
     * 특정 앨범의 리뷰 목록 조회
     * @param albumNo 앨범 번호
     * @return 해당 앨범의 리뷰 목록
     */
    public List<Review> selectReviewsByAlbumNo(int albumNo);

    /**
     * 특정 리뷰 상세 조회
     * @param reviewNo 리뷰 번호
     * @return 리뷰 정보
     */
    public Review selectReviewByNo(int reviewNo);

    /**
     * 특정 사용자의 리뷰 목록 조회
     * @param userNo 사용자 번호
     * @return 해당 사용자의 리뷰 목록
     */
    public List<Review> selectReviewsByUserNo(int userNo);

    /**
     * 리뷰 수정
     * @param review 수정할 리뷰 정보
     * @return 성공 시 1, 실패 시 0
     */
    public int updateReview(Review review);

    /**
     * 리뷰 삭제
     * @param reviewNo 삭제할 리뷰 번호
     * @return 성공 시 1, 실패 시 0
     */
    public int deleteReview(int reviewNo);

    /**
     * 전체 리뷰 개수 조회
     * @return 리뷰 총 개수
     */
    public int countReviews();

    /**
     * 특정 앨범의 평균 평점 계산
     * @param albumNo 앨범 번호
     * @return 평균 평점
     */
    public double calculateAvgRatingByAlbumNo(int albumNo);
}