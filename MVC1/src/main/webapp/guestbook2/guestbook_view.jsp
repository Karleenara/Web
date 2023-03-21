<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.kosa.mvc1.guestbook.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	GuestbookDto dto = (GuestbookDto)request.getAttribute("dto");
%>
<ul>
	<li><%=dto.getTitle()%></li>
	<li><%=dto.getWriter()%></li>
	<li><%=dto.getContents()%></li>
	<li><%=dto.getWdate()%></li>
	<li><%=dto.getHit()%></li>
</ul>
</body>
</html>


