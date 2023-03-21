<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="com.oarone.mvc.manager.*" %>
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
<form name="myform" id="myform">
	<input type="hidden" name="cmd" id="cmd">
	<input type="hidden" name="pg" id="pg">
	

<%@include file="/include/navbar.jsp" %>

<div class="container mt-3" style="margin-top: 50px;">
  <h3 style="color:gray" >Product List</h3>
  <p>This example adds a dropdown menu in the navbar.</p>

	</div>
<%
	List<ManagerDto> list = 
	 (List<ManagerDto>)request.getAttribute("list");

%>

<%
for(int i=0; i<list.size(); i++) {
	ManagerDto dto = list.get(i);
	if(i%4==0 || i==list.size()){%>
	<div class="row"> <!-- 이미지 4개당 한번씩 등장해야 한다 -->
<%}%>
	  <div class="col-sm-3">
	    <div class="thumbnail">
	      <a href="#none">
	        <img 
	        src="<%=CONTEXT%>/upload/product/<%=dto.getImages()%>" 
	        alt="<%=dto.getPr_name()%>" style="width:100%">
	        
	        <div class="caption"><%=dto.getPr_name()%>
	        </div>
	      </a>
	    </div>
	  </div>
	<%if(i%4==3 || i==list.size()-1) {%>
	</div> <!--  end row -->
 <%} 
 }%>

 </div>
 <div class="container" style="text-align:right">
</div>

 <div class="container" style="text-align:right" >
	<button type="button" class="btn text-white" id="btnWrite" style="background-color:gray">글쓰기</button>
 </div>

</form>
</body>
</html>
<script>
$(()=>{
	$("#btnWrite").click(()=>{
		//alert("dfs");
		let frm = $("#myform");
		console.log(frm);
		$("#cmd").val("write");//cmd파라미터에 save 
		frm.prop("action", "<%=CONTEXT%>/manager.do");
		//action속성에 url주는 방식, jquery방식 
		frm.submit();
	})
})


function goPage(page){
	var frm = document.myform;
	frm.pg.value = page;
	frm.cmd.value="list";
	frm.action = "<%=CONTEXT%>/manager.do";
	frm.submit();
}
</script>