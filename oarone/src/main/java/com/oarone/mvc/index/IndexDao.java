package com.oarone.mvc.index;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.oarone.mvc.index.IndexDto;
import com.oarone.mvc.DBUtil;

public class IndexDao {
	public IndexDao() {
		try {
			Class.forName(DBUtil.DRIVER);
		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		}
	}
	
	public List<IndexDto>  getList(){
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs = null;
		List<IndexDto> list = new ArrayList<IndexDto>();
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, 
					DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			StringBuffer buffer = new StringBuffer();
			buffer.append("select seq, image ");
			buffer.append("from (  ");
			buffer.append(" select * ");
			buffer.append("from tb_product ");
			buffer.append("order by seq desc) ");
			buffer.append("where rownum <=5 ");
			System.out.println(buffer.toString());
			
			//되었는지 꼭 확인하자. 나중에는 log4j 라는 라이브러리를 연결해서 
			//확인한다. 
			rs = stmt.executeQuery(buffer.toString()); //쿼리 실행후 결과집합을 반환한다 
			while(rs.next())//맨앞에는 데이터가 아니다. 한번 next호출해야  
			{               //데이터이다. 
				IndexDto dto = new IndexDto();
				dto.setSeq(rs.getString("seq"));
				dto.setImage(rs.getString("image"));
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
	
}
