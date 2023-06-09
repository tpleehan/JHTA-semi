package com.semi4.utils;

import java.text.DecimalFormat;

public class NumberUtils {

	private NumberUtils() {
	}

	private static DecimalFormat numberFormat = new DecimalFormat("#,###");

	/*
	 * 숫자를 ,가 포함된 문자열로 반환
	 * number 숫자
	 * 세자리마다 ,가 포함된 문자열을 반환한다. number가 null이면 빈문자열을 반환한다.
	 */
	public static String numberWithComma(Integer number) {
		if (number == null) {
			return "0";
		}
		return numberFormat.format(number);
	}

	/*
	 * 문자를 숫자로 변환한다
	 * str숫자로 변환할 문자열
	 * 정수값이 반환된다 변환실패시 0이 반환
	 */
	public static int stringToNumber(String str) {
		return stringToNumber(str, 0);
	}

	/*
	 * 문자를 숫자로 변환
	 * str숫자로 변환할 문자열
	 * defaultNumber 변환실패시 사용될 기본값
	 * 정수값이 반환된다 변환실패시 기본값으로 지정된 값이 반환
	 */
	public static int stringToNumber(String str, int defaultNumber) {
		if (str == null) {
			return defaultNumber;
		}
		try {
			return Integer.parseInt(str);
		} catch (NumberFormatException e) {
			return defaultNumber;
		}
	}

	/*
	 * 첫번째 숫자를 두번째 숫자로 나눈 값에 대한 ceil값을 반환
	 * num1 첫번째 숫자
	 * num2 두번째 숫자 (나누는수)
	 * ceil값
	 */
	public static int ceil(double num1, double num2) {
		return (int)Math.ceil(num1 / num2);
	}

}
