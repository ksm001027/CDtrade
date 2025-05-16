package kr.co.cdtrade.utils;

import java.util.List;
import java.util.Map;

import kr.co.cdtrade.mapper.AlbumGenreMapper;

/**
 * GenreMappingUtils는 알라딘 API로부터 수신한 장르 데이터를
 * 우리 서비스의 장르 체계에 맞게 변환하고,
 * 변환된 장르 정보를 ALBUM-GENRE 테이블에 저장하는 기능을 제공하는 유틸리티 클래스입니다.
 *
 * 주요 기능:
 * - 알라딘 API에서 제공하는 장르명을 서비스 내부 장르명으로 매핑
 * - 서비스 장르명에 해당하는 장르번호를 조회하여 데이터베이스에 저장
 * - 매핑되지 않은 장르는 '기타' 장르로 처리 ;
 *
 * 사용 예시:
 * GenreMappingUtils.mappingGenre(albumNo, categoryName);
 *
 * 구조:
 * - SERVICE_GENRE_NAME_TO_NO : 서비스 장르명과 장르번호를 매핑한 Map ;
 * - ALADIN_TO_SERVICE_GENRES : 알라딘 장르명과 서비스 장르명을 매핑한 Map ;
 * - mappingGenre(albumNo, categoryName) : 장르 매핑 및 데이터베이스 저장 메소드 ;
 */
public class GenreMappingUtils {

	/**
	 * DB의 장르번호와 장르이름을 매핑시켜주는 Map 상수
	 * (예시 : "클래식" : 1)
	 */
	public static Map<String, Integer> GENRE_NAME_TO_NO = Map.ofEntries(
				Map.entry("클래식", 1),
	            Map.entry("아이돌", 2),
	            Map.entry("댄스뮤직", 3),
	            Map.entry("락", 4),
	            Map.entry("RnB", 5),
	            Map.entry("발라드", 6),
	            Map.entry("기타", 7),
	            Map.entry("인디", 8),
	            Map.entry("일렉트로닉/하우스", 9),
	            Map.entry("재즈", 10),
	            Map.entry("포크", 11),
	            Map.entry("힙합", 12),
	            Map.entry("해외", 13),
	            Map.entry("JPOP", 14),
	            Map.entry("OST", 15)
			);

	/**
	 * DB의 장르번호와 장르이름을 매핑시켜주는 Map 상수
	 * (예시 : 1 -> "클래식")
	 */
	public static final Map<Integer, String> GENRE_NO_TO_NAME = Map.ofEntries(
	    Map.entry(1, "클래식"),
	    Map.entry(2, "아이돌"),
	    Map.entry(3, "댄스뮤직"),
	    Map.entry(4, "락"),
	    Map.entry(5, "RnB"),
	    Map.entry(6, "발라드"),
	    Map.entry(7, "기타"),
	    Map.entry(8, "인디"),
	    Map.entry(9, "일렉트로닉/하우스"),
	    Map.entry(10, "재즈"),
	    Map.entry(11, "포크"),
	    Map.entry(12, "힙합"),
	    Map.entry(13, "해외"),
	    Map.entry(14, "JPOP"),
	    Map.entry(15, "OST")
	);

