package com.semi4.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.semi4.utils.IbatisUtil;
import com.semi4.vo.QnaBoard;

public class QnaBoardDao {

	private static QnaBoardDao self = new QnaBoardDao();

	private QnaBoardDao() {
	}

	public static QnaBoardDao getInstance() {
		return self;
	}
	
	private SqlMapClient sqlmap = IbatisUtil.getSqlmap();

	// 게시판에 글을 등록한 유저를 조회하는 기능
	@SuppressWarnings("unchecked")
	public List<QnaBoard> getQnaBoardUserById(int userNo) throws SQLException {
		return sqlmap.queryForList("qnaboard.getQnaBoardUserById", userNo);
	}

	//게시판 새 글 등록
	public void insertQnaBoard(QnaBoard qnaBoard) throws SQLException {
		sqlmap.insert("qnaboard.insertQnaBoard", qnaBoard);
	}

	//게시판 전체 목록
	@SuppressWarnings("unchecked")
	public List<QnaBoard> getAllQnaBoards() throws SQLException {
		return sqlmap.queryForList("qnaboard.getAllQnaBoards");
	}

	//게시판 상세 목록
	public QnaBoard getBoardByQnaNo(int qnaBoardNo) throws SQLException {
		return (QnaBoard)sqlmap.queryForObject("qnaboard.getBoardByQnaNo", qnaBoardNo);
	}

	//게시판 삭제
	public void deleteQnaBoard(int qnaBoardNo) throws SQLException {
		sqlmap.delete("qnaboard.deleteQnaBoard", qnaBoardNo);
	}

	//게시판 수정
	public void updateQnaBoard(QnaBoard qnaBoard) throws SQLException {
		sqlmap.update("qnaboard.updateQnaBoard", qnaBoard);
	}

	public int getQnaBoardBySearchCount(Map<String, Object> criteria) throws SQLException {
		return (int)sqlmap.queryForObject("qnaboard.getQnaBoardBySearchCount", criteria);
	}

	@SuppressWarnings("unchecked")
	public List<QnaBoard> getQnaBoardBySearch(Map<String, Object> criteria) throws SQLException {
		return sqlmap.queryForList("qnaboard.getQnaBoardBySearch", criteria);
	}

	@SuppressWarnings("unchecked")
	public List<QnaBoard> getNewQnaBoards(Map<String, Object> criteria) throws SQLException {
		return sqlmap.queryForList("qnaboard.getNewQnaBoards", criteria);
	}

	public Integer getQnaBoardCount() throws SQLException {
		return (Integer)sqlmap.queryForObject("qnaboard.getQnaBoardCount");
	}

	public void updateQnaCountByno(QnaBoard qnaBoard) throws SQLException {
		sqlmap.update("qnaboard.updateQnaCountByno", qnaBoard);
	}
}
