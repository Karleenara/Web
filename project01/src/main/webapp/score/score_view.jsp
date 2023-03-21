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
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.0.4:1521:xe";
	String userid = "nara";
	String pwd = "skfk";

	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, userid, pwd);
	
	String sql = "select * from tb_score " + "where seq =" + seq;
	
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(sql);
	String name="";
	String kor="";
	String eng="";
	String mat="";
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
	
<form name ="myform">
	<input type="hidden" name = "mode" value="modify">
	<input type="hidden" name = "seq" value="<%=seq%>">
</form>
	<div class="container mt-3">
		<h3>Navbar With Dropdown</h3>
		<p>This example adds a dropdown menu in the navbar.</p>

		<table class="table">
			<colgroup>
				<col width="25%">
				<col width="25%">
				<col width="25%">
				<col width="25%">
			</colgroup>
			<tbody>
				<tr>
					<th>이름
					</td>
					<td colspan="3">
					<%=name%></td>
				</tr>

				<tr>
					<th>국어
					</td>
					<td><%=kor%></td>
					<th>
					</td>
				</tr>
				<tr>
					<th>영어
					</td>
					<td><%=eng%></td>
					<th>
					</td>
				</tr>
				<tr>
					<th>수학
					</td>
					<td><%=mat%></td>
					<th>
					</td>
				</tr>



			</tbody>
		</table>
	</div>

	<div class="container" style="text-align: right">
		<button type="button" class = "btn btn-secondary" id="btnModify">수정</button>&nbsp;&nbsp;
		<button type="button" class = "btn btn-secondary" id="btnDelete">삭제</button>&nbsp;&nbsp;
		<button type="button" class = "btn btn-secondary" id="btnlist">목록</button>&nbsp;&nbsp;
		
	</div>

</body>
</html>
<script>
	window.onload=()=>{
		document.getElementById("btnModify").addEventListener("click", goModify);
		document.getElementById("btnDelete").addEventListener("click", goDelete);
		document.getElementById("btnlist").addEventListener("click", golist);
	}
	
	function goModify(){
		let frm = document.myform;
		frm.action = "score_write.jsp";
		frm.submit();
		// 수정으로 보낼때 seq 값 보내줘야 수정 가능
	}
	function goDelete(){
		if(confirm("삭제하시겠습니까?")){
			let frm = document.myform;
			frm.mode.value = "delete";
			frm.action = "score_proc.jsp";
			frm.submit();
		}
	}
	function golist(){
		location.href = "score_list.jsp";
	}
</script>