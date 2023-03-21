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

	<div id="result"></div>
	
	<button type="button" onclick="loadDoc()">JSON결과받아오기</button>
	
</body>
</html>
<script>
	function loadDoc(){
		// xhttp객체 생성
		let xhttp = new XMLHttpRequest();
		xhttp.onload=function(){
			// String -> Json 객체로 변환
			data = JSON.parse(this.responseText);
			let result = "";
			result += "이름: " + data.username + "<br/>";
			result += "이메일: " + data.email + "<br/>";
			result += "번호: " + data.phone + "<br/>";
			document.getElementById("result").innerHTML=result;
			
		}

	// 결과 json으로 보내기
	// 	json은 데이터 형식이 {"키1":"값1",...}
	//	그밖에 html등의 태그도 없어야 함 딱 json 데이터만 전송해야 함
	let url = "receive2.jsp";
	console.log(url);
	// 서버로 요청
	xhttp.open("GET",url, true);
	
	// 서버와 통신
	xhttp.send(); 
		
	}
</script>