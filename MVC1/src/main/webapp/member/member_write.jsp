<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
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
						<th>아이디</th>
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
						<th>패스워드</th>
						<td>
							<div class="input-group">
								<input type="password" class="form-control"
									placeholder="패스워드를 입력하세요" name="password" id="password">
							</div>
						</td>
					</tr>
					<tr>
						<th>패스워드확인</th>
						<td>
							<div class="input-group">
								<input type="password" class="form-control"
									placeholder="패스워드를 입력하세요" name="password2" id="password2">
							</div>
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<div class="input-group">
								<input type="text" class="form-control" placeholder="이름을 입력하세요"
									name="user_name" id="user_name">
							</div>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<div class="input-group">
								<input type="email" class="form-control" placeholder="이름을 입력하세요"
									name="email" id="email">
							</div>
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
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
		
		let user_id = document.getElementById("user_id").value;
		// 체이닝 기술 객체().함수호출().함수호출()...
		$.ajax({
			url: "<%=CONTEXT%>/member.do",
			data: {cmd:"idcheck", user_id:user_id},
			dataType: "JSON",
			method:"POST"
		})
		// ajax는 기본이 비동기 처리라서 반환값 사용x 
		// 일을 수행한 후 성공시 done 에 전달된 함수 호출, 실패시 fail에 전달된 함수 호출
		.done( (response)=>{
			// 응답 받아서 처리 
			// 응답 dataType:"JSON"으로 보내면 JSON객체 전달받음
			// 자동 parsing
			console.log(response)
			if(response.result == "success"){
				alert("사용가능한 아이디 입니다");
				$("#idcheck").val("Y");
				$("#user_id").prop("disabled", true);
			}
			else{
				alert("이미 존재하는 아이디 입니다");
			}
		})	
		.fail((request, status, error)=>{
			console.log(request);
			console.log(status);
			console.log(error);
		})		
	}
	
	function goSave() {
		if($("#idcheck").val()=="N"){
			alert("아이디 중복체크를 하세요");
			$("#user_id").focus();
			return false;
		}
		
		let user_id = $("#user_id").val();
		let password = $("#password").val();
		let email = $("#email").val();
		let user_name = $("#user_name").val();
		let phone = $("#phone").val();
		
		$.ajax({
			url: "<%=CONTEXT%>/member.do",
			data :{cmd:"member_save", user_id: user_id, email:email,
				password:password, user_name: user_name, phone:phone},
			dataType: "JSON",
			method:"POST"
		})
		.done((response)=>{
			if(response.result=="success"){
				alert("회원가입되셨습니다");
				location.href = "<%=CONTEXT%>/index.jsp";
			}else
			{
				alert("회원가입에 실패했습니다");
			}
		})
		.fail((response, status, error)=>{
			console.log(status);
		})
	}

	

</script>






