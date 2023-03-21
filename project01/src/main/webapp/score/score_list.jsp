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
<form name="myform">
	<input type="hidden" name="mode" value="insert">
	<h3>성적확인</h3>
	<div>
		<%
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@192.168.0.4:1521:xe";
		String userid = "nara";
		String pwd = "skfk";

		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, userid, pwd);
		String sql = "select seq, name, kor, eng, mat," + "(kor+eng+mat) total, round((kor+eng+mat)/3,2) average,"
				+ "to_char(wdate, 'yyyy-mm-dd') wdate from tb_score order by seq";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		%>

		<table class="table">
			<thead>
				<tr>
					<td>번호</td>
					<td>이름</td>
					<td>국어점수</td>
					<td>영어점수</td>
					<td>수학점수</td>
					<td>총합</td>
					<td>평균</td>
					<td>날짜</td>
				</tr>
			</thead>
			<tbody>
				<%
				while (rs.next()) {
					//System.out.println(rs.getString("name"));
				%>
				<tr>
					<td><%=rs.getString("seq")%></td>
					<td><a href="score_view.jsp?seq=<%=rs.getString("seq")%>"><%=rs.getString("name")%></a></td>
					<td><%=rs.getString("kor")%></td>
					<td><%=rs.getString("eng")%></td>
					<td><%=rs.getString("mat")%></td>
					<td><%=rs.getString("total")%></td>
					<td><%=rs.getString("average")%></td>
					<td><%=rs.getString("wdate")%></td>
				</tr>
				<%
				}
				rs.close();
				stmt.close();
				conn.close();
				%>
			</tbody>
		</table>
		<div class="container" style="text-align: right">
			<button type="button" class="btn btn-secondary" id="btnWrite">성적등록</button>
		</div>
</form>
</body>
</html>
<script>
	window.onload =()=>{
		// 1. 버튼에 대한 참조 가져오기
		let btnSend = document.getElementById("btnWrite");		
		// 2. 버튼 객체에 이벤트 헨들러 연결
		btnSend.addEventListener("click", (e)=>{
			e.preventDefault();
			let frm = document.myform;
			// 데이터 DB에 저장
			frm.action = "score_write.jsp"; 
			frm.method = "post";
			frm.submit(); // 서버로 전송
		})
	}
</script>