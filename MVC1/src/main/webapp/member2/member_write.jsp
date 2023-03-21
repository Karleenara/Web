<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
	<form name="myform">
		<input type="text" name="idcheck" id="idcheck" value="N">


		<%@include file="/include/navbar.jsp"%>



		<div class="container mt-3">
			<h3>Navbar With Dropdown</h3>
			<p>This example adds a dropdown menu in the navbar.</p>


			<table class="table">
				<colgroup>
					<col width="30%">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th>아이디
						</td>
						<td>
							<div class="input-group">
								<input type="text" class="form-control" placeholder="아이디를 입력하세요"
									name="user_id" id="user_id"> <a href="#none"
									onclick="goIDCheck()"> <span class="input-group-text">아이디중복체크</span>
								</a>
							</div>
						</td>
					</tr>
					<tr>
						<th>패스워드
						</td>
						<td>
							<div class="input-group">
								<input type="password" class="form-control"
									placeholder="패스워드를 입력하세요" name="password" id="password">
							</div>
						</td>
					</tr>
					<tr>
						<th>패스워드확인
						</td>
						<td>
							<div class="input-group">
								<input type="password" class="form-control"
									placeholder="패스워드를 입력하세요" name="password2" id="password2">
							</div>
						</td>
					</tr>
					<tr>
						<th>이름
						</td>
						<td>
							<div class="input-group">
								<input type="text" class="form-control" placeholder="이름을 입력하세요"
									name="user_name" id="user_name">
							</div>
						</td>
					</tr>
					<tr>
						<th>이메일
						</td>
						<td>
							<div class="input-group">
								<input type="email" class="form-control" placeholder="이름을 입력하세요"
									name="email" id="email">
							</div>
						</td>
					</tr>
					<tr>
						<th>전화번호
						</td>
						<td>
							<div class="input-group">
								<input type="tel" class="form-control" placeholder="전화번호를 입력하세요"
									name="phone" id="phone">
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>


		<div class="container" style="text-align: right">
			<button type="button" class="btn btn-dark" onclick="goSave()">등록</button>
		</div>

	</form>
</body>
</html>
<script>
	function goIDCheck() {
		let xhttp = new XMLHttpRequest();
		let url = "/MVC1/member.do?cmd=idcheck&user_id="
				+ document.getElementById("user_id").value;
		xhttp.onload = function() {
			console.log(this.responseText);
			let data = JSON.parse(this.responseText);
			if (data.result == "success") {
				alert("사용가능한 아이디입니다.");
				document.getElementById("idcheck").value = "Y";
				document.getElementById("user_id").disabled = true; // user_id 태그 비활성화

			}
		}

		xhttp.open("GET", url, true);
		xhttp.send();
	}

	function goSave() {
		if (document.getElementById("idcheck").value != "Y") {
			alert("아이디 중복체크 하세요");
			document.getElementById("user_id").focus();
			return false;
		}
		
		let xhttp = new XMLHttpRequest();
		xhttp.onload = function() {
			let data = JSON.parse(this.responseText);
			if(data.result == "success"){
				alert("회원가입 성공");
				//메인페이지로 이동
				location.href="<%=CONTEXT%>/index.jsp"; 
			}
			else{
				alert("회원가입 실패");
			}
		}
		// 파라미터 만들기
		let params = "cmd=member_save"
		+"&user_id=" + document.getElementById("user_id").value
		+"&password=" + document.getElementById("password").value
		+"&user_name=" + document.getElementById("user_name").value
		+"&phone=" + document.getElementById("phone").value
		+"&email=" + document.getElementById("email").value;
		console.log(params);
		// POST 전달 방식은 GET이랑 다름
		xhttp.open("POST", "/MVC1/member.do", true);
		xhttp.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");
		// params 따로 보내야함
		xhttp.send(params);
	}
</script>






