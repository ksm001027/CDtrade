package kr.co.cdtrade.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@Getter
@Setter
@NoArgsConstructor
@Alias("Review")
public class Review {

 private int no;
 private int rating;
 private String content;
 private User user;
 private Album album;
 private Date createdAt;
 private Date updatedAt;

}

