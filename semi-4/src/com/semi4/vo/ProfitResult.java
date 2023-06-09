package com.semi4.vo;

public class ProfitResult {

	private String PublisherName;
	private Integer action;
	private Integer adventure;
	private Integer sports;
	private Integer rpg;
	private Integer fps;
	private Integer puzzle;
	private Integer sim;
	private Integer str;
	private Integer etc;

	public ProfitResult() {
	}

	// 총액을 구하는 메소드
	public int getTotal() {
		return action + adventure + sports + rpg + fps + puzzle + sim + str + etc;
	}

	public String getPublisherName() {
		return PublisherName;
	}

	public void setPublisherName(String publisherName) {
		PublisherName = publisherName;
	}

	public Integer getAction() {
		return action;
	}

	public void setAction(Integer action) {
		this.action = action;
	}

	public Integer getAdventure() {
		return adventure;
	}

	public void setAdventure(Integer adventure) {
		this.adventure = adventure;
	}

	public Integer getSports() {
		return sports;
	}

	public void setSports(Integer sports) {
		this.sports = sports;
	}

	public Integer getRpg() {
		return rpg;
	}

	public void setRpg(Integer rpg) {
		this.rpg = rpg;
	}

	public Integer getFps() {
		return fps;
	}

	public void setFps(Integer fps) {
		this.fps = fps;
	}

	public Integer getPuzzle() {
		return puzzle;
	}

	public void setPuzzle(Integer puzzle) {
		this.puzzle = puzzle;
	}

	public Integer getSim() {
		return sim;
	}

	public void setSim(Integer sim) {
		this.sim = sim;
	}

	public Integer getStr() {
		return str;
	}

	public void setStr(Integer str) {
		this.str = str;
	}

	public Integer getEtc() {
		return etc;
	}

	public void setEtc(Integer etc) {
		this.etc = etc;
	}

}
