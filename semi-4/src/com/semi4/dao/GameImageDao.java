package com.semi4.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.semi4.utils.IbatisUtil;
import com.semi4.vo.GameImage;

public class GameImageDao {

	// 싱글턴 객체
	private static GameImageDao self = new GameImageDao();    // 자기 자신의 객체를 담는 정적변수에 객체를 저장한다.

	private GameImageDao() {
	}                                                         // 생성자를 private으로 선언

	public static GameImageDao getInstance() {                // UserDao 객체를 제공하는 정적메소드를 정의
		return self;
	}

	private SqlMapClient sqlmap = IbatisUtil.getSqlmap();

	/**
	 * 전달받은 GameImage 로 게임 상세이미지 등록하기
	 * @throws SQLException
	 */
	public void insertGameImage(GameImage gameImage) throws SQLException {
		sqlmap.insert("gameimage.insertGameImage", gameImage);
	}

	/**
	 * 게임번호로 상세게임 이미지들 조회하기
	 * @param gameNo
	 * @return List<GameImage>
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<GameImage> getGameImagesByGameNo(int gameNo) throws SQLException {
		return sqlmap.queryForList("gameimage.getGameImagesByGameNo", gameNo);
	}

	/**
	 * 이미지 번호로 상세게임 이미지 조회하기
	 * @param imageNo
	 * @return GameImage 객체
	 * @throws SQLException
	 */
	public GameImage getGameImageByImageNo(int imageNo) throws SQLException {
		return (GameImage)sqlmap.queryForObject("gameimage.getGameImageByImageNo", imageNo);
	}

	/**
	 * 입력받은 게임번호에 해당하는 상세이미지 모두 삭제하기
	 * @param gameNo
	 * @throws SQLException
	 */
	public void deleteGameImagesByGameNo(int gameNo) throws SQLException {
		sqlmap.delete("gameimage.deleteGameImagesByGameNo", gameNo);
	}

	/**
	 * 기존에 등록된 이미지를 변경하려고 할 경우 업데이트하기
	 * @param gameImage
	 * @throws SQLException
	 */
	public void updateGameImage(GameImage gameImage) throws SQLException {
		sqlmap.update("gameimage.updateGameImage", gameImage);
	}

	/**
	 * 이미지 번호에 해당하는 게임 이미지 삭제하기
	 * @param imageNo
	 * @throws SQLException
	 */
	public void deleteGameImageByImageNo(int imageNo) throws SQLException {
		sqlmap.delete("gameimage.deleteGameImageByImageNo", imageNo);
	}

}
