package com.nara.ajaxtest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class GuestbookDao {
	List<GuestbookDto> list = new ArrayList<GuestbookDto>();
	//seq, title, writer, wdate, contents, hit
	public GuestbookDao() {
//		//생성자에서 데이터 미리 넣어놓기 
//		list.add(new GuestbookDto("1", "제목1", "작성자1", "2023-01-09",
//				"내용1", "32"));
//		list.add(new GuestbookDto("2", "제목2", "작성자2", "2023-01-09",
//				"내용2", "22"));
//		list.add(new GuestbookDto("3", "제목3", "작성자3", "2023-01-09",
//				"내용3", "44"));
		//jsp일때는 예외처리를 안해도 된다. 그러나 
		//java일때는 반드시 예외처리를 해야 한다 
		
		try {
			Class.forName(DBUtil.DRIVER);
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		
	}
	
	public List<GuestbookDto>  getList(){
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs = null;
		List<GuestbookDto> list = new ArrayList<GuestbookDto>();
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, 
					DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			String sql="select seq, title, writer, contents "
					+ ", to_char(wdate, 'yyyy-mm-dd') wdate "
					+ ", hit  from tb_guestbook ";
			
			System.out.println(sql); //디버깅용- 콘솔창에서 쿼리가 제대로 
			//되었는지 꼭 확인하자. 나중에는 log4j 라는 라이브러리를 연결해서 
			//확인한다. 
			rs = stmt.executeQuery(sql); //쿼리 실행후 결과집합을 반환한다 
			while(rs.next())//맨앞에는 데이터가 아니다. 한번 next호출해야  
			{               //데이터이다. 
				GuestbookDto dto = new GuestbookDto();
				dto.setSeq(rs.getString("seq"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setContents(rs.getString("contents"));
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
	
	public GuestbookDto  getView(String seq){
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs = null;
		GuestbookDto dto = new GuestbookDto();
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, 
					DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			//조회수 올리기
			String sql="update tb_guestbook set hit=hit+1  "
					+ " where seq="+seq;
			System.out.println(sql);
			stmt.execute(sql); //insert, update, delete시 호출함수 
			
			//데이터 가져오기 
			sql="select * from tb_guestbook where seq="+seq;
			
			System.out.println(sql); //디버깅용- 콘솔창에서 쿼리가 제대로 
			//되었는지 꼭 확인하자. 나중에는 log4j 라는 라이브러리를 연결해서 
			//확인한다. 
			rs = stmt.executeQuery(sql); //쿼리 실행후 결과집합을 반환한다 
			if(rs.next())//맨앞에는 데이터가 아니다. 한번 next호출해야  
			{                
				dto.setSeq(rs.getString("seq"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setContents(rs.getString("contents"));
				dto.setWdate(rs.getString("wdate"));
				dto.setHit(rs.getString("hit"));
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
		
		return dto;
	}
	
	 public void insert(GuestbookDto dto)
	 {
		 Connection conn=null;
		 Statement stmt = null;
		 try
		 {
			 //String클래스는 내부 메모리를 데이터 하나 추가될때마다 
			 //새로 잡아서 데이터넣고 
			 StringBuffer buffer = new StringBuffer();
			 buffer.append("insert into tb_guestbook( ");
			 buffer.append("seq, title, writer, contents ");
			 buffer.append(" , wdate, hit ) ");
			 buffer.append(" values ( sq_guest.nextval,");
			 buffer.append(" '"+dto.getTitle()+"', ");
			 buffer.append(" '"+dto.getWriter()+"', ");
			 buffer.append(" '"+dto.getContents()+"', ");
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
	 
	 public void update(GuestbookDto dto)
	 {
		 Connection conn=null;
		 Statement stmt = null;
		 try
		 {
			 //String클래스는 내부 메모리를 데이터 하나 추가될때마다 
			 //새로 잡아서 데이터넣고 
			 StringBuffer buffer = new StringBuffer();
			 buffer.append("update tb_guestbook set ");
			 buffer.append(" title = '"+dto.getTitle()+"', ");
			 buffer.append(" writer = '"+dto.getWriter()+"', ");
			 buffer.append(" contents ='"+dto.getContents()+"' ");
			 buffer.append(" where seq="+dto.getSeq());
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








