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
		<input type="hidden" name="operator" id="operator">
		x : <input type="text" name="x"><br /> 
		y : <input type="text" name="y"><br />
		<br />
		<button type="text" id="btnAdd">더하기</button>
		<button type="text" id="btnSub">빼기</button>
		<button type="text" id="btnMul">곱하기</button>
		<button type="text" id="btnDiv">나누기</button>
	</form>
</body>
</html>
<script>
	window.onload=()=>{
		let btnAdd = document.getElementById("btnAdd");
		btnAdd.addEventListener("click",goSend); // 함수 주소 전달
		btnSub.addEventListener("click",goSend);
		btnMul.addEventListener("click",goSend);
		btnDiv.addEventListener("click",goSend);
	}

	function goSend(e){
		
			console.log(e.target);
			
			if(e.target==btnAdd)
				document.getElementById("operator").value="1";
			else if(e.target==btnSub)
				document.getElementById("operator").value="2";
			else if(e.target==btnMul)
				document.getElementById("operator").value="3";
			else
				document.getElementById("operator").value="4";
		

			
			e.preventDefault(); // target의 기본이벤트 동작 막음
			let frm = document.myform; // form 안에 객체 가져옴
			
			// 입력데이터 안넣고 버튼만 누른 경우
			// trim: 데이터 양쪽 공백 없앰
			if(frm.x.value.trim()==""){
				alert("숫자 입력:")
				frm.x.focus(); // 커서 이동시킴
				return false;
			}
			
			if(frm.y.value.trim()==""){
				alert("숫자 입력:")
				frm.y.focus();
				return false;
			}
			
			frm.method="get";
			frm.action = "/myhome4/add"; // 서블릿 url 응답할 url
			frm.submit();
		}
</script>