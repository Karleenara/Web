package com.kosa.mvc1.gallery;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.kosa.mvc1.DBUtil;

public class GalleryDao {
	List<GalleryDto> list = new ArrayList<GalleryDto>();
	//seq, title, writer, wdate, contents, hit
	public GalleryDao() {
//		//생성자에서 데이터 미리 넣어놓기 
//		list.add(new GalleryDto("1", "제목1", "작성자1", "2023-01-09",
//				"내용1", "32"));
//		list.add(new GalleryDto("2", "제목2", "작성자2", "2023-01-09",
//				"내용2", "22"));
//		list.add(new GalleryDto("3", "제목3", "작성자3", "2023-01-09",
//				"내용3", "44"));
		//jsp일때는 예외처리를 안해도 된다. 그러나 
		//java일때는 반드시 예외처리를 해야 한다 
		
		try {
			Class.forName(DBUtil.DRIVER);
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		
	}
	
	public String getSearch(GalleryDto paramDto) {
		String searchText = " where 1=1"; // 모든데이터
		if(paramDto.getSearchOpt().equals("1"))
			searchText += " and title like '%" + paramDto.getSearchDeyword() + "%' ";
		else if(paramDto.getSearchOpt().equals("2"))
			searchText += " and contents like '%" + paramDto.getSearchDeyword()	+ "%' ";
		else if(paramDto.getSearchOpt().equals("3")) {
			searchText += " and (title like '%" + paramDto.getSearchDeyword()	+ "%' ";
			searchText += " or contents like '%" + paramDto.getSearchDeyword()	+ "%' )";
		}
		return searchText;
	}
	
	public int getTotalCnt(GalleryDto paramDto){
			
			Connection conn=null;
			Statement stmt=null;
			ResultSet rs = null;
			List<GalleryDto> list = new ArrayList<GalleryDto>();
			
			int totalCnt=0;
			
			try {
				conn = DriverManager.getConnection(DBUtil.URL, 
						DBUtil.USERID, DBUtil.PWD);
				stmt = conn.createStatement();
				
				StringBuffer buffer = new StringBuffer();
				buffer.append("select count(*) ");
				buffer.append("from tb_gallery A ");
				buffer.append( getSearch(paramDto) );
				
				System.out.println(buffer.toString());
				
				//되었는지 꼭 확인하자. 나중에는 log4j 라는 라이브러리를 연결해서 
				//확인한다. 
				rs = stmt.executeQuery(buffer.toString()); //쿼리 실행후 결과집합을 반환한다 
				if(rs.next())//맨앞에는 데이터가 아니다. 한번 next호출해야  
				{               //데이터이다. 
					totalCnt = rs.getInt(1);
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
			
			return totalCnt;
		}
	
	public List<GalleryDto>  getList(GalleryDto paramDto){
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs = null;
		List<GalleryDto> list = new ArrayList<GalleryDto>();
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, 
					DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			StringBuffer buffer = new StringBuffer();
			buffer.append("select a.seq, a.title, a.writer, a.user_name, a.rnum, to_char(a.wdate, 'yyyy-mm-dd') wdate, a.hit, a.pg, a.image ");
			buffer.append("from ( ");
			buffer.append("select seq, title, writer, contents, hit, wdate, b.user_name, a.image, ");
			buffer.append("row_number() over(order by seq desc) as rnum, ");
			buffer.append("ceil(row_number() over(order by seq desc) / 12) -1 pg ");
			buffer.append("from tb_gallery a ");
			buffer.append("left outer join tb_member b ");
			buffer.append("on a.writer = b.user_id ");
			buffer.append( getSearch(paramDto) );
			buffer.append(")a where pg= "+ paramDto.getPg());
			System.out.println(buffer.toString());
			
			//되었는지 꼭 확인하자. 나중에는 log4j 라는 라이브러리를 연결해서 
			//확인한다. 
			rs = stmt.executeQuery(buffer.toString()); //쿼리 실행후 결과집합을 반환한다 
			while(rs.next())//맨앞에는 데이터가 아니다. 한번 next호출해야  
			{               //데이터이다. 
				GalleryDto dto = new GalleryDto();
				dto.setSeq(rs.getString("seq"));
				dto.setRnum(rs.getInt("rnum"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setImage(rs.getString("image"));
				dto.setUser_name(rs.getString("user_name"));
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
	
	public GalleryDto  getView(String seq){
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs = null;
		GalleryDto dto = new GalleryDto();
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, 
					DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			//조회수 올리기
			String sql="update tb_gallery set hit=hit+1  "
					+ " where seq="+seq;
			System.out.println(sql);
			stmt.execute(sql); //insert, update, delete시 호출함수 
			
			//데이터 가져오기 
			// 회원 조건절이 먼저 실행되고, join 실행
			sql="select a.seq, a.title, a.writer, a.contents, a.wdate, a.hit, b.user_name, a.image "
				+ " from tb_gallery a"
				+ " left outer join tb_member b on a.writer=b.user_id "
				+ " where seq="+seq;
			
			
			System.out.println(sql); //디버깅용- 콘솔창에서 쿼리가 제대로 
			//되었는지 꼭 확인하자. 나중에는 log4j 라는 라이브러리를 연결해서 
			//확인한다. 
			rs = stmt.executeQuery(sql); //쿼리 실행후 결과집합을 반환한다 
			if(rs.next())//맨앞에는 데이터가 아니다. 한번 next호출해야  
			{                
				dto.setSeq(rs.getString("seq"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setContents(rs.getString("contents"));
				dto.setImage(rs.getString("image"));
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
	
	 public void insert(GalleryDto dto)
	 {
		 Connection conn=null;
		 Statement stmt = null;
		 try
		 {
			 //String클래스는 내부 메모리를 데이터 하나 추가될때마다 
			 //새로 잡아서 데이터넣고 
			 StringBuffer buffer = new StringBuffer();
			 buffer.append("insert into tb_gallery( ");
			 buffer.append("seq, title, writer, contents ");
			 buffer.append(" ,image, wdate, hit ) ");
			 buffer.append(" values ( sq_gallery.nextval,");
			 buffer.append(" '"+dto.getTitle()+"', ");
			 buffer.append(" '"+dto.getWriter()+"', ");
			 buffer.append(" '"+dto.getContents()+"', ");
			 buffer.append(" '"+dto.getImage()+"', ");
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
	 
	 public void update(GalleryDto dto)
	 {
		 Connection conn=null;
		 Statement stmt = null;
		 try
		 {
			 //String클래스는 내부 메모리를 데이터 하나 추가될때마다 
			 //새로 잡아서 데이터넣고 
			 StringBuffer buffer = new StringBuffer();
			 buffer.append("update tb_gallery set ");
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



