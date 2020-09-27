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
<link rel="stylesheet" href="css/custom.css">
<title>Test_Board</title>
</head>
<body>
	<%
		String id = null;
		if(session.getAttribute("id")!=null){
			id = (String) session.getAttribute("id");
		}
		
		if(id==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		int num=0;
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
		/* 해당글의 id와 현재 session의 id정보가 같은지 */
		BoardVO boardVO = new BoardDAO().getBoardVO(num);
		if(!id.equals(boardVO.getId())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
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
		
		<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" 
					role="button" aria-haspopup="true"  aria-expanded="false">회원관리<span class="caret"></span></a>
					  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
					    <li><a class="dropdown-item" href="logoutAction.jsp">로그아웃</a></li>
					    
					  </ul>
				</li>
			</ul>


	</div>
</nav>

<div class="container">
	<div class="row">
		<form method="post" action="updateAction.jsp?num=<%= num %>" >
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr><!-- 행 -->
					<th colspan="2" style="background-color: #eeeeee; text-align:center;">게시판 글 수정 양식</th><!-- 열 -->
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="50" value="<%= boardVO.getTitle()%>"></td>
				</tr>
				<tr>
					<td><textarea class="form-control" placeholder="글 내용" name="content" maxlength="2048" style="height: 350px; resize: none;">
						<%= boardVO.getContent() %>
					</textarea></td>
				</tr>
			</tbody>
		</table>
			<input type="submit" class="btn btn-primary pull-right" value="글수정">
		</form>
		
	</div>
</div>


<!-- jquery : $(".클래스이름") 이런형태 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>