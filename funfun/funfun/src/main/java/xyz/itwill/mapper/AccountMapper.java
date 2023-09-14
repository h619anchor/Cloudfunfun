package xyz.itwill.mapper;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Account;

public interface AccountMapper {
	int insertAccount(Account account);

	int updateAccount(Account account);

	int updateAccountByAdmin(Account account);

	int deleteAccount(String id);

	Account selectAccount(String id);

	int selectAccountCount();

	List<Account> selectAccountList(Map<String, Object> map);

	// 아이디 찾기
	Account idSearch(Account search);

	// 비밀번호 찾기
	Account pwSearch(Account search);

	// 새 비밀번호로 업데이트
	int updatePassword(Account account);

	// 비밀번호 해시 조회 메소드
	String getHashedPassword(String id);
}
