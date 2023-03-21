package com.kosa.myhome4;

public class CommonUtill {
	// 클래스 밖에서 객체 생성 못하게 하기 위한 코드
	// 생성자 private
	private CommonUtill() {} 
	static public String nullToVal(Object ob1, String value){
		if(ob1 == null || ob1.toString().equals(""))
			return value;
		else
			return ob1.toString();
	}
}
