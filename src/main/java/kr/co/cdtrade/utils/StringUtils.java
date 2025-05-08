package kr.co.cdtrade.utils;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class StringUtils {

	private static DecimalFormat decimalFormat = new DecimalFormat("##,###");
	private static SimpleDateFormat detailDateFormat = new SimpleDateFormat("yyyy년 M월 d일 a h시 m분 s초");
	private static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

	/**
	 * 값을 전달받아서 해당 값이 null이면 defaultValue를 반환한다.
	 * @param value null일 가능성이 있는 문자열
	 * @param defaultValue 기본값
	 * @return 문자열, null일 때는 기본값
	 */
	public static String nullToStr(String value, String defaultValue) {
		if (value== null) {
			return defaultValue;
		}
		return value.trim();
	}
	/**
	 * 전달받은 값이 null이면 빈 문자열을 반환한다.
	 * @param value null일 가능성이 있는 문자열
	 * @return 문자열 혹은 빈 문자열
	 */
	public static String nullToBlank(String value) {
		return nullToStr(value, "");

	}
	/**
	 * 날짜를 전달받아서 "2024년 1월 1일 오전 9시 10분 20초" 형식의 문자열로 반환한다.
	 * @param date 날짜
	 * @return	"20204년 1월 1일 오전 9시 10분 20초" 형식의 문자열
	 */
	public static String detailDate(Date date) {
		if (date == null) {
			return "";

		}
		return detailDateFormat.format(date);
	}
	/**
	 * 날짜를 전달받아서 "2024-01-21"형식의 문자열로 반환 한다
	 * @param date 날짜
	 * @return "2024-01-01g 형식의 문자열"
	 */
	public static String simpleDate(Date date) {
		if (date == null) {
			return "";

		}
		return simpleDateFormat.format(date);

	}

	/**
	 * 정수를 ,가 포함된 텍스트로 변환한다
	 *
	 * @param number 숫자
	 * @return 3자리마다 ,가 포함된 숫자형식 텍스트
	 */
	public static String commaWithNumber(int number) {
		return decimalFormat.format(number);
	}

	/**
	 * 문자열을 정수로 변환해서 반환한다. 숫자 변환이 불가능하거나 null/빈 문자열일 경우 defaultValue를 반환한다.
	 *
	 * @param str          숫자로 구성된 문자열
	 * @param defaultValue 변환이 실패할 경우 반환할 기본값
	 * @return 정수값
	 */
	public static int strToInt(String str, int defaultValue) {
		if (str == null) {
			return defaultValue;
		}
		str = str.trim();
		if (str.isEmpty()) {
			return defaultValue;
		}
		try {
			return Integer.parseInt(str);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}

	/**
	 * 문자열을 정수로 변환해서 반환한다. 변환에 실패하면 예외를 발생시킨다.
	 *
	 * @param str 숫자로 구성된 문자열
	 * @return 정수값
	 * @throws IllegalArgumentException 유효하지 않은 숫자 형식일 경우
	 */
	public static int strToInt(String str) {
		if (str == null) {
			throw new IllegalArgumentException("null값은 숫자로 변환할 수 없습니다.");
		}
		str = str.trim();
		if (str.isEmpty()) {
			throw new IllegalArgumentException("빈 문자열은 숫자로 변환할 수 없습니다.");
		}

		try {
			return Integer.parseInt(str);

		} catch (NumberFormatException e) {
			throw new IllegalArgumentException("유효하지 않은 숫자 형식입니다: " + str);
		}
	}

	/**
	 * String[]을 int[]로 변환해서 반환한다.
	 * @param values 문자열
	 * @return
	 */
	public static int[] strToInt(String[] values) {
		/*
		 * ["1", "4", "10"] -> [1, 4, 10]
		 */
		int[] numbers = new int[values.length];

		for(int index=0; index<values.length; index++) {
			numbers[index] = strToInt(values[index]);
		}

		return numbers;

	}
	public static String toStar(double rating) {
		if (rating < 1) {
			return "☆☆☆☆☆";
		} else if (rating < 2) {
			return "★☆☆☆☆";

		} else if (rating < 3) {
			return "★★☆☆☆";
		} else if (rating < 4) {
			return "★★★☆☆";
		} else if (rating < 5) {
			return "★★★★☆";
		} else if (rating < 6) {
			return "★★★★★";
		}
		return null;

	}
}
