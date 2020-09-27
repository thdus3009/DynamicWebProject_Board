<%@page import="board.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardVO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %><!-- 받아오는 모든 정보를 utf-8형식으로 바꿔주기 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");			
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
		
		
		else{

			BoardDAO boardDAO = new BoardDAO();
			int result = boardDAO.delete(num);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글삭제에 실패하였습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			}
		}
		
	%>
</body>
</html>