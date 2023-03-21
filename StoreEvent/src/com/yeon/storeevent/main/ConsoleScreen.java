package com.yeon.storeevent.main;

import java.util.ArrayList;
import java.util.Scanner;

public class ConsoleScreen {
	
	Scanner inputSystem = null;
	
	public ConsoleScreen() {
		inputSystem = new Scanner(System.in);
	}
	
	public int showMainMenu() throws Exception{
		System.out.println("<행사 상품 관리>");
		System.out.println();
		System.out.println("1. 행사 상품 등록");
		System.out.println("2. 행사 상품 조회");
		System.out.println("3. 행사 상품 삭제");
		System.out.println("4. 행사 상품 수정");
		System.out.println("10. 종료");
		System.out.println();
		System.out.print("선택 : ");
		return inputSystem.nextInt();
	}
	
	public Product showRegProductMenu() throws Exception{
		System.out.print("상품명 : ");
		String n = inputSystem.next();
		System.out.print("카테고리 : ");
		String c = inputSystem.next();
		System.out.print("가격 : ");
		int p = inputSystem.nextInt();
		System.out.print("행사번호 : ");
		int e = inputSystem.nextInt();
		return new Product(n, c, p, e);
	}
	
	public Store showRegStoreMenu() throws Exception{
		System.out.println("편의점 번호 : ");
		int n = inputSystem.nextInt();
		System.out.println("브랜드 : ");
		String b = inputSystem.next();
		System.out.println("지점 : ");
		String l = inputSystem.next();
		System.out.println("주소 : ");
		String a = inputSystem.next();
		return new Store(0, b, l, a);
	}
	
	public Product showDelProductMenu() throws Exception {
		System.out.print("상품명 : ");
		String n = inputSystem.next();
		return new Product(n, null, 0, 0);
	}
	
	public Product showUpProductMenu() throws Exception {
		System.out.print("상품명 : ");
		String n = inputSystem.next();
		System.out.print("행사 번호 : ");
		int e = inputSystem.nextInt();
		return new Product(n, null, 0, e);
	}
	
	public int showSelectPageMenu(int page) {
		System.out.printf("몇 페이지[1 ~ %d] : ", page);
		return inputSystem.nextInt();
	}
	
	public void showResult(String result) {
		System.out.println(result);
	}
	
	public void showResult(ArrayList<Product> result) {
		for (Product product : result) {
			System.out.println(product.getName());
			System.out.println(product.getCategory());
			System.out.println(product.getPrice());
			System.out.println(product.geteNo());
		}
	}
	
	public void bye() {
		inputSystem.close();

	}
}
