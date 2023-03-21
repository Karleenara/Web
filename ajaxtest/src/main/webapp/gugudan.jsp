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
	<h1>구구단</h1>
	단 : <input type="text" id="sdan">
	<button id="btnCall" type="button">결과</button><br/>
	<span id="result"></span><br/>

</body>
</html>
<script>
$(()=>{
	$("#btnCall").click(()=>{
		
		let dan = $("#sdan").val();
		
		$.ajax({
			url:"gureceive.jsp",
			data:{"dan":dan}
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