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
			<h3>로그온</h3>
			<p></p>


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
									name="user_id" id="user_id">
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
					
				
				</tbody>
			</table>
		</div>


		<div class="container" style="text-align: right">
			<button type="button" class="btn btn-dark" onclick="goFindid()">아이디찾기</button>
			<button type="button" class="btn btn-dark" onclick="goFindpassword()">패스워드찾기</button>
			<button type="button" class="btn btn-dark" onclick="goLogon()">login</button>
		</div>

	</form>
</body>
</html>
<script>
	function goLogon() {
		
		let user_id = document.getElementById("user_id").value;
		let password = document.getElementById("password").value;
		
		$.ajax({
			url: "<%=CONTEXT%>/member.do",
			data: {cmd:"logon_proc", user_id: user_id, password:password},
			dataType: "JSON",
			method:"POST"
		})
		.done((response)=>{
			if(response.result=="success"){
			location.href="<%=CONTEXT%>/index.jsp"; 
		}else{
			alert("비밀번호 일치하지 않습니다.")
		}
		})
		.fail((response, status, error)=>{
			console.log(status);
		})
	}
	
	function goFindid(){
		location.href="<%=CONTEXT%>/member.do?cmd=findid";
	}
	
	function goFindpassword(){
		location.href="<%=CONTEXT%>/member.do?cmd=findpassword";
	}
</script>






