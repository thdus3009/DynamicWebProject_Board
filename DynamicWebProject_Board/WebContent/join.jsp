<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1.0">
<link rel="stylesheet" href="css/bootstrap.css">

<title>Test_Board</title>
</head>
<body>

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
			<li><a href="bbs.jsp">게시판</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" 
				role="button" aria-haspopup="true"  aria-expanded="false">접속하기<span class="caret"></span></a>
				  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				    <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
				    <li class="active"><a class="dropdown-item" href="join.jsp">회원가입</a></li>
				    
				  </ul>
			</li>
		</ul>
	</div>
	
</nav>
<div class="container">
	<div class="col-lg-4"></div>
	<div class="col-lg-4">
		<div class="jumbotron" style="padding-top:20px;">
		<form method="post" action="joinAction.jsp">
			<h3 style="text-align: center;">회원가입 화면</h3>
			
			<div class="form-group">
				<input type="text" class="form-control" placeholder="아이디" name="id" maxlength="20"><!-- class이름 : 부트스트랩 디자인 적용 -->
			</div>
			<div class="form-group">
				<input type="password" class="form-control" placeholder="비밀번호" name="pw" maxlength="20">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="이름" name="name" maxlength="20"><!-- class이름 : 부트스트랩 디자인 적용 -->
			</div>
			<div class="form-group">
				<input type="email" class="form-control" placeholder="이메일" name="email" maxlength="20"><!-- class이름 : 부트스트랩 디자인 적용 -->
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="전화번호" name="phone" maxlength="20"><!-- class이름 : 부트스트랩 디자인 적용 -->
			</div>			
			<div class="form-group" style="text-align: center;">
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-primary active">
						<input type="radio" name="sex" autocomplete="off" value="m" checked>남자
					</label>
					<label class="btn btn-primary">
						<input type="radio" name="sex" autocomplete="off" value="w" checked>여자
					</label>					
				</div>
			</div>	
			
			<input type="submit" class="btn btn-primary form-control" value="회원가입">
		</form>
		</div>
	</div>
</div>

<!-- jquery : $(".클래스이름") 이런형태 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>