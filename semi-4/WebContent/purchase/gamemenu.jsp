<%@page import="com.semi4.dao.GameLikeDao"%>
<%@page import="com.semi4.vo.GameLike"%>
<%@page import="com.semi4.utils.NumberUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.semi4.vo.Publisher"%>
<%@page import="com.semi4.vo.Genre"%>
<%@page import="com.semi4.dao.PublisherDao"%>
<%@page import="com.semi4.dao.GenreDao"%>
<%@page import="com.semi4.vo.Game"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.semi4.vo.Pagination2"%>
<%@page import="com.semi4.dao.GameDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>
<%@ include file="../common/navbar.jsp"%>
<div class="container">

<%
	GameDao gameDao = GameDao.getInstance();
	
	// 요청한 페이지 번호
	int pageNo = 1;		
	try {
		pageNo = Integer.parseInt(request.getParameter("pageno"));
	} catch (NumberFormatException ex) {}
	Map<String, Object> criteria = new HashMap<>();

	// 정렬방식
	String sort = request.getParameter("sort");
	if (sort == null || sort.isEmpty()) {
		sort = "opendate";
	}
	criteria.put("sort", sort);
	
	String genre = request.getParameter("genre");
	int genreNo = 0;
	if (genre != null && !genre.isEmpty()) {
		genreNo = Integer.parseInt(genre);
	}
	if (genreNo != 0) {
		criteria.put("genre", genreNo);
	}
	
	String publisher = request.getParameter("publisher");
	int publisherNo = 0;
	if (publisher != null && !publisher.isEmpty()) {
		publisherNo = Integer.parseInt(publisher);
	}
	if (publisherNo != 0) {
		criteria.put("publisher", publisherNo);
	}
	
	// 총 데이터 개수
	int totalCnt = gameDao.searchGamesCount(criteria);
	
	// 페이징 처리에 필요한 값들을 제공하는 Pagination 객체 생성
	Pagination2 pagination = new Pagination2(pageNo, totalCnt);
	
	criteria.put("begin", pagination.getBeginIndex());
	criteria.put("end", pagination.getEndIndex());
	
	List<Game> games = gameDao.searchGames(criteria);
	
	GenreDao genreDao = GenreDao.getInstance();
	List<Genre> genres = genreDao.getAllGenres();
	GameLikeDao gameLikeDao = GameLikeDao.getInstance();
	
	PublisherDao publisherDao = PublisherDao.getInstance();
	List<Publisher> publishers = publisherDao.getAllPublishers();
%>

