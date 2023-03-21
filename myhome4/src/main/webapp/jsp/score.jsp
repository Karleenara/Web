<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name = "myform" action = "/myhome4/jsp/score_proc.jsp">
		이름 : <input type="text" name="username"><br/> 
		국어 : <input type="text" name="kor"><br/>
		영어 : <input type="text" name="eng"><br/>
		수학 : <input type="text" name="math"><br/>
		<br/>
		<button type="button" id="btnResult">결과</button>
	</form>
</body>
</html>
<script>
	window.onload=()=>{
		let btnResult = document.getElementById("btnResult");
		btnResult.addEventListener("click",(e)=>{
			let frm=document.myform;

			// 한글은 get방식으로 보내면 안됨. 한글 변환작업 거쳐서 서버로 보낸다
			// 응답을 받는 쪽에서는 request.setCharacterEncoding("utf-8")
			frm.method="post";
			// 이미 action에 값 들어가 있어서 url로 이동
			//frm.action="/myhome4/Score";
			frm.submit();
		})
	}
	
</script>