<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<h1>jquery ajax</h1>
	<div id="result"></div>
	<button id="btnCall" type="button">ajax call</button>
</body>
</html>
<script>
$(()=>{
	$("#btnCall").click( ()=>{
		$.ajax({url:"ajax_test.txt"})
		.done( (data)=>{
			$("#result").html(data);
		})
		.fail( (error)=>{} )
	});
});
</script>