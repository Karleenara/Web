<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%

request.setCharacterEncoding("utf-8");
response.setCharacterEncoding("utf-8");

String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@192.168.0.4:1521:xe";
String userid = "nara";
String pwd = "skfk";

Class.forName(driver);
Connection conn = DriverManager.getConnection(url, userid, pwd);

String name = request.getParameter("name");
String kor = request.getParameter("kor");
String eng = request.getParameter("eng");
String mat = request.getParameter("mat");

String mode = request.getParameter("mode");
String seq = request.getParameter("seq");
String msg = "";

String sql="";
if(mode.equals("insert")){
	sql = "insert into tb_score(seq, name, kor, eng, mat, wdate) "
		+ "values(sq_score.nextval, " 
		+ "'" + name + "', " 
		+ "'" + kor + "', "
		+ "'" + eng + "', "
		+ "'" + mat + "', "
		+ "sysdate)";
	msg = "성적이 등록되었습니다.";	
	}else if(mode.equals("modify")){
		sql = "update tb_score set name =' "+name+"' "
				+ ", kor='" + kor + "' "
				+ ", eng='" + eng + "' "
				+ ", mat='" + mat + "' "
				+ " where seq = " + seq;
		msg = "성적이 수정 되었습니다";
	}else if(mode.equals("delete")){
		sql= "delete from tb_score where seq= " + seq;
		msg = "삭제 되었습니다.";
	}

System.out.println(sql); // 쿼리확인

Statement stmt = conn.createStatement();
boolean result = stmt.execute(sql);
stmt.close();
conn.close();

%>
<script>
	alert("<%=msg%>");
	location.href="score_list.jsp";
</script>
    