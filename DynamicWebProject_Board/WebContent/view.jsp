<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardVO" %>
<%@ page import="board.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1.0">
<link rel="stylesheet" href="css/bootstrap.css">

<title>Test_Board</title>
</head>
<body>
	<%
		String id = null;
		if(session.getAttribute("id")!=null){
			id = (String) session.getAttribute("id");
		}
		int num =0;
		if(request.getParameter("num")!=null){
			num = Integer.parseInt(request.getParameter("num"));
		}
		if(num == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		//유효한 글일 경우(해당 num에 관련한 글의 정보를 가져온다.)
		BoardVO boardVO = new BoardDAO().getBoardVO(num);
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
					<th colspan="3" style="background-color: #eeeeee; text-align:center;">게시판 글보기</th><!-- 열 -->
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 20%;">글 제목</td>
					<td colspan="2"><%= boardVO.getTitle() %></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td colspan="2"><%= boardVO.getId() %></td>
				</tr>
				<tr>
					<td>작성일자</td>
					<td colspan="2"><%= boardVO.getDate() %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="2" style="min-height: 200px; text-align: left;">
					<!-- replaceAll : 해당글자 정상출력 처리해주기 -->
						<%= boardVO.getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
					</td>
				</tr>
			</tbody>
		</table>

		<a href="bbs.jsp" class="btn btn-success">목록</a>
		
		<%
		if(id!=null && id.equals(boardVO.getId())){
		%>
			<a href="update.jsp?num=<%= num%>" class="btn btn-primary">수정</a>
			<a href="deleteAction.jsp?num=<%= num%>" class="btn btn-danger">삭제</a>
		<%
		}
		%>
	</div>
</div>


<!-- jquery : $(".클래스이름") 이런형태 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>