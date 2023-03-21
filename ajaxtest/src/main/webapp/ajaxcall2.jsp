<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Ajax test</h1>
	
	<!-- ajax는 form태그로 전송하지 x 선택적으로 사용가능 -->
	x: <input type="text" id="xvalue"><br/>
	y: <input type="text" id="yvalue"><br/>
	
	<div id="result"></div>
	
	<button type="button" onclick="loadDoc()">Ajax 호출</button>
	
</body>
</html>
<script>
	function loadDoc(){
		// xhttp객체 생성
		let xhttp = new XMLHttpRequest();
		xhttp.onload=function(){
			// 서버로부터 응답이 완료될 때 이 함수 호출됨
			document.getElementById("result").innerHTML = this.responseText;
		}
	
	// get 방식일 경우에 receive.jsp?xvalue=5&yvalue=8 형태로 url 만듬
	let url = "receive.jsp?xvalue="+document.getElementById("xvalue").value + "&yvalue="+ document.getElementById("yvalue").value;
	console.log(url);
	// 서버로 요청
	xhttp.open("GET",url, true);
	
	// 서버와 통신
	xhttp.send(); 
		
	}
</script>