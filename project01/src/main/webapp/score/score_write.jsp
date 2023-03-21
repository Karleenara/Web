<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		// seq 파라미터값 받아서 조회수 증가하고 데이터 가져오기
		String seq = request.getParameter("seq");
		String mode = request.getParameter("mode");
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@192.168.0.4:1521:xe";
		String userid = "nara";
		String pwd = "skfk";
	
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, userid, pwd);
		String sql = "";
		Statement stmt = conn.createStatement();
		// insert, update, delete 할때 
	
		sql = "select * from tb_score " + "where seq =" + seq;
		ResultSet rs = stmt.executeQuery(sql);
		String name = "";
		String kor = "";
		String eng = "";
		String mat = "";
		String wdate="";
		
		if (rs.next()) {
			name = rs.getString("name");
			kor = rs.getString("kor");
			eng = rs.getString("eng");
			mat = rs.getString("mat");
			wdate = rs.getString("wdate");
		}

		rs.close();
		stmt.close();
		conn.close();
		%>
	
	<form name = "myform">
		<input type="hidden" name="seq" value="<%=seq%>">
		<input type="hidden" name="mode" value="<%=mode%>">
		
		이름 : <input type="text" name="name" id="name" value="<%=name%>"><br/> 
		국어 : <input type="text" name="kor" id ="kor" value="<%=kor%>"><br/>
		영어 : <input type="text" name="eng" id="eng" value="<%=eng%>"><br/>
		수학 : <input type="text" name="mat" id ="mat" value=<%=mat%>><br/>
		<br/>
			
	
	 <div class="container" style="text-align:right">
 	<%if(mode.equals("insert")){ %>
	<button type="button" class="btn btn-primary" id="btnSend">등록</button>
	<%}else{%>
		<button type="button" class="btn btn-secondary" id="btnModify">수정</button>
	<%} %>
	&nbsp;&nbsp;
		<button type="button" class="btn btn-secondary" id="btnList">목록</button>
 	</div>
	
	</form>
</body>
</html>
<script>
	window.onload=()=>{
		let btnSend = document.getElementById("btnSend");
		let btnModify = document.getElementById("btnModify");
		let btnList = document.getElementById("btnList");
		
		<%if(mode.equals("insert")){%>
		btnSend.addEventListener("click", (e)=>{
			e.preventDefault();
			let frm = document.myform;
			// 데이터 DB에 저장
			frm.action = "score_proc.jsp"; 
			frm.method = "post";
			frm.submit(); // 서버로 전송
		})
		<%} else {%>
		
		btnModify.addEventListener("click", (e)=>{
			e.preventDefault();
			let frm = document.myform;
			// 데이터 DB에 저장
			frm.action = "score_proc.jsp"; 
			frm.method = "post";
			frm.submit(); // 서버로 전송
		})
		<%} %>
		btnList.addEventListener("click", (e)=>{
			e.preventDefault();
			let frm = document.myform;
			// 데이터 DB에 저장
			frm.action = "score_list.jsp"; 
			frm.method = "post";
			frm.submit(); // 서버로 전송
		})
	}

</script>