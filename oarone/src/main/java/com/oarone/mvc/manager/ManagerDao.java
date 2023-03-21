package com.oarone.mvc.manager;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.oarone.mvc.manager.ManagerDto;
import com.oarone.mvc.DBUtil;

public class ManagerDao {
	List<ManagerDto> list = new ArrayList<ManagerDto>();
	public ManagerDao() {
		try {
			Class.forName(DBUtil.DRIVER);
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		
	}
	
	public List<ManagerDto>  getList(ManagerDto paramDto){
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs = null;
		List<ManagerDto> list = new ArrayList<ManagerDto>();
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, 
					DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			StringBuffer buffer = new StringBuffer();
			buffer.append("select * from tb_product ");
			System.out.println(buffer.toString());

			rs = stmt.executeQuery(buffer.toString()); //쿼리 실행후 결과집합을 반환한다 
			while(rs.next())//맨앞에는 데이터가 아니다. 한번 next호출해야  
			{               //데이터이다. 
				ManagerDto dto = new ManagerDto();
				dto.setSeq(rs.getString("seq"));
				dto.setPr_name(rs.getString("pr_name"));
				dto.setImages(rs.getString("image"));
				dto.setPrice(rs.getString("price"));
				dto.setCate(rs.getString("cate"));
				dto.setWdate(rs.getString("wdate"));
				dto.setHit(rs.getString("hit"));
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally //예외가 발생하던 말던 무조건 수행한다. - 디비를 닫아주자
		{
			try
			{
				if(rs!=null) rs.close();
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	 public void insert(ManagerDto dto)
	 {
		 Connection conn=null;
		 Statement stmt = null;
		 try
		 {
			 //String클래스는 내부 메모리를 데이터 하나 추가될때마다 
			 //새로 잡아서 데이터넣고 
			 StringBuffer buffer = new StringBuffer();
			 buffer.append("insert into tb_product( ");
			 buffer.append("seq, pr_name, price, image, cate, wdate, hit ) ");
			 buffer.append(" values ( sq_product.nextval,");
			 buffer.append(" '"+dto.getPr_name()+"', ");
			 buffer.append(" '"+dto.getPrice()+"', ");
			 buffer.append(" '"+dto.getImages()+"', ");
			 buffer.append(" '"+dto.getCate()+"', ");
			 buffer.append(" sysdate, 0) ");
			 System.out.println(buffer.toString());
			 
			 conn = DriverManager.getConnection(DBUtil.URL, 
					 DBUtil.USERID, DBUtil.PWD);
			 
			 stmt = conn.createStatement();
			 stmt.execute(buffer.toString());
			 
		 }
		 catch (SQLException e) 
		 {
				e.printStackTrace();
		 }
		 catch(Exception e)
		 {
				e.printStackTrace();
		 }
		 finally //예외가 발생하던 말던 무조건 수행한다. - 디비를 닫아주자
		 {
			try
			{
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
	 }
	 
	
	
}
