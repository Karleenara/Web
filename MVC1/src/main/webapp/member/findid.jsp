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
		
		<div class="container" id="findid" style="text-align:center"></div>

	</form>
</body>
</html>
<script>
	function goFindid() {
		data = {
				cmd:"findid_proc", 
				user_name: $("#user_name").val(),
				email: $("#email").val()
		}
		
		$.ajax({
			url: "<%=CONTEXT%>/member.do",
			data: data,
			dataType: "JSON",
			method: "POST"
			})
			.done((response)=>{
				if(response.result == "success"){
					$("#findid").html("고객님의 아이디는 " +response.user_id);					
				}else{
					alert("일치하는 정보가 없습니다");
				}
			})
			
			.fail((response, status, error)=>{
				console.log(response);
				console.log(status);
				console.log(error);
			})

	}

</script>
