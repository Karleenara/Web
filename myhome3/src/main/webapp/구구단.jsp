<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	단을 입력하세요
	<br />
	<input type="text" name="dan" id="dan">
	<br />
	<button id="btnPress" type="button">구구단보기</button>

	<div id="result"></div>
</body>
</html>

<script>
	window.onload=()=>{
		var btnPress = document.getElementById("btnPress");
		btnPress.addEventListener("click", ()=>{
			console.log("호출 확인");
			result = "";
			dan = document.getElementById("dan").value;
			for(i=1; i<10; i++){
				result += dan + "x" + i + "=" + (dan*i) + "<br/>";
			}
			document.getElementById("result").innerHTML = result;
		});
	}
</script>