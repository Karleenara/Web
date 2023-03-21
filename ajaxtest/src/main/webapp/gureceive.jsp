<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sDan = request.getParameter("dan");
	int dan = Integer.parseInt(sDan);
%>
<%for(int i=1; i<10; i++){ %>
	<%=String.format("%d * %d = %d", dan,i,dan*i)%><br/>
	<%}%>