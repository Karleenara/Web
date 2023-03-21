package com.kosa.mvc1.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.kosa.mvc1.DBUtil;

public class MemberDao {

	public MemberDao() {
		super();

		try {
			Class.forName(DBUtil.DRIVER);
		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		}

	}

	// 아이디 중복 체크하기
	// 만일 아이디 이미 있으면 true 없으면 false 반환
	boolean isDuplicate(String user_id) {

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			String sql = "select count(*) cnt from tb_member " + "where user_id='" + user_id + "' ";

			System.out.println(sql);
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();

			rs = stmt.executeQuery(sql); // 쿼리 실행후 결과집합을 반환한다
			if (rs.next())// 맨앞에는 데이터가 아니다. 한번 next호출해야
			{
				if (rs.getInt("cnt") == 0)
					return false;
				else
					return true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally // 예외가 발생하던 말던 무조건 수행한다. - 디비를 닫아주자
		{
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return true;

	}

	public boolean insert(MemberDto dto) {

		StringBuffer buffer = new StringBuffer();

		buffer.append("insert into tb_member(");
		buffer.append("member_id, user_id, user_name, password ");
		buffer.append(" ,email, phone) values ( ");
		buffer.append("sq_member.nextval ");
		buffer.append(", '" + dto.getUser_id() + "' ");
		buffer.append(", '" + dto.getUser_name() + "' ");
		buffer.append(", '" + dto.getPassword() + "' ");
		buffer.append(", '" + dto.getEmail() + "' ");
		buffer.append(", '" + dto.getPhone() + "') ");

		System.out.println(buffer);

		Connection conn = null;
		Statement stmt = null;

		try {
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();

			stmt.execute(buffer.toString());

			return true;

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally // 예외가 발생하던 말던 무조건 수행한다. - 디비를 닫아주자
		{
			try {
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	MemberDto logon(String user_id, String password) {

		String sql = "select * from tb_member "
				+ "where user_id='"+user_id+"' "
				+ "and password='" +password+"' ";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		MemberDto dto = new MemberDto();

		try {
			System.out.println(sql);
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();

			rs = stmt.executeQuery(sql); // 쿼리 실행후 결과집합을 반환한다
			if (rs.next())// 맨앞에는 데이터가 아니다. 한번 next호출해야
			{
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setEmail(rs.getString("email"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally // 예외가 발생하던 말던 무조건 수행한다. - 디비를 닫아주자
		{
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return dto;

	}
	
	MemberDto findid(String user_name, String email) {

		String sql = "select * from tb_member "
				+ "where user_name='"+user_name+"' "
				+ "and email='" +email+"' ";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		MemberDto dto = new MemberDto();

		try {
			System.out.println(sql);
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();

			rs = stmt.executeQuery(sql); // 쿼리 실행후 결과집합을 반환한다
			if (rs.next())// 맨앞에는 데이터가 아니다. 한번 next호출해야
			{
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setEmail(rs.getString("email"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally // 예외가 발생하던 말던 무조건 수행한다. - 디비를 닫아주자
		{
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return dto;

	}
	
	MemberDto findpassword(String user_id, String email) {

		String sql = "select * from tb_member "
				+ "where user_id='"+user_id+"' "
				+ "and email='" +email+"' ";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		MemberDto dto = new MemberDto();

		try {
			System.out.println(sql);
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();

			rs = stmt.executeQuery(sql); // 쿼리 실행후 결과집합을 반환한다
			if (rs.next())// 맨앞에는 데이터가 아니다. 한번 next호출해야
			{
				dto.setUser_id(rs.getString("user_id"));
				dto.setPassword(rs.getString("password"));
				dto.setEmail(rs.getString("email"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally // 예외가 발생하던 말던 무조건 수행한다. - 디비를 닫아주자
		{
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return dto;

	}
}