	/**
	 * 알라딘 API에서 응답으로 받아온 장르와 우리 서비스의 장르를 매핑시켜주는 Map 상수 (예시 : "가요>발라드/R&B" : ["RnB", "발라드"])
	 */
	private static final Map<String, List<String>> ALADIN_TO_SERVICE_GENRES = Map.ofEntries(
		    Map.entry("가요>뉴에이지", List.of("클래식")),
		    Map.entry("가요>댄스뮤직", List.of("댄스뮤직")),
		    Map.entry("가요>록", List.of("락")),
		    Map.entry("가요>발라드/R&B", List.of("RnB", "발라드")),
		    Map.entry("가요>성인가요/트로트", List.of("발라드")),
		    Map.entry("가요>아티스트 관련상품(국내)", List.of("아이돌", "기타")),
		    Map.entry("가요>인디음악", List.of("인디")),
		    Map.entry("가요>일렉트로닉/하우스", List.of("일렉트로닉/하우스")),
		    Map.entry("가요>재즈/블루스", List.of("재즈")),
		    Map.entry("가요>포크음악", List.of("포크")),
		    Map.entry("가요>힙합", List.of("힙합")),
		    Map.entry("월드뮤직", List.of("해외")),    // 서브장르 없음
		    Map.entry("재즈", List.of("재즈")),
		    Map.entry("클래식", List.of("클래식")),
		    Map.entry("팝>록/모던록/얼터너티브", List.of("락", "해외")),
		    Map.entry("팝>메탈/하드코어", List.of("락", "해외")),
		    Map.entry("팝>아티스트 관련상품(국외)", List.of("기타", "해외")),
		    Map.entry("팝>일렉트로닉/하우스음악", List.of("일렉트로닉/하우스")),
		    Map.entry("팝>팝/댄스뮤직", List.of("댄스뮤직", "해외")),
		    Map.entry("팝>포크/컨트리/블루스", List.of("인디", "포크", "해외")),
		    Map.entry("팝>힙합", List.of("힙합", "RnB", "해외")),
		    Map.entry("팝>R&B/소울", List.of("힙합", "RnB", "해외")),
		    Map.entry("해외구매>J-POP", List.of("JPOP", "해외")),
		    Map.entry("해외구매>OST", List.of("OST"))
		);

	/**
	 * categoryName의 값에 따라 ALBUM-GENRE 테이블에 앨범이 속한 장르의 데이터를 INSERT해주는 메소드
	 * @param albumNo
	 * @param categoryName 알라딘 API에서 받아온 장르값 (예시 : "음반>가요>댄스뮤직")
	 */
	public static void mappingGenre(int albumNo, String categoryName) {

		// "음반>" 을 제거하기
		String genre = categoryName.substring(categoryName.indexOf(">") + 1); // "가요>댄스뮤직"


		// J-POP 처리: "해외구매>J-POP"인 경우 마지막 ">" 이후 제거
	    if (genre.startsWith("해외구매>J-POP")) {
	    	System.out.println("장르 : "+ genre);
	        genre = "해외구매>J-POP"; // "해외구매>J-POP"까지만 유지
	    }

	    // 장르가 특정 키워드로 시작하는 경우 처리
	    if (genre.startsWith("재즈") || genre.startsWith("월드뮤직") ||
	        genre.startsWith("클래식")) {
	        int delimiterIndex = genre.indexOf(">");
	        if (delimiterIndex != -1) {
	            genre = genre.substring(0, delimiterIndex); // ">" 앞부분까지만 남기기
	        }
	    }


		AlbumGenreMapper albumGenreMapper = MybatisUtils.getMapper(AlbumGenreMapper.class);

		// 알라딘의 장르와 우리 장르를 매핑하는 Map상수를 이용해서 알라딘 API의 장르를 우리 DB의 장르와 매핑시키기
		List<String> mappedGenres = ALADIN_TO_SERVICE_GENRES.get(genre);

		// albumNo와 genreNo로 insertAlbumGenre 작업 수행하기
		// genreNo는 장르 이름과 장르번호를 매핑하는 Map상수를 이용해서 획득
		if(mappedGenres != null) {
			for (String mappedGenre : mappedGenres) {
				albumGenreMapper.insertAlbumGenre(albumNo, GENRE_NAME_TO_NO.get(mappedGenre));
			}
		} else {
			// 카테고리가 존재히지 않으면 -> 기타 카테고리로 설정하기
			albumGenreMapper.insertAlbumGenre(albumNo, GENRE_NAME_TO_NO.get("기타"));
		}
	}
}
