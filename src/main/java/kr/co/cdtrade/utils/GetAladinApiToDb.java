package kr.co.cdtrade.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

import kr.co.cdtrade.dto.ToAlbumDto;
import kr.co.cdtrade.mapper.AlbumMapper;
import kr.co.cdtrade.vo.Album;


public class GetAladinApiToDb {

	/*
	 * 알라딘 API에서 받은 JSON 데이터를 파싱하여 Album 데이터를 insert하는 작업 수행
	 * 1. 알라딘 API에 요청 보내기
	 * 2. 받은 요청코드가 200이라면, 응답데이터 읽어오기
	 * 3. 응답 데이터 내에서 필요한 데이터 추출하기 (item 프로퍼티를 뽑아와야함)
	 * 4. item 리스트에서 필요한 데이터를 ToAlbumDto에 매핑하여 저장시키기 (title, author, pubDate, cover, categoryName, priceStandard)
	 * 5. ToAlbumDto를 이용해 필요한 값이 저장된 Album 객체를 획득하기 - ToAlbumDto의 toAlbum()메소드를 이용하기
	 * 6. 획득한 Album 객체를 AlbumMapper.insertAlbum을 이용해 데이터베이스에 저장하기
	 * 		ㄴ 저장된 데이터의 album_no를 자바 Album 객체의 no에 저장시켜야한다!!! 7번에서 사용하기 위함 (selectKey 활용)
	 * 7. GenreMappingUtils의 mappingGenre(albumNo, categoryName) 메소드를 실행해서 앨범-장르 테이블에 앨범의 장르 정보를 저장하기
	 * 		ㄴ mappingGenre메소드에 필요한 데이터 : toalbumDto 객체의 categoryName, Album 객체의 no
	 */
	public static void main(String[] args) throws IOException{

	  Map<String, Integer> musicMap = new HashMap<>();

        // Adding entries to the map
        musicMap.put("가요뉴에이지", 7738);
        musicMap.put("가요댄스뮤직", 5921);
        musicMap.put("가요록", 5922);
        musicMap.put("가요발라드/R&B", 5920);
        musicMap.put("가요성인가요/트로트", 5924);
        musicMap.put("가요아티스트 관련상품(국내)", 75392);
        musicMap.put("가요인디음악", 5925);
        musicMap.put("가요일렉트로닉/하우스", 36382);
        musicMap.put("가요재즈/블루스", 36384);
        musicMap.put("가요포크음악", 36383);
        musicMap.put("가요힙합", 5923);
        musicMap.put("월드뮤직", 79050);
        musicMap.put("재즈", 5916);
        musicMap.put("클래식", 5915);
        musicMap.put("팝록/모던록/얼터너티브", 6752);
        musicMap.put("팝메탈/하드코어", 6287);
        musicMap.put("팝아티스트 관련상품(국외)", 86971);
        musicMap.put("팝일렉트로닉/하우스음악", 5929);
        musicMap.put("팝팝/댄스뮤직", 5927);
        musicMap.put("팝포크/컨트리/블루스", 36385);
        musicMap.put("팝힙합", 5930);
        musicMap.put("팝R&B/소울", 36386);
        musicMap.put("J-pop", 70547);
        musicMap.put("O.S.T", 63212);

        for (Map.Entry<String, Integer> entry : musicMap.entrySet()) {

	        	//  요청 보내기
	        	URL url = new URL("http://www.aladin.co.kr/ttb/api/ItemList.aspx?ttbkey=ttbksm0010270919002"
	        			+ "&QueryType=Bestseller"
	        			+ "&MaxResults=50"
	        			+ "&start=1"
	        			+ "&SearchTarget=Music"
	        			+ "&output=js"
	        			+ "&Version=20131101"
	        			+ "&CategoryId="+entry.getValue());

	        	HttpURLConnection connection = (HttpURLConnection) url.openConnection();

	        	connection.setRequestMethod("GET");

	        	int responseCode = connection.getResponseCode();

	        	// 응답코드가 200이면, 데이터 파싱하는 작업 수행하기
	        	if(responseCode == HttpURLConnection.HTTP_OK) {
	        		BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
	        		String jsonData;


	        		while((jsonData = reader.readLine()) != null) {
	        			Gson gson = new Gson();
	        			JsonObject jsonObject = JsonParser.parseString(jsonData).getAsJsonObject();
	        			String itemsJson = jsonObject.get("item").toString();

	        			/*
	        			 * Java에서는 제네릭 타입(예: List<ToAlbumDto>) 정보를 런타임에 유지하지 않는다.
	        			 * 따라서 gson.fromJson(itemsJson, List<ToAlbumDto>.class)에서 Java의 클래스 객체(Class)는 제네릭 정보를 포함하지 않기 때문에 에러가 발생한다
	        			 *
	        			 * TypeToken: 제네릭 타입 정보를 런타임에 유지하기 위해 사용된다. 이를 통해 Gson은 List<MusicItem> 같은 복잡한 타입을 이해할 수 있다
	        			 */
	        			Type listType =  new TypeToken<List<ToAlbumDto>>() {}.getType();
	        			List<ToAlbumDto> albumDtoList = gson.fromJson(itemsJson, listType);

		        		System.out.println("요청장르" + entry.getKey());
		        		System.out.println("앨범개수" + albumDtoList.size());
		        		System.out.println("가져와진 장르이름" + albumDtoList.get(0).getCategoryName());

	        			AlbumMapper albumMapper = MybatisUtils.getMapper(AlbumMapper.class);

	        			// albumDto 객체로 받은 데이터를 album 객체로 변환하기 (날짜, 장르 변환도 포함)
	        			// mybatis mapper를 이용해서 insert SQL 실행
	        			for(ToAlbumDto albumDto : albumDtoList) {
	        				Album album = albumDto.toAlbum();

	        				albumMapper.insertAlbum(album);

	        				// album-genre테이블에 데이터 삽입하는 작업 수행
	        				GenreMappingUtils.mappingGenre(album.getNo(), albumDto.getCategoryName());
	        			}
	        		}
	        	} else {
	        		System.err.println("요청 실패 - 장르: " + entry.getKey() + ", 응답 코드: " + responseCode);
	        	}
	        	connection.disconnect();

	        	 // 요청 사이 지연 추가
	            try {
	                Thread.sleep(1000); // 1초 대기
	            } catch (InterruptedException e) {
	                Thread.currentThread().interrupt(); // 인터럽트 복구
	                System.err.println("쓰레드 대기 중단: " + e.getMessage());
	            }
        }
	}
}
