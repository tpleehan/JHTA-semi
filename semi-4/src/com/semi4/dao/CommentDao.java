package com.semi4.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.semi4.utils.IbatisUtil;
import com.semi4.vo.Comment;

public class CommentDao {

	// 싱글턴 객체
	private static CommentDao self = new CommentDao();    // 자기 자신의 객체를 담는 정적변수에 객체를 저장한다.

	private CommentDao() {
	}                                                     // 생성자를 private으로 선언

	public static CommentDao getInstance() {              // UserDao 객체를 제공하는 정적메소드를 정의
		return self;
	}

	private SqlMapClient sqlmap = IbatisUtil.getSqlmap();

	public void insertComment(Comment comment) throws SQLException {
		sqlmap.insert("comment.insertComment", comment);
	}

	public Comment getCommentByNo(int comNo) throws SQLException {
		return (Comment)sqlmap.queryForObject("comment.getCommentByNo", comNo);
	}

	@SuppressWarnings("unchecked")
	public List<Comment> getAllComment() throws SQLException {
		return sqlmap.queryForList("comment.getAllComment");
	}

	@SuppressWarnings("unchecked")
	public List<Comment> getCommentByReviewNo(int reviewNo) throws SQLException {
		return sqlmap.queryForList("comment.getCommentByReviewNo", reviewNo);
	}

	public void updateComment(Comment comment) throws SQLException {
		sqlmap.update("comment.updateComment", comment);
	}

	public void deleteComment(int comNo) throws SQLException {
		sqlmap.delete("comment.deleteComment", comNo);
	}

}
