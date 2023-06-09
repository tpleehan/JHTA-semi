<%@page import="com.semi4.dao.CartDao"%>
<%@page import="com.semi4.vo.Game"%>
<%@page import="com.semi4.vo.Cart"%>
<%@page import="com.semi4.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인여부 체크
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	if("관리자".equals(user.getName())) {
		response.sendRedirect("../home.jsp");
		return;
	}
	
	String number = request.getParameter("gameno");
	if (number == null) {
		number = "0";
	}
	int gameNo =Integer.parseInt(number);
	
	// 사용자가 동일한 책을 장바구니에 담았는지 확인하기
	Cart cart = new Cart();
	Game game = new Game();
	game.setNo(gameNo);
	
	
	cart.setGame(game);	// 게임번호를 담고 있는 Game 객체
	cart.setUser(user);	// 로그인한 사용자
	
	CartDao cartDao = CartDao.getInstance();
	Cart savedCartItem = cartDao.getCartItem(cart);
	
	if (savedCartItem != null) {	// 장바구니에 동일한 상품이 존재
		savedCartItem.setAmount(savedCartItem.getAmount() + 1);
		cartDao.updateCartItemAmount(savedCartItem);
	} else {						// 장바구니에 동일한 상품이 존재하지 않음
		cartDao.insertCartItem(cart);
	}
	
	response.sendRedirect("cart.jsp");
%>
