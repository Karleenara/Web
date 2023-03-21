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
	
	<button type="button" onclick="loadDoc()">Ajax 호출</button>
	
</body>
</html>
<script>
	function loadDoc(){
		// xhttp객체 생성
		// XMLHttpRequest: 비동기 통신을 담당할 클래스
		// 		xhttp객체에는 onload라는 변수가 있다.
		// 		이 변수에 통신이 완료한 후 호출할 함수의 주소 전달
		// 		화살표 함수 사용 x - 통신내용을 받아올 때 this사용하는데 화살표함수는 this 사용 못함
		let xhttp = new XMLHttpRequest();
		xhttp.onload=function(){
			// 서버로부터 응답이 완료될 때 이 함수 호출됨
			document.getElementById("result").innerHTML = this.responseText;
			// this: xhttp 객체 자신
			// 통신이 완료한 후에 responseText 변수에 서버로부터 전달받은 값이 들어있음
		}
		
	// 서버로 요청
	xhttp.open("GET", "ajax_test.txt", true);
	// GET: 통신방식, GET, POST 중 선택
	// 		POST는 파라미터 전달방식 복잡 
	// 		보통 javascript로 ajax하지 않고 jquery나 axios같은 라이브러리 이용해 ajax 통신
	// 
	// "ajax_test.txt" : 서버의 주소 jsp나 서블릿 호출할 수 있음
	// 		여기선 간단한 text파일을 호출
	// true : 비동기 동기 여부 보통은 true만 사용
	
	// 서버와 통신
	xhttp.send(); 
		
	}
</script>