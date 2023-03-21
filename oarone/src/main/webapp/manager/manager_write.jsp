<%@page import="com.oarone.mvc.manager.ManagerDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.oarone.mvc.manager.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>  
<style>
  .navbar {
  	padding: 10px ;
    font-family: Montserrat, sans-serif;
    margin-bottom: 0;
    background-color: white;
    border: 0;
    font-size: 11px !important;
    letter-spacing: 4px;
    opacity: 0.9;
  }
</style>

<title>Insert title here</title>
</head>
<body>

<%
//forward  로 페이지 이동이 되면 이전 페이지에서 받았던 파라미터도 가져온다 
String cmd=request.getParameter("cmd");
String seq=request.getParameter("seq");
ManagerDto dto = (ManagerDto)request.getAttribute("dto");
if(dto==null) //cmd=list -> cmd=write 로 온경우에는  dto 가 없다.
{
	dto = new ManagerDto();
}

%>
<form name="myform" id="myform" method="post" enctype="multipart/form-data">
	<input type="hidden" name="cmd" id="cmd">
	<input type="hidden" name="seq" id="seq" value="<%=seq%>">
	
<!-- 메뉴 -->

<%@include file="/include/navbar.jsp" %>


<div class="container mt-3">
  <h3>게시판</h3>
  <p></p>
  

   <table class="table">
   	<colgroup>
   		<col width="30%">
   		<col width="*">
   	</colgroup>
    <tbody>
      <tr>
        <th>이름</td>
        <td>
        	 <div class="input-group">
        	
			    <input type="text" class="form-control" placeholder="제목을 입력하세요"
			    name="pr_name" id="pr_name" value="<%=dto.getPr_name()%>">
			 </div>
        </td>
      </tr>

      <tr>
        <th>가격</td>
        <td>
        	 <div class="input-group">
			    <textarea class="form-control" placeholder="내용 입력하세요"
			    name="price" id="price" rows="5"><%=dto.getPrice()%></textarea>
			 </div>
        </td>
      </tr>
       <tr>
        <th>카테고리</td>
        <td>
        	 <div class="input-group">
			    <textarea class="form-control" placeholder="내용 입력하세요"
			    name="cate" id="cate" rows="5"><%=dto.getPrice()%></textarea>
			 </div>
        </td>
      </tr>
      
       <tr>
        <th>이미지</td>
        <td>
        	 <div class="input-group">
			    <input type="file" class="form-control" 
			    placeholder="이미지를 선택하세요"
			    name="image" id="image">
			 </div>
        </td>
      </tr>
    </tbody>
  </table>
 </div>


 <div class="container" style="text-align:right">
	<button type="button" class="btn text-white" style="background-color:skyblue"
	id="btnSave">저장</button>
 </div>

 </form>
  
</body>
</html>
<script>
$(()=>{
	$("#btnSave").click(()=>{
		$("#cmd").val("save2");
		const formData = new FormData( document.myform );
		console.log(formData); 
		for(key of formData.keys())
		{
			console.log(key, formData.get(key));
		}
		
		$.ajax({
			url:"<%=CONTEXT%>/manager.do",
			data:formData,
			dataType:"JSON",     //받아올 데이터 타입이 json이다. 
			type:"POST",         //파일전송이라 반드시 POST  로
			enctype:"multipart/form-data", //파일전송방식으로 보낸다는 의미임
			processData:false,
			contentType:false
		})
		.done( (response)=>{
			console.log(response);
			if(response.result=="success")
			{
				alert("글이 등록되었습니다");	
				location.href="<%=CONTEXT%>/manager.do?cmd=list";
			}
		})
		.fail( (response, status, error)=>{
			console.log( status );
		})
	})
})
</script>