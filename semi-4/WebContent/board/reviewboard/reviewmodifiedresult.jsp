<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>리뷰게시글 수정</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>
<%@ include file="../../common/navbar.jsp" %>
<div class="container">
	<%
		if (loginedUser == null) {
			response.sendRedirect("../../loginform.jsp");
			return;
		}
	%>
	<div style="border-bottom: 1px solid grey">
		<h2>리뷰 게시글 수정결과</h2>
	</div><br>
	<div class="row">
		<div class="col-sm-3">
			<div class="row" style="border-bottom: 1px solid grey">
						<h4>고객지원</h4>
					</div>
					<br>
					<div class="row">
						<a href="">공지사항</a>
					</div>
					<br>
					<div class="row">
						<a href="../qnaboard/qnaboard.jsp">QnA게시판</a>
					</div>
					<br>
					<div class="row">
						<a href="reviewboard.jsp">리뷰게시판</a>
					</div>
					<br>
		</div>
		<div class="col-sm-9">
			<div class="jumbotron">
		<h3 class="text-center">게시글 수정 완료</h3>
		</div>
		</div>
		<div class="row" style="height: 550px;">		
			<a href="reviewboard.jsp" class="btn btn-default pull-right">목록</a>
		</div>
	</div>
</div>
<%@ include file="../../common/footer.jsp" %>
</body>
</html>