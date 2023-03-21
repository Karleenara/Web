package com.kosa.mvc1;

public final class DBUtil {
	public final static String DRIVER = "oracle.jdbc.driver.OracleDriver";
	public final static String URL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
	public final static String USERID ="nara";
	public final static String PWD="skfk";
	
	//ctrl-shift-x : 대문자 
	//ctrl-shift-y : 소문자 
	
	//외부에서 접근가능, final 상수, static - DBUtil 객체 안만들고 
	//쓰려고 
	
	private DBUtil() { } //클래스 외부에서 객체 생성을 못하게 막는다
}
