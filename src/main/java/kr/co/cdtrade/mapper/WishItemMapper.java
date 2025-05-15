// mapper/WishItemMapper.java
package kr.co.cdtrade.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.co.cdtrade.vo.WishItem;

public interface WishItemMapper {

    // 사용자 ID로 위시리스트 아이템 조회
    List<WishItem> getItemsByUserId(@Param("userNo") int userNo);

    // 위시리스트 아이템 추가
    void addWishItem(WishItem item);

    // 위시리스트 아이템 삭제
    void deleteWishItem(@Param("wishNo") int wishNo);

    // 특정 앨범이 사용자의 위시리스트에 있는지 확인
    WishItem findByUserAndAlbum(@Param("userNo") int userNo, @Param("albumNo") int albumNo);

    // 정렬 옵션에 따른 위시리스트 아이템 조회
    List<WishItem> getItemsByUserIdSorted(
        @Param("userNo") int userNo,
        @Param("sortOption") String sortOption
    );

    // 총 위시리스트 아이템 개수 조회
    int countByUserId(@Param("userNo") int userNo);

    /*
      앨범번호에 따른 위시리스트 개수 조회
    */
    int getTotalRows(Map<String, Object> condition);
}