<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name="myform">
		이름: <input type="text" name="username"><br/>
		주당 근무시간: <input type="text" name = "time"><br/>
		시간당 단가: <input type="text" name = "timepay"><br/>
		<br/>
		<button type="button" id="btnResult">결과</button>
	</form>

</body>
</html>
<script>
	window.onload=()=>{
		let btnResult = document.getElementById("btnResult");
		btnResult.addEventListener("click", (e)=>{
			let frm = document.myform;
			
			if(frm.username.value.trim()==""){
				alert("이름 입력:")
				frm.username.focus();
				return false;
			}
			
			if(frm.time.value.trim()==""){
				alert("주당 근무시간 입력:")
				frm.time.focus();
				return false;
			}
			
			if(frm.timepay.value.trim()==""){
				alert("시간당 당가 입력")
				frm.timepay.focus();
				return false;
			}
			
			frm.method="get";
			frm.action="/myhome4/Pay";
			frm.submit();
		})
		
	}
</script>