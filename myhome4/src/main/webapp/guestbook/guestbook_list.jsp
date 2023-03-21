<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<form name ="myform">
	<input type="hidden" name = "mode" value="insert">


	<!-- 메뉴 -->
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="#"> <img
				src="/myhome2/images/img_avatar1.png" alt="Avatar Logo"
				style="width: 40px;" class="rounded-pill">
			</a>

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="collapsibleNavbar">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown">Dropdown</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">Link</a></li>
							<li><a class="dropdown-item" href="#">Another link</a></li>
							<li><a class="dropdown-item" href="#">A third link</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>




	<div class="container mt-3">
		<h3>Navbar With Dropdown</h3>
		<p>This example adds a dropdown menu in the navbar.</p>

		<div class="input-group mt-3 mb-3">
			<button type="button" class="btn btn-primary dropdown-toggle"
				data-bs-toggle="dropdown">Dropdown button</button>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="#">Link 1</a></li>
				<li><a class="dropdown-item" href="#">Link 2</a></li>
				<li><a class="dropdown-item" href="#">Link 3</a></li>
			</ul>
			<input type="text" class="form-control" placeholder="Username">
			<div class="input-group-append">
				<button class="btn btn-primary" type="button">GO</button>
			</div>
		</div>
		<%
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@192.168.0.4:1521:xe";
		String userid = "nara";
		String pwd = "skfk";

		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, userid, pwd);
		String sql = "select * from tb_guestbook order by seq desc";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		%>



		<table class="table">
			<thead class="table-dark">
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>내용</td>
					<td>작성일</td>
					<td>조회수</td>
				</tr>
			</thead>
			<tbody>

				<%
				while (rs.next()) {
					//System.out.println(rs.getString("title"));
				%>
				<tr>
					<td><%=rs.getString("seq")%></td>
					<td><a href="/myhome4/guestbook/guestbook_view.jsp?seq=<%=rs.getString("seq")%>"><%=rs.getString("title")%></a></td>
					<td><%=rs.getString("writer")%></td>
					<td><%=rs.getString("contents")%></td>
					<td><%=rs.getString("wdate")%></td>
					<td><%=rs.getString("hit")%></td>
				</tr>
				<%
				}
				rs.close();
				stmt.close();
				conn.close();
				%>
			</tbody>

		</table>
	</div>
	<div class="container" style="text-align: right">
		<ul class="pagination justify-content-center">
			<li class="page-item"><a class="page-link" href="#">first</a></li>
			<li class="page-item"><a class="page-link" href="#">Previous</a></li>
			<li class="page-item"><a class="page-link" href="#">1</a></li>
			<li class="page-item active"><a class="page-link" href="#">2</a></li>
			<li class="page-item"><a class="page-link" href="#">3</a></li>
			<li class="page-item"><a class="page-link" href="#">4</a></li>
			<li class="page-item"><a class="page-link" href="#">5</a></li>
			<li class="page-item"><a class="page-link" href="#">6</a></li>
			<li class="page-item"><a class="page-link" href="#">7</a></li>
			<li class="page-item"><a class="page-link" href="#">8</a></li>
			<li class="page-item"><a class="page-link" href="#">9</a></li>
			<li class="page-item"><a class="page-link" href="#">10</a></li>
			<li class="page-item"><a class="page-link" href="#">Next</a></li>
			<li class="page-item"><a class="page-link" href="#">last</a></li>
		</ul>
	</div>

	<div class="container" style="text-align: right">
		<button type="button" id = "btnWrite" class="btn btn-secondary">글쓰기</button>
	</div>
	
</form>
</body>
</html>
<script>
	window.onload=()=>{
		document.getElementById("btnWrite").addEventListener("click",()=>{
			// wirte.jsp로 이동할 때 hidden 태그 값이 넘어가야 됨
			let frm = document.myform;
			frm.action = "/myhome4/guestbook/guestbook_write.jsp";
			frm.method = "get";
			frm.submit();
			//location.href= "/myhome4/guestbook/guestbook_write.jsp";
		});
	}
</script>