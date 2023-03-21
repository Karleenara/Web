<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<title>Insert title here</title>
<style>
#panel, #flip {
	padding: 5px;
	text-align: center;
	background-color: #8888ff;
	border: solid 1px #c3c3c3;
}

#panel {
	padding: 50px;
	font-size: 20pt;
}
</style>
</head>
<body>
	<div id="flip">시계시작과종료</div>
	<div id="panel">Hello world!</div>
</body>
</html>

<script>
// 전역변수
let timer1 = null;
// 		자바라면 static 변수
	$("#flip").click( ()=>{
		// 시간마다 함수 호출
		// setInterval 반환값 : 핸들, 객체 식별값
		// timer1변수는 click내에서만 존재하는 지격변수라 이 함수 종료하면 사라짐
		if(timer1!=null){
			ClearTimeout(timer1); // 종료해도 time1이 null이 되지는 않음
			timer1=null; 	// 초기화 직접 하기
		} else{
			timer1 = setInterval(()=>{
				today = new Date();	// 현재 날짜와 시간 구하기
				hour = today.getHours();
				mint = today.getMinutes();
				sec = today.getSeconds();
				
				currentTime = hour+"시 "+mint+"분 "+sec+"초";
				$("#panel").html(currentTime);
			},1000);
		}
	})

</script>