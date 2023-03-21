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
	
	x : <input type="text" id="xvalue"><br/>
	y : <input type="text" id="yvalue"><br/>
	<div id="result"></div>
	
	<button id="btnCall" type="button">ajax call</button>
</body>
</html>
<script>
	$(()=>{
		$("#btnCall").click(()=>{
			
			let x = $("#xvalue").val();
			let y = $("#yvalue").val();
			
			$.ajax({
				url:"receive.jsp",
				data:{"xvalue":x, "yvalue":y}
				})
			.done((data)=>{
				$("#result").html(data);
			})
			.fail((error)=>{
				console.log(error);
			})
		})
	})
</script>