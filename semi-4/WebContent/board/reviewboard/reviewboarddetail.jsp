<%@page import="com.semi4.vo.Like"%>
<%@page import="com.semi4.dao.LikeDao"%>
<%@page import="com.semi4.vo.Comment"%>
<%@page import="com.semi4.dao.CommentDao"%>
<%@page import="com.semi4.vo.ReviewBoard"%>
<%@page import="com.semi4.dao.ReviewBoardDao"%>
<%@page import="com.semi4.utils.StringUtils"%>
<%@page import="com.semi4.vo.Admin"%>
<%@page import="com.semi4.vo.QnaAnswer"%>
<%@page import="java.util.List"%>
<%@page import="com.semi4.dao.QnaAnswerDao"%>
<%@page import="com.semi4.dao.UserDao"%>
<%@page import="com.semi4.utils.NumberUtils"%>
<%@page import="com.semi4.vo.QnaBoard"%>
<%@page import="com.semi4.dao.QnaBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>리뷰 게시글 상세 정보</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<%@ include file="../../common/navbar.jsp"%>
<body>
	<div class="container">
		<div style="border-bottom: 1px solid grey;">
			<h2>리뷰 게시글 상세 정보</h2>			
		</div>
		<div class="col-sm-12">
			<table class="table" style="border: 1px solid grey;">
				<colgroup>
					<col width="10%">
					<col width="60%">
				</colgroup>
				<%
					request.setCharacterEncoding("utf-8");

					String from = request.getParameter("from");
					int pageNo = Integer.parseInt(request.getParameter("pageno"));
					int reviewNo = Integer.parseInt(request.getParameter("reviewno"));
					ReviewBoardDao reviewboardDao = ReviewBoardDao.getInstance();
					ReviewBoard board = reviewboardDao.getReviewBoardByNo(reviewNo);
					
					int likeCount = board.getLikeCount();
					
					int count = board.getCount();
					count++;
					board.setCount(count);

					reviewboardDao.updatereviewcount(board);
				%>
				<thead>
					<tr class="active">
						<th>글번호</th>
						<th><%=board.getNo()%></th>
					</tr>
					<tr>
						<th>제목</th>
						<th><%=board.getTitle()%></th>
					</tr>
					<tr class="active">
						<th>글쓴이</th>
						<th><%=board.getUser().getName()%></th>
					</tr>
					<tr>
						<th style="vertical-align: top;">본문</th>
						<th><textarea class="col-12" style="width: 100%; min-height : 300px;  resize: none; border: 0;" readonly><%=board.getContent()%></textarea></th>
					</tr>
					<tr class="active">
						<th>조회수</th>
						<th><%=board.getCount()%></th>
					</tr>
					<tr>
						<th>좋아요</th>
						<th><%=board.getLikeCount() %></th>
					</tr>
				</thead>
			</table>
			<div class="row">
				<div class="col-sm-6">
					<%
						if (loginedUser != null && loginedUser.getNo().intValue() == board.getUser().getNo().intValue()) {
					%>
					<a
						href="reviewmodify.jsp?reviewno=<%=board.getNo()%>&pageno=<%=pageNo%>&from=<%=from %>"
						class="btn btn-warning">수정</a> <a
						href="reviewdeletereg.jsp?reviewno=<%=board.getNo()%>&pageno=<%=pageNo %>&from=<%=from %>"
						class="btn btn-danger">삭제</a>
					<%
						} else {
					%>
					<a href="" class="btn btn-warning disabled">수정</a> <a href="" class="btn btn-danger disabled">삭제</a>
					<%
						}
					%>
				</div>
				<div class="col-sm-6">
					<div class="pull-right">
						<%
							LikeDao likeDao = LikeDao.getInstance();
						
							if (loginedUser != null) {							
								Like setlike = new Like();
								ReviewBoard setboard = new ReviewBoard();
								setboard.setNo(reviewNo);
								setlike.setReviewBoard(setboard);
								setlike.setUser(loginedUser);
								int like = likeDao.getlikeByNoes(setlike);
								if (like == 0) {
						%>
						<a href="reviewboardlikeup.jsp?reviewno=<%=reviewNo %>&pageno=<%=pageNo %>&from=<%=from %>" class="btn btn-default"><span class="glyphicon glyphicon-thumbs-up"></span></a>
						<%
								} else if (like == 1) {
						%>
						<a href="reviewboardlikedown.jsp?reviewno=<%=reviewNo %>&pageno=<%=pageNo %>&from=<%=from %>" class="btn btn-info"><span class="glyphicon glyphicon-thumbs-up"></span></a>
						<%
								}
							} else {
						%>
						<a href="" class="btn btn-default disabled"><span class="glyphicon glyphicon-thumbs-up"></span></a>
						<%
							}
						%>
						
						<%
							if ("reviewboard.jsp".equals(from)) {
						%>
							<a href="reviewboard.jsp?pageno=<%=pageNo%>&from=<%=from %> %>" class="btn btn-success">목록</a>
						<%
							} else if("userreviewform.jsp".equals(from)) {
						%>
							<a href="../../user/userreviewform.jsp?" class="btn btn-success">돌아가기</a>
						<%
							} 
						%>
						
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12"
				style="border-bottom: 1px dotted #999; padding-top: 10px;">
				<%
					CommentDao commentDao = CommentDao.getInstance();
					List<Comment> comments = commentDao.getCommentByReviewNo(reviewNo);

					for (Comment comment : comments) {
				%>
				<strong><%=comment.getUser().getName()%></strong>
				<%				
					
						if (loginedUser != null && loginedUser.getNo().intValue() == comment.getUser().getNo().intValue()) {
				%>
				<div id="first-box-<%=comment.getNo()%>" class="pull-right">

					<button class="btn btn-warning btn-xs" onclick="goModify(<%=comment.getNo()%>)">댓글수정</button>
					<a href="commentdeletereg.jsp?commentno=<%=comment.getNo()%>&reviewno=<%=reviewNo %>&pageno=<%=pageNo %>&from=<%=from %>" class="btn btn-danger btn-xs">댓글삭제</a>
				</div>
				<%
					} else {
				%>
				<div class="pull-right">
					<button class="btn btn-warning btn-xs disabled">댓글수정</button>
					<a href="" class="btn btn-danger btn-xs disabled">댓글삭제</a>
				</div>
				<%					
					}
				%>
				<p id="first-content-<%=comment.getNo()%>"><%=comment.getContent()%></p>
				<form id="second-form-<%=comment.getNo()%>" method="post" action="commentmodified.jsp"
					style="display: none; margin-bottom: 10px;">
					<input type="hidden" name="commentno" value="<%=comment.getNo()%>" />
					<input type="hidden" name="pageno" value="<%=pageNo%>" />
					<input type="hidden" name="from" value="<%=from%>" />
					<div id="second-box-<%=comment.getNo()%>" class="pull-right">
						<button type="button" class="btn btn-default btn-xs" onclick="submitreply(<%=comment.getNo()%>)">댓글 수정</button>
						<button type="button" class="btn btn-default btn-xs" onclick="backreply(<%=comment.getNo()%>)">취소</button>
					</div>
						<textarea id="comment-content-<%=comment.getNo()%>" class="form-control" name="commentcontent" style="margin-bottom: 10px;"><%=comment.getContent() %></textarea>
				</form>
				<br>
		<%
			}

			if (loginedUser != null) {
		%>
		<form id="comment-add" action="commentaddreg.jsp" class="well" method="get" action="commentadd.jsp" style="margin-top: 15px;">
			<input type="hidden" name="pageno" value="<%=pageNo%>" /> 
			<input type="hidden" name="reviewno" value="<%=reviewNo%>" /> 
			<input type="hidden" name="from" value="<%=from%>" /> 
			<label>댓글쓰기</label>
			<textarea class="form-control" id="addcomment-content" name="commentcontent" rows="3"></textarea>
			<br>
			<button class="btn btn-info pull-right" type="button" onclick="addSubmit()">등록</button>
			<br>
		</form>
		<br>
		<%
			}
		%>
			</div>
		</div>

	<br>
	</div>
