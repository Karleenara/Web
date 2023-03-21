<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- http://localhost:9000/myhome4/jsp/jsptest2.jsp?limit=5 -->
	<%
	String sLimit = request.getParameter("limit");
	int limit = Integer.parseInt(sLimit);
	for(int i=1; i<=limit; i++){
		out.println("i= " + i +"<br/>");
	}
	%>
</body>
</html>