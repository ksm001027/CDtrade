package kr.co.cdtrade.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.cdtrade.vo.MyCollectionItem;

public interface MyCollectionMapper {

    // 사용자 ID로 마이컬렉션 아이템 조회
    List<MyCollectionItem> getItemsByUserId(@Param("userNo") int userNo);

    // 마이컬렉션 아이템 추가
    void addCollectionItem(MyCollectionItem item);

    // 마이컬렉션 아이템 삭제
    void deleteCollectionItem(@Param("colNo") int colNo);

    // 리뷰번호로 마이컬렉션 아이템 삭제
    void deleteCollectionItemByReviewNo(@Param("reviewNo") int reviewNo);

    // 특정 앨범이 사용자의 컬렉션에 있는지 확인
    MyCollectionItem findByUserAndAlbum(@Param("userNo") int userNo, @Param("albumNo") int albumNo);

    // 정렬 옵션에 따른 마이컬렉션 아이템 조회
    List<MyCollectionItem> getItemsByUserIdSorted(
        @Param("userNo") int userNo,
        @Param("sortOption") String sortOption
    );

    // 총 컬렉션 아이템 개수 조회
    int countByUserId(@Param("userNo") int userNo);
}