package com.semi4.vo;

import java.util.Date;

public class Comment {

	private Integer no;
	private String content;
	private Date createDate;
	private ReviewBoard reviewBoard;
	private User user;

	public Comment() {
	}

	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public ReviewBoard getReviewBoard() {
		return reviewBoard;
	}

	public void setReviewBoard(ReviewBoard reviewBoard) {
		this.reviewBoard = reviewBoard;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
