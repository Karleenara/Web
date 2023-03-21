<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name = "myform">
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
			
			if(frm.username.value.trim()==""){
				alert("이름 입력:")
				frm.username.focus();
				return false;
			}
			
			if(frm.kor.value.trim()==""){
				alert("국어점수 입력:")
				frm.kor.focus();
				return false;
			}
			
			if(frm.eng.value.trim()==""){
				alert("영어점수 입력:")
				frm.eng.focus();
				return false;
			}
			if(frm.math.value.trim()==""){
				alert("수학점수 입력:")
				frm.math.focus();
				return false;
			}
			
			frm.method="get";
			frm.action="/myhome4/Score";
			frm.submit();
		})
	}
	
</script>