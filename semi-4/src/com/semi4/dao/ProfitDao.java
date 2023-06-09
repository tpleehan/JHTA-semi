package com.semi4.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.semi4.utils.IbatisUtil;
import com.semi4.vo.Profit;

public class ProfitDao {

	// 싱글턴 객체
	private static ProfitDao self = new ProfitDao();    // 자기 자신의 객체를 담는 정적변수에 객체를 저장한다.

	private ProfitDao() {
	}                                                   // 생성자를 private으로 선언

	public static ProfitDao getInstance() {             // UserDao 객체를 제공하는 정적메소드를 정의
		return self;
	}

	private SqlMapClient sqlmap = IbatisUtil.getSqlmap();

	/**
	 * "yyyy-MM-dd" 문자열 형식의 날짜 데이터(해당하는 일)의 수익을 조회하는 메소드
	 * @param stringDate
	 * @return List<Profit>
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<Profit> getProfitsByDate(String stringDate) throws SQLException {
		return sqlmap.queryForList("profit.getProfitsByDate", stringDate);
	}

	/**
	 * "yyyy-MM" 문자열 형식의 날짜 데이터(해당하는 달)의 수익을 조회하는 메소드
	 * @param stringMonthDate
	 * @return List<Profit>
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<Profit> getProfitsByMonth(String stringMonthDate) throws SQLException {
		return sqlmap.queryForList("profit.getProfitsByMonth", stringMonthDate);
	}

	/**
	 * 새로운 수익정보 생성하기
	 * @param profit
	 * @throws SQLException
	 */
	public void insertProfits(Profit profit) throws SQLException {
		sqlmap.insert("profit.insertProfits", profit);
	}

	/**
	 * 입력받은 장르번호로 장르별 총액 조회하기
	 * @param genreNo
	 * @return int totalSales
	 * @throws SQLException
	 */
	public int getTotalProfitByGenre(int genreNo) throws SQLException {
		return (Integer)sqlmap.queryForObject("profit.getTotalProfitByGenre", genreNo);
	}

}
