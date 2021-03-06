<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardVO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1.0">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<style type="text/css">
	a,a:hover {
		color : #000000;
		text-decoration : none;
	}
</style>
<title>Test_Board</title>
</head>
<body>
	<%
		String id = null;
		if(session.getAttribute("id")!=null){
			id = (String) session.getAttribute("id");
		}
		
		int pageNumber=1;
		if(request.getParameter("pageNumber")!=null){ //페이지번호 파라미터로 넘기기
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
		
<nav class="navbar navbar-default">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
		data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
		aria-expanded="false">
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="main.jsp">jsp 게시판</a>
	</div>
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="main.jsp">메인</a></li>
			<li class="active"><a href="bbs.jsp">게시판</a></li>
		</ul>
		
		<%
			if(id == null){
		%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" 
					role="button" aria-haspopup="true"  aria-expanded="false">접속하기<span class="caret"></span></a>
					  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
					    <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
					    <li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
					    
					  </ul>
				</li>
			</ul>		
		<% 
			} else {
		%>
		
		<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" 
					role="button" aria-haspopup="true"  aria-expanded="false">회원관리<span class="caret"></span></a>
					  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
					    <li><a class="dropdown-item" href="logoutAction.jsp">로그아웃</a></li>
					    
					  </ul>
				</li>
			</ul>
		<% 
			}
		%>
	</div>
</nav>

<div class="container">
	<div class="row">
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr><!-- 행 -->
					<th style="background-color: #eeeeee; text-align: center;">번호</th><!-- 열 -->
					<th style="background-color: #eeeeee; text-align: center;">제목</th>
					<th style="background-color: #eeeeee; text-align: center;">작성자</th>
					<th style="background-color: #eeeeee; text-align: center;">작성일</th>
				</tr>
			</thead>
			<tbody>
				<% 
					BoardDAO boardDAO = new BoardDAO();
					ArrayList<BoardVO> list = boardDAO.getList(pageNumber);
					for(int i=0; i<list.size(); i++){
				%>		
				<tr>
					<td><%=list.get(i).getNum() %></td>
					<td><a href="view.jsp?num=<%= list.get(i).getNum() %>"> <%=list.get(i).getTitle() %></a></td>
					<td><%=list.get(i).getId() %></td>
					<td><%=list.get(i).getDate() %></td>
				</tr>
				<%		
					}
				%>
			</tbody>
		</table>
		
		<%
			if(pageNumber != 1){
		%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber-1%>" class="btn btn-success btn-arrow-left">이전</a>
		<%  } if(boardDAO.nextPage(pageNumber+1)){ %>
			<a href="bbs.jsp?pageNumber=<%=pageNumber+1%>" class="btn btn-success btn-arrow-left">다음</a>
		<% 
			}
		%>
		
		<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
	</div>
</div>


<!-- jquery : $(".클래스이름") 이런형태 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>