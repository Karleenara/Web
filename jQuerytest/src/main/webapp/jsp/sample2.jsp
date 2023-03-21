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
	<h1>jquery test1</h1>
	<h1>jquery test2</h1>
	<h1 id="test1">jquery test3</h1>
	<h1 id="test1">jquery test4</h1>
	<h1 class="test1">jquery test5</h1>
	<h1 class="test1">jquery test6</h1>
	<h1 class="test1">jquery test7</h1>
	
	<button type="button" id="btnClick1">태그로 접근하기</button>
	<button type="button" id="btnClick2">id로 접근하기</button>
	<button type="button" id="btnClick3">클래스로 접근하기</button>

</body>
</html>
<script>
	$(document).ready( ()=>{
		$("#btnClick1").click( ()=>{
		$("h1").html("태그로 접근하기");
	});
	
	$("#btnClick2").click( ()=>{
		$("#test1").html("아이디로 접근하기");	// 첫번째것만 영향 받음
	});
	
	$("#btnClick3").click( ()=>{
		$(".test1").html("클래스로 접근하기");	// 첫번째것만 영향 받음
	});
	
	$("h1").click( function(){
		$(this).html("this로 접근하기");
	})
	});
</script>
