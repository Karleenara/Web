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
	}
</style>
</head>
<body>
	<div id="flip">Click</div>
	<div id="panel">Hello world!</div>
</body>
</html>
<script>
	$("#panel").css("display","none");
	/*
	$("#flip").click( ()=>{
		$("#panel").slideUp("fast");
	})
	*/
	
	// 내려갔다가 2초뒤 올라오기
	$("#flip").click( ()=>{
		$("#panel").slideDown("fast", function(){
			// 다 내려오면 콜백함수 호출됨
			// jquery - setTimeout(함수, 시간);
			// 		뒤에 지정한 시간이 흐른 이후에 한번 앞의 함수 호출
			setTimeout(()=>{
				$("#panel").slideUp();
			}, 2000);
		});
	})
</script>