</body>
		<%@ include file="../../common/footer.jsp"%>

	<script type="text/javascript">		
		function countUp() {
			var likeup = document.getElementById("like-up").value;
			
			likeup +1;
			document.getElementById("like-up").value = likeup;
			
			document.getElementById("like-form").submit();
		}
		function goModify(commentNo) {
			document.getElementById("first-box-" + commentNo).style.display = "none";
			document.getElementById("first-content-" + commentNo).style.display = "";
			document.getElementById("second-form-" + commentNo).style.display = "";
			document.getElementById("second-box-" + commentNo).style.display = "";
			
		}

		function backreply(commentNo) {
			document.getElementById("first-box-" + commentNo).style.display = "";
			document.getElementById("first-content-" + commentNo).style.display = "";
			document.getElementById("second-form-" + commentNo).style.display = "none";
			document.getElementById("second-box-" + commentNo).style.display = "none";
		}

		function submitreply(commentNo) {
			var content = document.getElementById("comment-content-" + commentNo).value;
			if (content == "") {
				alert("수정할 댓글을 입력하세요.");
				return;
			}
			document.getElementById("second-form-" + commentNo).submit();
		}
		
		function addSubmit() {
			var addcontent = document.querySelector("#addcomment-content").value;
			if (addcontent == "") {
				alert("댓글을 입력하세요.");
				return;
				}
				document.getElementById("comment-add").submit();	
			}
	</script>
</html>