package kr.co.cdtrade.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.co.cdtrade.vo.User;

public interface UserMapper {

	void insertUser(User user);

	User getUserByEmail(String email);

	User getUserByNickname(String nickname);

	User getUserByTel(String tel);

	User getUserByNo(int no);

	int deactivateUserByNo(int no);

	void updateUser(User user);

	void updateAccountNumber(@Param("userNo") int userNo, @Param("accountNumber") String accountNumber);
	
	String findUserEmail(Map<String, Object> params);
	
	int verifyUserForPasswordReset(Map<String, Object> params);
	
	void updatePassword(Map<String, Object> params);
	
	Map<String, Object> getMypageSummary(@Param("userNo") int userNo);


}