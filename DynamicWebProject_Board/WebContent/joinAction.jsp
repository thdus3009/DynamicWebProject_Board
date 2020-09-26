<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %><!-- 받아오는 모든 정보를 utf-8형식으로 바꿔주기 -->

<jsp:useBean id="member" class="member.MemberVO" scope="page"/>
<jsp:setProperty name="member" property="id"/>
<jsp:setProperty name="member" property="pw"/>
<jsp:setProperty name="member" property="name"/>
<jsp:setProperty name="member" property="email"/>
<jsp:setProperty name="member" property="phone"/>
<jsp:setProperty name="member" property="sex"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test_Board</title>
</head>
<body>
 	<!-- java script -->
	<%
		if(member.getId()==null || member.getPw()==null || member.getSex()==null || member.getName()==null 
		|| member.getEmail()==null || member.getPhone()==null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력하지 않은 항목이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			MemberDAO memberDAO = new MemberDAO();
			int result = memberDAO.join(member);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
		}
		
	%>
</body>
</html>