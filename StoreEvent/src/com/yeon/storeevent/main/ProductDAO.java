package com.yeon.storeevent.main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import seoyeon.lee.db.manager.YeonDBManager;

public class ProductDAO {
		private int allProductCount;
		
		public ProductDAO() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				String url = "jdbc:oracle:thin:@192.168.0.3:1521:XE";
				con = YeonDBManager.connect(url, "tjdus", "5077");
				String sql = "SELECT count(*) FROM DEC23_PRODUCT";
				
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				rs.next();
				allProductCount = rs.getInt("COUNT(*)");
			} catch (Exception e) {
				e.printStackTrace(); 
			}
			YeonDBManager.close(con, pstmt, rs);
		}
	
		public String regProduct(Product p) {
			Connection con = null;
			PreparedStatement pstmt = null;
			try {
				String url = "jdbc:oracle:thin:@192.168.0.3:1521:XE";
				con = YeonDBManager.connect(url, "tjdus", "5077");
				String sql = "INSERT INTO DEC23_PRODUCT VALUES (?, ?, ?, ?)";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, p.getName());
				pstmt.setString(2, p.getCategory());
				pstmt.setInt(3, p.getPrice());
				pstmt.setInt(4, p.geteNo());
				
				if (pstmt.executeUpdate() == 1) {
					allProductCount++;
					return "등록성공";
				}
				return "실패";
				
			} catch (Exception e) {
				e.printStackTrace();
				return "실패";
			} finally {
				YeonDBManager.close(con, pstmt, null);
			}
		}
		
		public String delProduct(Product p) {
			Connection con = null;
			PreparedStatement pstmt = null;
			try {
				String url = "jdbc:oracle:thin:@192.168.0.3:1521:XE";
				con = DriverManager.getConnection(url, "tjdus", "5077");
				String sql = "DELETE FROM DEC23_PRODUCT WHERE P_NAME LIKE '%'||?||'%' ";

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, p.getName());
				
				if (pstmt.executeUpdate() == 1) {
					return "삭제 성공";
				} else {
					return "실패";
				}
			
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		public String upProduct(Product p) {
			Connection con = null;
			PreparedStatement pstmt = null;
			try {
				String url = "jdbc:oracle:thin:@192.168.0.3:1521:XE";
				con = DriverManager.getConnection(url, "tjdus", "5077");
				String sql = "UPDATE DEC23_PRODUCT SET P_EVENT_NO = ? WHERE P_NAME LIKE '%'||?||'%' ";

				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, p.geteNo());
				pstmt.setString(2, p.getName());
				
				if (pstmt.executeUpdate() == 1) {
					return "수정성공";
				} else {
					return "실패";
				}
			
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		public ArrayList<Product> getProduct(int pageNo) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null; 
			try {
				String url = "jdbc:oracle:thin:@192.168.0.3:1521:XE";
				con = YeonDBManager.connect(url, "tjdus", "5077");
				
				int productPerPage = 5;
				int start = (pageNo -1) * productPerPage + 1;
				int end = pageNo * productPerPage;
				
				String sql = "SELECT * FROM (\r\n"
						+ "SELECT ROWNUM AS RN, P_NAME, P_CATEGORY, P_PRICE, P_EVENT_NO \r\n"
						+ "FROM(DEC23_PRODUCT)) \r\n"
						+ "WHERE RN >= ? AND RN <= ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				
				ArrayList<Product> products = new ArrayList<>();
				while (rs.next()) {
					products.add(
							new Product(
									rs.getString("P_NAME"),
									rs.getString("P_CATEGORY"),
									rs.getInt("P_PRICE"),
									rs.getInt("P_EVENT_NO")
										)
								);
				}
				return products;
				
		} catch (Exception e) {
			return null;
		} finally {
			YeonDBManager.close(con, pstmt, rs);
		}
	}
		
		public int getPageCount() {
			double productPerPage = 5; // 한 페이지에 5개씩
			int pageCount = (int) Math.ceil(allProductCount / productPerPage) ;
			return pageCount;
		}
}

			
		
