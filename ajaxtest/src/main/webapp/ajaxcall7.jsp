<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Ajax  테스트</h1>
	
	<table style="width:60%; margin:auto">
		<colgroup>
			<col width="33%">
			<col width="33%">
			<col width="33%">
		</colgroup>
		<thead>
			<tr>
				<th>이름</th>
				<th>이메일</th>
				<th>전화번호</th>
			</tr>
		</thead>
		<tbody id="tbody">
		</tbody>
	</table>
	
	<button type="button" onclick="loadDoc()">JSON결과받아오기</button>
	
</body>
</html>
<script>
function loadDoc()
{
	let xhttp = new XMLHttpRequest(); //XMLHttpRequest :비동기 통신을 담당할 클래스
	//비동기 통신담당 객체를 만든다
	//xhttp객체에는 onload라는 변수(특성)가 있다. 이 변수에 통신이 완료한 후에 
	//호출할 함수의 주소를 전달한다. 주의할점 화살표함수를 사용 못한다. 
	//이유는 통신내용을 받아올때 this를 사용해야 하는데 화살표함수는 this 를 
	//사용하지 못한다 
	xhttp.onload=function(){
		//서버로부터 응답이 완료될때 이 함수가 호출된다. 
		data = JSON.parse(this.responseText);
		let tbody = document.getElementById("tbody");
		//배열의 요소마다 호출된다. 
		deleteAll(); //기존의 테이블 데이터를 모두 삭제하자 
		data.forEach( (item)=>{
			let row = tbody.insertRow( tbody.rows.length ); 
			//테이블의 마지막 행을 추가
			let cell1 = row.insertCell(0); //0번 칼럼 추가 
			let cell2 = row.insertCell(1); //1번 칼럼 추가 
			let cell3 = row.insertCell(2);//2번컬럼
			
			cell1.innerHTML = item.username;
			cell2.innerHTML = item.email;
			cell3.innerHTML = item.phone;
		});
	}
	
	let url="/ajaxtest/person.do"; //결과를 json형태로 보낸다.
	//json은 데이터 형식이 {"키1":"값1", "키2":"값2", ...} 그밖에 
	//html등의 태그도 없어야 한다. 딱  json 데이터만 전송해야 한다 
	console.log( url );//url이 잘 만들어졌는지 확인용 코드 
	xhttp.open("GET", url, true); 
	xhttp.send(); 
}

function deleteAll()
{
	let tbody = document.getElementById("tbody");
	for(i=tbody.rows.length-1; i>=0; i--)
	{
		tbody.deleteRow(i);
	}
}
</script>







