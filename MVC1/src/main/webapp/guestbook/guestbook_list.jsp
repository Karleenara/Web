<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.kosa.mvc1.guestbook.*" %>
<%@ page import="com.kosa.mvc1.common.*" %>
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
<%
	String pg=request.getParameter("pg");
	String searchOpt = request.getParameter("searchOpt");
	String searchKey = request.getParameter("searchKey");
	if(pg==null || pg.equals("")) pg="0";
	if(searchOpt==null) searchOpt ="";
	if(searchKey==null) searchKey="";
%>

<form name="myform" >
	<input type="hidden" name="cmd" />
	<input type="hidden" name="pg">
	<input type="hidden" name="searchOpt" id="searchOpt" value="<%=searchOpt%>"/>
<!-- 메뉴 -->

<%@include file="/include/navbar.jsp" %>

<div class="container mt-3">
  <h3 style="color:pink">Board</h3>
  <p></p>
  
   <div class="input-group mt-3 mb-3">
	  <button type="button" class="btn text-white dropdown-toggle" style="background-color: pink;" data-bs-toggle="dropdown">
	    <span id="select">Select</span>
	  </button>
	  <ul class="dropdown-menu">
	    <li><a class="dropdown-item" href="#none" onclick="goSelect('1')">Title</a></li>
	    <li><a class="dropdown-item" href="#none" onclick="goSelect('2')">Contents</a></li>
	    <li><a class="dropdown-item" href="#none" onclick="goSelect('3')">Title + Contents</a></li>
	  </ul>
	  <input type="text" class="form-control" placeholder="검색어를 입력하세요" name="searchKey" id="searchKey" value="<%=searchKey%>">
	  <div class="input-group-append">
	  	<button class="btn text-white" type="button" style="background-color: pink;" onclick="goSearch()">GO</button>
	  </div>
	</div>

   <table class="table">
    	<!-- 테이블의 열별로 공통 스타일을 적용하고자 할때 사용
    	     각 컬럼의 크기 지정에 많이 사용된다.  -->
    	<colgroup>
    		<col style="width:8%">
    		<col style="width:*">
    		<col style="width:12%">
    		<col style="width:12%">
    		<col style="width:16%">
    		<col style="width:12%">
    	</colgroup>
    
    <thead class="table-dark">
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성자ID</th>
        <th>작성일</th>
        <th>조회수</th>
      </tr>
    </thead>
    <tbody>
      <%
	  int totalCnt = (int)request.getAttribute("totalCnt");
      List<GuestbookDto> list = 
             (List<GuestbookDto>)request.getAttribute("list");
     //다운캐스팅을 하자 
    for(GuestbookDto dto : list){
    	String url=CONTEXT+"/guestbook.do?cmd=view&seq="+dto.getSeq();
      %>
      <tr>
      	<!-- Rnum은 최근 게시글이 추가될 때마다 1번으로 뒤에 게시글들의 번호가 밀림
      		전체게시글수 - Rnum으로 게시글이 추가되면 1씩 더해서 계산 -->
        <td><%=totalCnt-dto.getRnum()+1%></td>
        <td><a href="<%=url%>"><%=dto.getTitle()%></a></td>
        <td><%=dto.getUser_name()%></td>
        <td><%=dto.getWriter()%></td>
        <td><%=dto.getWdate()%></td>
        <td><%=dto.getHit()%></td>
      </tr>
   <%}%>
      
    </tbody>
  </table>
 </div>
 <div class="container" style="text-align:right">
	<%=Pager.makeTag(request, totalCnt, 10) %>
</div>

 <div class="container" style="text-align:right">
	<button type="button" class="btn" style="background-color: pink;" id="btnWrite">글쓰기</button>
 </div>

 </form>
 
</body>
</html>
<script>
let titles=["Select", "Title", "Contents", "Title + Contents"];
window.onload=()=>{
	// javascript에서 java code 사용 가능
	let sel = '<%=searchOpt%>';
	if(sel == "")
		$("#select").html(titles[0]);
	else
		$("#select").html(titles[sel]);
		
	let btnWrite = document.getElementById("btnWrite");
	btnWrite.addEventListener("click", ()=>{
		// user_id 없을 때(로그인 안했을 때) 글쓰기하면 로그인 하세요 알림
		let user_id = "<%=session.getAttribute("user_id")%>";
		console.log(user_id);
		if(user_id=="null" || user_id==""){
			alert("로그인을 하세요");
			location.href="<%=CONTEXT%>/member.do?cmd=logon";
			return;
		}
		
		let frm = document.myform;
		frm.action="<%=CONTEXT%>/guestbook.do";
		frm.cmd.value="write";
		frm.submit();
	});
}

function goPage(page){
	var frm = document.myform;
	frm.pg.value = page;
	frm.cmd.value="list";
	frm.action = "<%=CONTEXT%>/guestbook.do";
	frm.submit();
}

function goSelect(sel){
	$("#searchOpt").val(sel);
	let titles=["", "Title", "Contents", "Title + Contents"];
	$("#select").html(titles[sel]);
	// li태그는 value 없음. 그래서 hidden 태그에 값 저장
}

function goSearch(){
	var frm = document.myform;
	frm.pg.value = 0;	// 현재 페이징정보가 : 32페이지, 검색 누를때 첫 번째 페이지로 이동(초기화) 하자
	frm.cmd.value="list";
	frm.action = "<%=CONTEXT%>/guestbook.do";
	frm.submit();
}

</script>

