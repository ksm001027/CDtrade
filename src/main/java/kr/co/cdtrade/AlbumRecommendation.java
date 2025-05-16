package kr.co.cdtrade;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import kr.co.cdtrade.mapper.AlbumMapper;
import kr.co.cdtrade.mapper.MyCollectionMapper;
import kr.co.cdtrade.mapper.ReviewMapper;
import kr.co.cdtrade.utils.MybatisUtils;
import kr.co.cdtrade.vo.Album;
import kr.co.cdtrade.vo.MyCollectionItem;
import kr.co.cdtrade.vo.Review;

public class AlbumRecommendation {
	public static void main(String[] args) {
		RecommendAlbumByOtherUser(21);
	}
	/*
	 * 해당 메소드를 실행하면 유사한 앨범 리스트를 결과로 반환 
	 * 
	 * 해당 유저의 no를 파라미터로 받음  
	 * 1. 해당 유저가 저장한 마이컬렉션 앨범 중 별점이 높은 상위 3개 앨범 가져오기 
	 * 		- 마이컬렉션에 앨범이 3개 이하라면 추천기능 제공하지 않음 
	 * 2. 그 앨범들에 별점을 남긴 다른 사용자들의 userNo 가져오기 
	 * 3. userNo를 돌면서 해당유저와 그 no유저의 코사인유사도를 계산 (기준은 해당 유저가 별점을남긴 앨범들. no유저가 해당 앨범에 리뷰를 남기지 않았다면 0으로 계산)
	 * 		- 모든 유저의 유사도가 너무 낮을때, 다른 알고리즘 고민 (간단하게 userNo 유저들이 높은 별점을 남긴 앨범중, 해당 유저의 마이컬렉션을 분석한 데이터(장르, 발매년도 등)와 가장 유사한 앨범 추천)
	 * 		- 유사도 기준 정하기 
	 * 4. 유저와 유사도가 높은 순서대로 topUserNo 3개 추출 
	 * 5. 그 topUserNo 유저들이 마이컬렉션에서 높은 별점을 매긴 앨범들 순서대로 조회하면서, 그 앨범이 해당 유저의 마이컬렉션에 존재하지 않는다면 추천앨범리스트에 추가 
	 * 		- 추천 앨범 리스트에 기준개수만큼 쌓일때까지 반복) 
	 * 6. 위 알고리즘에서 충분한 앨범데이터가 쌓이지 않았다면, 콘텐츠기반 추천 알고리즘 사용
	 */
	
	// 기준 유저의 마이컬렉션 앨범 중 비교에 사용하는 앨범의 개수 (별점이 높은 순으로 정렬)
	public static int TOP_RATED_ALBUMS_LIMIT = 3;
	public static int TOP_REVIEWERS_LIMIT = 20;
	public static int TOP_SIMILAR_USERS_LIMIT = 4;
	
	
	// 특정 기준 이상의 별점
	public static double MIN_SIMILAR_USER_RATING = 3;
	
	// 추천 앨범 수 
	public static int RECOMMEND_ALBUMS_LIMIT = 4;
	
