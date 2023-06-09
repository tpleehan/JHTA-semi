package com.semi4.dao;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.semi4.utils.IbatisUtil;
import com.semi4.vo.User;

public class UserDao {

	// 싱글턴 객체
	private static UserDao self = new UserDao();    // 자기 자신의 객체를 담는 정적변수에 객체를 저장한다.

	private UserDao() {
	}                                               // 생성자를 private으로 선언

	public static UserDao getInstance() {           // UserDao 객체를 제공하는 정적메소드를 정의
		return self;
	}

	private SqlMapClient sqlmap = IbatisUtil.getSqlmap();

	// 회원 비밀번호 변경하는 기능
	public void updateUserChagePwd(User user) throws SQLException {
		sqlmap.update("user.updateUserChagePwd", user);
	}

	// 회원 탈퇴 기능 (enabled의 default 값을 'y'에서 'n'으로 변경)
	public void dropOutUser(int userNo) throws SQLException {
		sqlmap.update("user.dropOutUser", userNo);
	}

	// 회원아이디를 조회하는 기능
	public User getUserById(String userId) throws SQLException {
		return (User)sqlmap.queryForObject("user.getUserById", userId);
	}

	// 고객을 추가하는 기능
	public void insertUser(User user) throws SQLException {
		sqlmap.insert("user.insertUser", user);
	}

	/**
	 * 고객번호로 고객 조회하기
	 * @param userNo
	 * @return User
	 * @throws SQLException
	 */
	public User getUserByNo(int userNo) throws SQLException {
		return (User)sqlmap.queryForObject("user.getUserByNo", userNo);
	}
}
