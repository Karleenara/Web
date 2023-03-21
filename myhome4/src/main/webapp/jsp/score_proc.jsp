<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.kosa.myhome4.CommonUtill"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	
	String username = request.getParameter("username");
	int nKor = Integer.parseInt(CommonUtill.nullToVal(request.getParameter("kor"), "0"));
	int nEng = Integer.parseInt(CommonUtill.nullToVal(request.getParameter("eng"), "0"));
	int nMath = Integer.parseInt(CommonUtill.nullToVal(request.getParameter("math"), "0"));
	int nTotal = nKor + nEng + nMath;
	float avg = nTotal/3.0f;
	// 변수의 값을 출력할 경우 jsp에서는 아래처럼 한다.
	%>
	<%=username%>의 총점은 <%=nTotal %>이고 평균은 <%=avg %> 이다.

</body>
</html>