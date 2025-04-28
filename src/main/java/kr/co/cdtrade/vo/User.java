package kr.co.cdtrade.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Alias("User")
@NoArgsConstructor
public class User {

	private int no;
	private String email;
	private String password;
	private String name;
	private String nickname;
	private String tel;
	private String isActive;
	private String accountNumber;
	private Date createdAt;
	private Date updatedAt;
}
