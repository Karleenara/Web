<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="com.kosa.mvc1.gallery.*" %>
<%@page import="com.kosa.mvc1.common.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<!-- jquery 사용은 form의 id 필요 -->
<form name="myform" id="myform">
	<input type="hidden" name="cmd" id="cmd">
	<input type="hidden" name="pg" id="pg">
	


<!-- 메뉴 -->
<%@include file="/include/navbar.jsp" %>


<div class="container mt-3">
  <h3 style="color:skyblue">Gallery</h3>
  <p>This example adds a dropdown menu in the navbar.</p>
  
   <div class="input-group mt-3 mb-3">
	  <button type="button" class="btn text-white dropdown-toggle" data-bs-toggle="dropdown" style="background-color:skyblue">
	    Dropdown button
	  </button>
	  <ul class="dropdown-menu">
	    <li><a class="dropdown-item" href="#">Link 1</a></li>
	    <li><a class="dropdown-item" href="#">Link 2</a></li>
	    <li><a class="dropdown-item" href="#">Link 3</a></li>
	  </ul>
	  <input type="text" class="form-control" placeholder="Username">
	  <div class="input-group-append">
	  	<button class="btn text-white" type="button" style="background-color:skyblue">GO</button>
	  </div>
	</div>

<%
	List<GalleryDto> list = 
	 (List<GalleryDto>)request.getAttribute("list");
	int totalCnt = (int)request.getAttribute("totalCnt");
	

%>

<%
for(int i=0; i<list.size(); i++) {
	GalleryDto dto = list.get(i);
	String url=CONTEXT+"/gallery.do?cmd=view&seq="+dto.getSeq();
	if(i%4==0 || i==list.size()){%>
	<div class="row"> <!-- 이미지 4개당 한번씩 등장해야 한다 -->
<%}%>
	  <div class="col-sm-3">
	    <div class="thumbnail">
	      <a href="#none">
	        <img 
	        src="<%=CONTEXT%>/upload/gallery/<%=dto.getImage()%>" 
	        alt="<%=dto.getTitle()%>" style="width:100%">
	        <div class="caption">
	          <p><a href="<%=url %>"><%=dto.getTitle()%></a></p>
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
	<%=Pager.makeTag(request, totalCnt, 12) %>
</div>

 <div class="container" style="text-align:right">
	<button type="button" class="btn text-white" id="btnWrite" style="background-color:skyblue">글쓰기</button>
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
		frm.prop("action", "<%=CONTEXT%>/gallery.do");
		//action속성에 url주는 방식, jquery방식 
		frm.submit();
	})
})


function goPage(page){
	var frm = document.myform;
	frm.pg.value = page;
	frm.cmd.value="list";
	frm.action = "<%=CONTEXT%>/gallery.do";
	frm.submit();
}
</script>