package com.yeon.storeevent.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import seoyeon.lee.db.manager.YeonDBManager;

public class HomeController {
	public static void main(String[] args) {
		ConsoleScreen cs = new ConsoleScreen();
		ProductDAO pd = new ProductDAO();
		
		int menu = 0;
		int page = 0;
		Product p = null;
		String result = null;
		ArrayList<Product> result2 = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			while (true) {
				menu = cs.showMainMenu();
				if (menu == 10) {
					break;
				} else if(menu == 1) {
					p = cs.showRegProductMenu();
					result = pd.regProduct(p);
					cs.showResult(result);
				} else if (menu == 2) {
					page = pd.getPageCount();
					page = cs.showSelectPageMenu(page);
					result2 = pd.getProduct(page);
					System.out.println("-----");
					cs.showResult(result2);
					System.out.println("-----");
				} else if (menu == 3) {
					p = cs.showDelProductMenu();
					result = pd.delProduct(p);
					cs.showResult(result);
				} else if (menu == 4) {
					p = cs.showUpProductMenu();
				}
				
			}
			//끊기
			YeonDBManager.close(con, pstmt, rs);
		} catch (Exception e) {
			System.out.println("잘못입력");
			}
		
		cs.bye();
		
	}
}
