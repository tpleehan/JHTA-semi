<%@page import="com.semi4.utils.NumberUtils"%>
<%@page import="com.semi4.vo.Game"%>
<%@page import="com.semi4.dao.PurchaseItemDao"%>
<%@page import="com.semi4.vo.Cart"%>
<%@page import="com.semi4.dao.CartDao"%>
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
<%
	User user = (User) session.getAttribute("LOGINED_USER");
	if (loginedUser == null) {
		response.sendRedirect("../loginform.jsp");
		return;
	}

	// 체크박스로 보낸 체크 cartno들을 가져오기
	String[] cartNos = request.getParameterValues("cartno");
	
	CartDao cartDao = CartDao.getInstance();
	GameDao gameDao = GameDao.getInstance();
	Cart cart = new Cart();
	cart.setUser(user);
	
	int totalPrice = 0;
%>
<div class="container">
<form id="order-form" class="form-inline" action="order.jsp" method="post">	
<div class="row" style="margin-bottom: 10px;">
	<div class="col-sm-12" style="margin-bottom: 10px;">
		 <span style="font-size: 30px;">주문하기</span>
	</div>
	<div class="col-sm-12" style="border-bottom: 1px solid grey;"></div>
	<div>
		<table class="table">
			<thead>
				<tr>
					<th>이미지</th>
					<th>상품명</th>
					<th>수량</th>
					<th>가격</th>
					<th>할인가격</th>
					<th>합계</th>
				</tr>
			</thead>
			<tbody>
				<% 
					for (String cartNo : cartNos) {
						Cart foundCart = cartDao.getCarItemtByCartNo(Integer.parseInt(cartNo));	
						Game foundGame = gameDao.getGameByNo(foundCart.getGame().getNo());
				%>
				<tr>
					<td><a href="gamedetail.jsp?gameno=<%=foundGame.getNo() %>"><img src="../resources/images/gameImages/<%=foundGame.getImageFileName() %>" style="width: 220px; height: 100px;"></a></td>
					<td><a href="gamedetail.jsp?gameno=<%=foundGame.getNo() %>"><%=foundGame.getTitle() %></a></td>
					<td><%=foundCart.getAmount() %></td>
					<td><del><%=NumberUtils.numberWithComma(foundGame.getPrice()) %> 원</del></td>
					<td><%=NumberUtils.numberWithComma(foundGame.getDiscountPrice()) %> 원</td>
					<td>
						<input type="hidden" name="cartno" value="<%=cartNo%>">
						<strong><%=NumberUtils.numberWithComma(foundGame.getDiscountPrice() * foundCart.getAmount()) %> 원</strong>
					</td>
				</tr>
				<%
						totalPrice += foundGame.getDiscountPrice() * foundCart.getAmount();
					}
				%>
				<tr>
					<td colspan="5">합계:</td>
					<td style="color: red; font-weight: bold;"><%=NumberUtils.numberWithComma(totalPrice) %> 원</td>
				</tr>
			</tbody>
		</table>		
	</div>
</div>
<div class="row">
	<div class="col-sm-6">
		<div class="row">
			<div class="col-sm-12">
				<h3>최종결제 정보</h3>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<table class="table table-striped"> 
						<tbody>
							<tr>
								<td>아이디</td>
								<td><%=loginedUser.getId() %></td>
							</tr>
							<tr>
								<td>이름</td>
								<td><%=loginedUser.getName() %></td>
							</tr>
							<tr>
								<td>연락처</td>
								<td><%=loginedUser.getTel() %></td>
							</tr>
							<tr>
								<td>이메일</td>
								<td><%=loginedUser.getEmail() %></td>
							</tr>
						</tbody>	
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="col-sm-6">
		<div class="row">
			<div class="col-sm-12">
				<h3>결제하기</h3>
			</div>
			<div class="row">
				<div class=" col-sm-12" style="padding-left:35px;">
					<label><input type="checkbox" value="apply" name="apply" id="apply-pay">
					<span>구매하실 상품의 상품정보 및 가격을 확인하였으며, 이에 동의합니다.<br>(전자상거래법 제8조 제2항)</span></label>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12 text-right">
					<a href="gamemenu.jsp" class="btn btn-danger btn-lg">홈으로</a>
					<!-- form안에 button은 항상 submit처럼 작동한다. -->
					<button type="button" class="btn btn-primary btn-lg" onclick="tryPay()">결제하기</button>
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</div>
</body>
<script type="text/javascript">
	function tryPay() {
		var checkStatus = document.querySelector("input[name='apply']").checked;
		
		if (!checkStatus) {
			alert("동의하지 않았습니다.");
			return;
		}
		
		document.getElementById("order-form").submit();
	}
</script>
<%@ include file="../common/footer.jsp"%>
</html>