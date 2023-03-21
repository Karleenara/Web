package com.yeon.storeevent.main;

public class Store {
	private int no;
	private String brand;
	private String location;
	private String addr;
	
	public Store() {
		// TODO Auto-generated constructor stub
	}

	public Store(int no, String brand, String location, String addr) {
		super();
		this.no = no;
		this.brand = brand;
		this.location = location;
		this.addr = addr;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	
	
	
}
