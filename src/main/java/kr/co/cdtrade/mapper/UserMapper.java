package kr.co.cdtrade.mapper;

import kr.co.cdtrade.vo.User;

public interface UserMapper {

	void insertUser(User user);
	
	User getUserByEmail(String email);
	
	User getUserByNickname(String nickname);
	
	User getUserByTel(String tel);
	
	User getUserByNo(int no);
}
