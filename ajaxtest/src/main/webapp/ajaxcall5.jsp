<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Ajax test</h1>

	<table style="width:60%; margin:auto">
		<colgroup>
			<col width="50%">
			<col width="50%">
		</colgroup>
		<thead>
			<tr>
				<th>이름</th>
				<th>이메일</th>
			</tr>
		</thead>
		<tbody id="tbody">
		</tbody>
	</table>
	
	<button type="button" onclick="loadDoc()">JSON결과받아오기</button>
</body>
</html>
<script>
	function loadDoc(){
		// xhttp객체 생성
		let xhttp = new XMLHttpRequest();
		xhttp.onload=function(){
			// String -> Json 객체로 변환
			data = JSON.parse(this.responseText);
			let tbody = document.getElementById("tbody");
			
			deleteAll(); // 기존 테이블 데이터 모두 삭제하자
			// 배열의 요소마다 호출
			data.forEach((item)=>{
				let row = tbody.insertRow(tbody.rows.length);
				
				let cell1 = row.insertCell(0)	// 0번 칼럼 추가
				let cell2 = row.insertCell(1)	// 1번 칼럼 추가
				
				cell1.innerHTML = item.username;
				cell2.innerHTML = item.email;
			})
			
			
			
		}

	// 결과 json으로 보내기
	// 	json은 데이터 형식이 {"키1":"값1",...}
	//	그밖에 html등의 태그도 없어야 함 딱 json 데이터만 전송해야 함
	let url = "receive3.jsp";
	console.log(url);
	// 서버로 요청
	xhttp.open("GET",url, true);
	
	// 서버와 통신
	xhttp.send(); 
		
	}
	
	function deleteAll(){
			let tbody = document.getElementById("tbody");
			for(i=tbody.rows.length; i> 0; i--){
				tbody.deleteRow(i);
			}
	}
</script>