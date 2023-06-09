package com.semi4.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

	private static SimpleDateFormat normalFormat = new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat monthFormat = new SimpleDateFormat("yyyy-MM");
	private static SimpleDateFormat gameDateFormate = new SimpleDateFormat("yy-MM-dd");

	/**
	 * 날짜 형식을 문자열("yyyy-MM-dd")로 변환하는 메소드
	 * @param date
	 * @return
	 */
	public static String dateToString(Date date) {
		if (date == null) {
			return "";
		}
		return normalFormat.format(date);
	}

	/**
	 * 문자열 형식의 날짜 String을 Date형식으로 변환하는 메소드
	 * @param dateString
	 * @return Date 객체
	 * @throws Exception
	 */
	public static Date stringToDate(String dateString) throws Exception {
		if (dateString == null) {
			return null;
		}
		Date date = normalFormat.parse(dateString);
		return date;
	}

	/**
	 * 날짜 형식을 문자열("yyyy-MM")으로 변환하는 메소드
	 * @param date
	 * @return
	 */
	public static String dateToMonth(Date date) {
		if (date == null) {
			return "";
		}
		return monthFormat.format(date);
	}

	/**
	 * 날짜 형식을 문자열("yy-MM-dd")으로 변환하는 메소드
	 * @param date
	 * @return
	 */
	public static String gameDateToMonth(Date date) {
		if (date == null) {
			return "";
		}
		return gameDateFormate.format(date);
	}

}
