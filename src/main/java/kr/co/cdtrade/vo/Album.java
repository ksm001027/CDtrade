package kr.co.cdtrade.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
@Alias("Album")
public class Album {
	private int no;
	private String title;
	private String artistName;
	private Date releaseDate;
	private String coverImageUrl;
<<<<<<< HEAD
	private double avgRating; 

=======
	private double avgRating;
>>>>>>> c4fec16f18b7a6c42560c02591e6cbf7b4310fc7
	private int reviewCount;
	private int stockQuantity;
	private int avgOrderPrice; // 구매평균가
	private int avgSalePrice; // 판매평균가
	private int releasePrice;
	private int recentOrderPrice; // 판매평균가
	private Date createdAt;
	private Date updatedAt;



}