	public static List<Album> RecommendAlbumByOtherUser(int userNo) {
		List<Album> recommendAlbums = new ArrayList<Album>();
		
		// 기준유저의 마이컬렉션에 저장되어있는 앨범들 가져오기 
		MyCollectionMapper myCollectionMapper = MybatisUtils.getMapper(MyCollectionMapper.class);
		List<MyCollectionItem> myItems = myCollectionMapper.getItemsByUserIdSorted(userNo, "rating");
		
		if(myItems.size() <= 3) {
			System.out.println("마이컬렉션에 3개이상의 앨범을 추가해주세요");
			return null;
		}
		// 기준유저가 마이컬렉션 앨범들에 남긴 별점만 map에 저장하기 
		// key: 앨범번호, value: 사용자가 남긴 별점 
		Map<Integer, Double> myRatings = new HashMap<>();
		for(MyCollectionItem myItem : myItems) {
			myRatings.put(myItem.getAlbum().getNo(), myItem.getReview().getRating());
		};
		
		// myAlbums 중 별점이 높은 상위 TOP_RATED_ALBUMS_LIMIT개 앨범을 topAlbums에 저장 
		List<Album> topAlbums = new ArrayList<Album>();
		for(int i = 0 ; i <TOP_RATED_ALBUMS_LIMIT ; i++) {
			topAlbums.add(myItems.get(i).getAlbum());
		}
		
		// 테스트 @@@@@@@@@@@@@@@@@@@ 
		for(Album topAlbum : topAlbums) {
			System.out.println("topAlbumNo : " + topAlbum.getNo());
		};
			 
		/* 
		 	topAlbums를 반복하며 → 그 앨범에 리뷰를 남긴 사용자를 별점순으로 TOP_REVIEWERS_LIMIT명 가져오기 (compareUsers)
		*/ 
		
		// 중복없이 비교 유저No를 저장하는 set 정의 
		Set<Integer> compareUserNos = new HashSet<>();
		
		ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
		for(Album topAlbum : topAlbums) {
			List<Review> reviews = reviewMapper.searchReviewsByAlbumNo(topAlbum.getNo(), 0, TOP_REVIEWERS_LIMIT, "rating");
			for(Review review : reviews) {
				if (review.getUser().getNo() != userNo) {
					compareUserNos.add(review.getUser().getNo());					
				}
			};
		};
		
//		System.out.println(compareUserNos);
		
		/*
		 	compareUserNos를 돌면서 기준 유저와 그 no유저의 코사인유사도를 계산하기 
		*/
		// compareUser와의 유사도를 저장하는 Map 
		// key - compareUserNo, value - 유사도
		Map<Integer, Double> similarities = new HashMap<Integer, Double>();
		
		for(Integer compareUserNo : compareUserNos) {
			// 한 compareUser가 myItems의 앨범들에 남긴 별점을 저장하는 Map
			//key: 앨범번호, value: 사용자가 남긴 별점 
			Map<Integer, Double> compareRatings = new HashMap<>();
			
			// 한 compareUser가 myItems의 앨범들에 남긴 별점 가져와서 compareRatings에 저장 
			for (MyCollectionItem myItem : myItems) {
				Review compareReview = reviewMapper.getReviewByAlbumNoAndUserNo(myItem.getAlbum().getNo(), compareUserNo);
				Double compareRating = 0.0;
				if (compareReview != null) {
					compareRating = compareReview.getRating();
				}
				compareRatings.put(myItem.getAlbum().getNo(), compareRating);
			}
			
			// myRatings와 compareRatings를 비교해서 코사인 유사도를 계산하기
			double similarity = calculateCosineSimilarity(myRatings, compareRatings);
			
			similarities.put(compareUserNo, similarity);
			
		}

		// 테스트 @@@@@@@@@@@@@@@@@@ 
		for (Integer key : similarities.keySet()) {
		    Double value = similarities.get(key);
		    System.out.println("Key: " + key + ", Value: " + value);
		}
		
		/*
		 	유사도가 특정 기준을 넘으면서, 가장 높은 상위 TOP_SIMILAR_USERS_LIMIT명의 compareUserNo를 topSimilarUserNos에 저장 
		 	스트림을 이용해서 Map을 정렬 
		 */
		List<Integer> topSimilarUserNos = new ArrayList<Integer>();
		similarities.entrySet().stream()
				.sorted((e1, e2) -> Double.compare(e2.getValue(), e1.getValue()))
				.limit(TOP_SIMILAR_USERS_LIMIT)
				.forEach(entry -> topSimilarUserNos.add(entry.getKey()));
		
		// 테스트 @@@@@@@@@@@@@@@@@@@ 
		for (Integer topUserNo : topSimilarUserNos) {
		    System.out.println("topUser : " + topUserNo);
		}
		
		/*
		 topSimilarUser가 리뷰를 남겼고 특정 별점 기준 이상을 준 앨범 중, 
		 기준 유저의 마이컬렉션에 추가되지 않은 앨범이 있다면 추천앨범에 추가
		 */
		for(Integer topSimilarUserNo : topSimilarUserNos) {
			// topSimilarUserNo가 남긴 리뷰를 별점순으로 가져오기 
			List<Review> similarUserReviews = reviewMapper.getReviewsByUserNoSortRating(topSimilarUserNo, MIN_SIMILAR_USER_RATING);
			
			// 테스트 @@@@@@@@@@@@@@@@@@ 
			for (Review similarUserReview : similarUserReviews) {
			    System.out.println("similarUserReview: " + similarUserReview.getAlbum().getTitle());
			}
		
			for(Review similarUserReview : similarUserReviews) {
				Album similarUserAlbum = similarUserReview.getAlbum();
				// myRatings의 key값에  similarUserAlbum.getNo()가 존재하지 않으면 (즉, 기준유저의 마이컬렉션에 해당 앨범이 없으면)
				// recommendAlbums에 앨범 추가 
				if (!myRatings.containsKey(similarUserAlbum.getNo())) {
		            // recommendAlbums에 앨범 추가
		            recommendAlbums.add(similarUserAlbum);
		        }
				
				 // 기준 개수에 도달하면 반복 종료
		        if (recommendAlbums.size() >= RECOMMEND_ALBUMS_LIMIT) {
		            break;
		        }
			} 
			
			 // 기준 개수에 도달하면 외부 반복도 종료
		    if (recommendAlbums.size() >= RECOMMEND_ALBUMS_LIMIT) {
		        break;
		    }
		}
		
		// 테스트 @@@@@@@@@@@@@@@@@@ 
		for (Album recommendAlbum : recommendAlbums) {
		    System.out.println("recommendAlbums: " + recommendAlbum.getTitle());
		}
				
		return recommendAlbums;
	}
	
	
	
	/**
	 * 코사인 유사도 계산 메서드
	 * @param myRatings
	 * @param compareRatings
	 * @return
	 */
	public static double calculateCosineSimilarity(Map<Integer, Double> myRatings, Map<Integer, Double> compareRatings) {
	    double dotProduct = 0.0;
	    double magnitudeMyRatings = 0.0;
	    double magnitudeCompareRatings = 0.0;

	    // 공통된 앨범의 평점을 기준으로 계산
	    for (Map.Entry<Integer, Double> entry : myRatings.entrySet()) {
	        int albumNo = entry.getKey();
	        double myRating = entry.getValue();
	        double compareRating = compareRatings.getOrDefault(albumNo, 0.0);

	        // 내적 계산
	        dotProduct += myRating * compareRating;

	        // 각 벡터 크기 계산
	        magnitudeMyRatings += myRating * myRating;
	        magnitudeCompareRatings += compareRating * compareRating;
	    }

	    // 벡터 크기가 0인 경우 유사도는 0
	    if (magnitudeMyRatings == 0 || magnitudeCompareRatings == 0) {
	        return 0.0;
	    }

	    // 코사인 유사도 계산
	    return dotProduct / (Math.sqrt(magnitudeMyRatings) * Math.sqrt(magnitudeCompareRatings));
	}
}