<form id="search-form" class="form-inline" action="gamemenu.jsp" method="get">
	<input type="hidden" name="pageno" id="page-no" value="<%=pageNo %>" />
	<div class="row">
		<div class="col-sm-3" style="margin-top: 50px;">
			<div class="row" style="margin-bottom: 10px;">
				<div class="col-sm-12" style="margin-bottom: 10px;">
					 <span class="text-muted">검색 옵션</span>
				</div>
				<div class="col-sm-12" style="border-bottom: 1px solid grey;"></div>
			</div>
			<div class="row"  style="margin-bottom: 10px;">
				<div class="col-sm-12">
					<h5>정렬순</h5>
					<select name="sort" class="form-control" style="text-align:center" onchange="searchGames(1)">
						<option value="opendate" >::: 정렬순 선택 :::</option>
						<option value="opendate" <%="opendate".equals(sort) ? "selected" : "" %>>출시일순</option>
						<option value="pricedown" <%="pricedown".equals(sort)  ? "selected" : ""  %>>높은가격순</option>
						<option value="priceup" <%="priceup".equals(sort)  ? "selected" : ""  %>>낮은가격순</option>
						<option value="like" <%="like".equals(sort)  ? "selected" : ""  %>>좋아요순</option>
					</select>
				</div>
			</div>	
			<div class="row"  style="margin-bottom: 10px;">
				<div class="col-sm-12">
					<h5>장르</h5>
					<select name="genre" class="form-control" style="text-align:center" onchange="searchGames(1)">
						<option value="">::: 장르 선택 :::</option>
						<%
							for (Genre g : genres) {
						%>	
						<option value="<%=g.getNo() %>"  <%=g.getNo() == genreNo ? "selected" : "" %>><%=g.getName() %></option>		
						<%
							}
						%>		
					</select>
				</div>
			</div>
			<div class="row"  style="margin-bottom: 20px;">
				<div class="col-sm-12">
					<h5>퍼블리셔</h5>
					<select name="publisher" class="form-control" style="text-align:center" onchange="searchGames(1)">
						<option value="">::: 퍼블리셔 선택 :::</option>
						<%
							for (Publisher p : publishers) {
						%>
						<option value="<%=p.getNo() %>" <%=p.getNo() == publisherNo ? "selected" : "" %>><%= p.getName() %></option>
						<%
							}
						%>
						
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<button class="btn btn-block btn-info" onclick="searchGames(1)">검색하기</button>
				</div>
			</div>
		</div>
		<div class="col-sm-9">
			<div class="row" style="margin-bottom: 10px; margin-top: 50px;">
				<div class="col-sm-12" style="margin-bottom: 10px;">
					 <span class="text-muted">컨텐츠</span>
				</div>
				<div class="col-sm-12" style="border-bottom: 1px solid grey;">		
				</div>
			</div>	
			<div class="row">	
				
				<%
					if (!games.isEmpty()) {
						for (Game game : games) {					
				%>
				<div class="col-sm-4">
					<div class="panel panel-default">
						<div class="panel-body">
							<a href="gamedetail.jsp?gameno=<%=game.getNo() %>&pageno=<%=pageNo%>">
							<img src="../resources/images/gameImages/<%=game.getImageFileName() %>" 
							width="230px" height="150px" alt="<%=game.getTitle() %>">
							</a>
							<div style="max-height: 56px; height: 56px;">
								<a href="gamedetail.jsp?gameno=<%=game.getNo() %>&pageno=<%=pageNo%>"><strong style="font-size: 20px;"><%=game.getTitle() %></strong></a>
							</div>
							<div>
							<%
								Genre foundGenre = genreDao.getGenreByGenreNo(game.getGenre().getNo());
								Publisher foundPublisher = publisherDao.getPublisherByNo(game.getPublisher().getNo());
							%>
								<span class="label label-light" style="background: #222;"><%=foundGenre.getName() %></span>
								<span class="label label-light" style="background: brown;"><%=foundPublisher.getName() %></span>
								<%
									SimpleDateFormat date = new SimpleDateFormat("yy.MM.dd");
								%>
								<span class="pull-right" style="font-size: 13px;"><br><%=date.format(game.getCreateDate()) %></span>
							</div>
							<div>
								<span>정상가: <del><%=NumberUtils.numberWithComma(game.getPrice()) %> 원</del></span>
							</div>
							<div>
								<span>판매가: <strong><%=NumberUtils.numberWithComma(game.getDiscountPrice()) %> 원</strong></span>
								<%
									Game foundGame =  gameDao.getGameByNo(game.getNo());
								%>
								<p class="pull-right">좋아요 <%=foundGame.getLikeCount() %></p>
							</div>
							<div style="border-bottom: 1px solid grey;"></div>
							<div style ="padding-top: 10px;">		
								<a href="addcart.jsp?gameno=<%=game.getNo() %>" class="btn btn-warning pull-left"><span class="glyphicon glyphicon glyphicon-shopping-cart"></span> 장바구니 담기</a>
								<a href="orderdirectform.jsp?gameno=<%=game.getNo() %>" class="btn btn-primary pull-right">구매하기</a>
							</div>
						</div>
					</div>
				</div>
				
				<%
						}
					} else {
				%>
				<div class="col-sm-12" style="text-align: center;">
					<h4> 검색된 결과가 없습니다.</h4>
				</div>	
				<%
					}
				%>
				
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12 text-center">
				 <ul class="pagination">
					<%
						if (pageNo > 1) {
					%>
						<li><a href="" onclick="searchGames(<%=pageNo - 1 %>, event)">이전</a></li>
					<%
						} else {
					%>
						
					<%
						}
					%>
					<%
						if (pagination.getBeginPage() != 0 || pagination.getEndPage() != 0) {
							for (int i=pagination.getBeginPage(); i<=pagination.getEndPage(); i++) {
					%>
						<li class="<%=pageNo == i ? "active" : ""%>"><a href="" onclick="searchGames(<%=i %>, event)"><%=i %></a></li>
					<%
							}
						}
					%>
					<%
						if (pageNo < pagination.getTotalPagesCount()) {
					%>
						<li><a href="" onclick="searchGames(<%=pageNo + 1 %>, event)">다음</a></li>
					<%	
						} else {
					%>
						
					<%	
						}
					%>
				</ul>
			</div>
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
	function searchGames(pageno, e) {	
		if (e) {
			e.preventDefault();
		}
		
		document.getElementById("page-no").value = pageno;

	document.getElementById("search-form").submit();
	}
</script>
</body>
<%@ include file="../common/footer.jsp"%>
</html>