package com.yeon.storeevent.main;

public class Product {
	// 멤버변수명 DB필드명 같을 필요 없음
	private String name;
	private String category;
	private int price;
	private int eNo;
	
	public Product() {
	}

	public Product(String name, String category, int price, int eNo) {
		super();
		this.name = name;
		this.category = category;
		this.price = price;
		this.eNo = eNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int geteNo() {
		return eNo;
	}

	public void seteNo(int eNo) {
		this.eNo = eNo;
	}
	
	
}
