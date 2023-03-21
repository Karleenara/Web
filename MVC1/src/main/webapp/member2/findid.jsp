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
			<h3>아이디찾기</h3>
			<p></p>


			<table class="table">
				<colgroup>
					<col width="30%">
					<col width="*">
				</colgroup>
				<tbody>
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
						<th>메일
						</td>
						<td>
							<div class="input-group">
								<input type="password" class="form-control"
									placeholder="메일을 입력하세요" name="email" id="email">
							</div>
						</td>
					</tr>
					
				
				</tbody>
			</table>
		</div>


		<div class="container" style="text-align: right">
			<button type="button" class="btn btn-dark" onclick="goFindid()">찾기</button>
		</div>

	</form>
</body>
</html>
<script>
	function goFindid() {
		let xhttp = new XMLHttpRequest();
		let url = "/MVC1/member.do?cmd=findid_proc&user_name="
				+ document.getElementById("user_name").value
				+ "&email=" +document.getElementById("email").value;
		
		console.log(url);
		xhttp.onload = function() {
			console.log(this.responseText);
			let data = JSON.parse(this.responseText);
			if (data.result == "success") {
				alert("아이디는 "+ data.user_id);
				location.href="<%=CONTEXT%>/member.do?cmd=logon"; 
			}else{
				alert("회원정보가 일치하지 않습니다")
			}
		}

		xhttp.open("GET", url, true);
		xhttp.send();
	}
</script>
