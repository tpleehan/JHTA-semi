<%@page import="com.semi4.dao.CommentDao"%>
<%@page import="com.semi4.utils.StringUtils"%>
<%@page import="com.semi4.vo.Pagination1"%>
<%@page import="com.ibatis.sqlmap.engine.mapping.sql.dynamic.elements.IsEmptyTagHandler"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.semi4.utils.DateUtil"%>
<%@page import="com.semi4.vo.Purchase"%>
<%@page import="com.semi4.dao.PurchaseDao"%>
<%@page import="com.semi4.utils.NumberUtils"%>
<%@page import="com.semi4.vo.ReviewBoard"%>
<%@page import="java.util.List"%>
<%@page import="com.semi4.dao.ReviewBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>리뷰게시판</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<style type="text/css">
  #tt {
  overflow: hidden; 
  text-overflow: ellipsis;
  white-space: nowrap;   
  }
</style>
</head>
<body>
	<%@ include file="../../common/navbar.jsp"%>
	<div class="container">
		<div style="border-bottom: 1px solid grey;">
			<h2>리뷰게시판</h2>
		</div>
		<br>
		<div class="col-sm-12">
			<div class="row">
				<div class="col-sm-3">
					<div class="row" style="border-bottom: 1px solid grey">
						<h4>고객지원</h4>
					</div>
					<br>
					<div class="row">
						<a href="../noticeboard/noticeboard.jsp" style="text-decoration: none;">공지사항</a>
					</div>
					<br>
					<div class="row" >
						<a href="../qnaboard/qnaboard.jsp" style="text-decoration: none;">QnA게시판</a>
					</div>
					<br>
					<div class="row" style="text-decoration: none;">
						<a href="reviewboard.jsp">리뷰게시판</a>
					</div>
					<br>
				</div>
				<%
					ReviewBoardDao reviewBoardDao = ReviewBoardDao.getInstance();
				
					int pageNo = NumberUtils.stringToNumber(request.getParameter("pageno"), 1);
					String sort = request.getParameter("sort") == null ? "date"	: request.getParameter("sort");
					int record = NumberUtils.stringToNumber(request.getParameter("record"), 5);
					String searchType = request.getParameter("searchtype");
					String searchKeyword = StringUtils.nullToBlank(request.getParameter("searchkeyword"));
					
					Map<String, Object> criteria = new HashMap<String, Object>();
					criteria.put("sort", sort);
					if (!searchKeyword.isEmpty()) {
						criteria.put("type", searchType);
						criteria.put("keyword", searchKeyword);
					}
					
					int totalRows = reviewBoardDao.countReviewBoard(criteria);
					
					Pagination1 pagination = new Pagination1(pageNo, totalRows, record);
					criteria.put("begin", pagination.getBeginIndex());
					criteria.put("end", pagination.getEndIndex());
					
					System.out.println(pagination.getBeginIndex());
					System.out.println(pagination.getEndIndex());
					
					List<ReviewBoard> boards = reviewBoardDao.getReviewBoardByDynamic(criteria);
					
				%>
				<form class="form-inline" id="search-form" action="reviewboard.jsp" method="get">
					<input type="hidden" name="pageno" id="page-no" value="<%=pageNo %>" />
					<div class="col-sm-9" style="height: 1200px;">
						<div class="row">
							<div class="col-sm-12" >
								<div class="row text-right">
									<select class="form-control" name="sort" onchange="searchBoard(1)">
										<option value="date" <%="date".equals(sort) ? "selected" : "" %>>날짜 순</option>
										<option value="count" <%="count".equals(sort) ? "selected" : "" %>>조회수 순</option>
										<option value="like" <%="like".equals(sort) ? "selected" : "" %>>좋아요 순</option>
										<option value="comment" <%="comment".equals(sort) ? "selected" : "" %>>댓글수 순</option>
									</select> 
									<select class="form-control" name="record" onchange="searchBoard(1)">
										<option value="5" <%=5 == record ? "selected" : "" %>>5개씩</option>
										<option value="10" <%=10 == record ? "selected" : "" %>>10개씩</option>
										<option value="15" <%=15 == record ? "selected" : "" %>>15개씩</option>
										<option value="20" <%=20 == record ? "selected" : "" %>>20개씩</option>
									</select>
								</div>
								<table class="table" style="TABLE-layout:fixed">
									<colgroup>
										<col width="10%">
										<col width="35%">									
										<col width="15%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th>글번호</th>
											<th>제목</th>										
											<th>글쓴이</th>
											<th>작성일</th>
											<th>좋아요</th>
											<th>조회수</th>
										</tr>
									</thead>
									<tbody>
									<%		
										CommentDao commentDao = CommentDao.getInstance();
										for (ReviewBoard board : boards) {
									%>
										<tr>
											<td><%=board.getNo() %></td>
											<td id="tt"><a href="reviewboarddetail.jsp?reviewno=<%=board.getNo() %>&pageno=<%=pageNo %>&from=reviewboard.jsp"><%=board.getTitle() %> [<%=board.getCommentCount() %>]</a></td>
											<td><%=board.getUser().getName() %></td>
											<td><%=DateUtil.dateToString(board.getCreateDate()) %></td>
											<td><%=board.getLikeCount() %></td>
											<td><%=board.getCount() %></td>
										</tr>
									<%
										}
									%>
									</tbody>
								</table>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-6 text-left">
								<select class="form-control" name="searchtype">
									<option value="title" <%="title".equals(searchType) ? "selected" : "" %>>제목</option>
									<option value="writer" <%="writer".equals(searchType) ? "selected" : "" %>>작성자</option>
									<option value="content" <%="content".equals(searchType) ? "selected" : "" %>>내용</option>
								</select> 
								<input class="form-control" name="searchkeyword" value="<%=StringUtils.nullToBlank(searchKeyword) %>" />
								<button type="button" class="btn btn-info" onclick="searchBoard(1)">검색</button>
							</div>
							<div class="col-sm-6">
							<%	
								PurchaseDao purchaseDao = PurchaseDao.getInstance();
							
								if (loginedUser != null) {
									 List<Purchase> purchases = purchaseDao.getPurchasesByUserNo(loginedUser.getNo());
									 if (!purchases.isEmpty()) {
									
							%>
								<a type="button" class="btn btn-primary pull-right" href="reviewboardadd.jsp">글쓰기</a>
							<%
								}}
							%>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 text-center">
								<ul class="pagination">
									<%
										
									
										if (pageNo > 1) {
											
									%>
									<li><a href="" onclick="searchBoard(<%=pageNo - 1 %>, event)">&laquo;</a></li>
									<%
										} else {
									%>
									<li class="<%=pageNo == 1 ? "disabled" : "" %>"><a href="" onclick="searchBoard(1, event)">&laquo;</a></li>
									<%
										}
									%>
									<%
										for (int i = pagination.getBeginPage(); i <= pagination.getEndPage(); i++) {
									%>
									<li class="<%=pageNo == i ? "active" : "" %>"><a href="" onclick="searchBoard(<%=i %>, event)"><%=i %></a></li>
									<%
										}
									%>
									<%
										if (pageNo < pagination.getTotalPageCount()) {
									%>
									<li><a href="" onclick="searchBoard(<%=pageNo + 1 %>, event)">&raquo;</a></li>
									<%
										} else {
									%>
									<li class="<%=pageNo == pagination.getTotalPageCount() ? "disabled" : "" %>"><a href="" onclick="searchBoard(<%=pagination.getTotalPageCount() %>, event)">&raquo;</a></li>
									<%
										}
									%>
								</ul>
							</div>
						</div>
					</div>
				</form>			
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function searchBoard(pageno	, e) {
			if (e) {
				e.preventDefault();
			}
			document.getElementById("page-no").value = pageno;
			document.getElementById("search-form").submit();
		}
	</script>
	<%@ include file="../../common/footer.jsp"%>
</body>
</html>