<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<body>
	<h1>이벤트 연습하기</h1>

</body>
</html>
<script>
	// $(document).ready(()=>{}) 생략가능
	$(document).ready(()=>{
		$("h1").click(()=>{
			console.log("click event 발생");
		})
		
		$("h1").mouseenter(()=>{
			console.log("mouseenter event 발생");
		})
		
		$("h1").hover(function(){
			console.log("hover event 발생")
			$(this).css("background-color", "gray");
		})
		$("h1").mouseleave(function(){
			console.log("mouseleave event 발생");
			$(this).css("background-color", "white");
		})
		
	})
	
</script>