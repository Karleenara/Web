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
	<p> p태그1</p>
	<p> p태그2</p>
	<p> p태그3</p>
	<p> p태그4</p>
	<p> p태그5</p>
	<p class="intro"> p태그6</p>
	<p > p태그7</p>
	<p class="intro"> p태그8</p>
	<p class="intro"> p태그9</p>
	
	<h3 class="intro">h3태그1</h3>
	<h3 class="intro">h3태그2</h3>
	<h3 class="intro">h3태그3</h3>
	<button type="button" id="btnClick1">전체적용</button>
	<button type="button" id="btnClick2">클래스적용1</button>
	<button type="button" id="btnClick3">클래스적용2</button>
	<button type="button" id="btnClick4">첫번째</button>
	<br/>

	<table>
		<tr>
			<td>1행1열</td>
		</tr>
		<tr>
			<td>2행1열</td>
		</tr>
		<tr>
			<td>3행1열</td>
		</tr>
		<tr>
			<td>4행1열</td>
		</tr>
		<tr>
			<td>5행1열</td>
		</tr>
	</table>
	<button type="button" id="btnChange">테이블 선택</button>

</body>
</html>
<script>
	$(document).ready(()=>{
		
		$("#btnClick1").click( ()=>{
			// "*" 전체적용
			$("*").css("color","green");	// 스타일 바꾸기
		})
		
		$("#btnClick2").click( ()=>{
			$(".intro").css("color", "pink");
		})
		
		$("#btnClick3").click( ()=>{
			$("p.intro").css("color", "yellow");
		})
		
		$("#btnClick4").click( ()=>{
			$("p:first").css("background-color", "gray");
			$("h3:last").css("background-color", "cyan");
		})
		
		$("#btnChange").click( ()=>{
			// tr 짝수만
			$("tr:even").css("background-color","purple");
		})
	})

</script>
