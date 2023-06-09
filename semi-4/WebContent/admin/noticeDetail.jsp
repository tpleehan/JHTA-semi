<%@page import="com.semi4.dao.AdminDao" %>
<%@page import="com.semi4.vo.NoticeBoard" %>
<%@page import="com.semi4.dao.NoticeBoardDao" %>
<%@page import="com.semi4.vo.QnaAnswer" %>
<%@page import="com.semi4.dao.QnaAnswerDao" %>
<%@page import="com.semi4.dao.UserDao" %>
<%@page import="com.semi4.vo.QnaBoard" %>
<%@page import="com.semi4.dao.QnaBoardDao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>관리자 페이지</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <script type="text/javascript"> $(window).scroll(function (event) {
        if (jQuery(window).scrollTop() >
            jQuery(".banner").offset().top) {
            jQuery("#chase").css("position", "fixed");
        } else if ((jQuery(window).scrollTop()
            < jQuery(".banner").offset().top)) {
            jQuery("#chase").css("position", "static");
        }
    }); </script>
    <style>
        #admin-list.admin-off {
            display: none;
        }

        #game-list.game-off {
            display: none;
        }

        .link {
            color: black;
            font-weight: bold;
        }
    </style>
</head>
<body>
<%@ include file="../common/navbar.jsp" %>
<%@ include file="isLogin.jsp" %>
<div class="container">
    <!-- 관리자 페이지 상단 글씨 -->
    <div class="row">
        <div class="col-sm-12" style="border-bottom:2px solid grey;">
            <h1><a class="link" href="adminMain.jsp" style="text-decoration:none;"><strong>관리자 페이지</strong></a></h1>
        </div>
    </div>
    <!-- 관리자 페이지 좌측 tab 선택 부분 -->

    <div class="banner col-sm-3">
        <div id="chase" style="top:0px;">
            <div class="col-sm-12">
                <h4><a class="link" href="adminNotice.jsp" style="text-decoration:none;">공지사항</a></h4>
            </div>
            <div class="col-sm-12">
                <h4><a class="link" href="adminQna.jsp" style="text-decoration:none">QNA 게시판 관리</a></h4>
            </div>
            <div class="col-sm-12">
                <h4><a class="link" href="adminProfits.jsp" style="text-decoration:none">수익 조회</a></h4>
            </div>
            <div class="col-sm-12">
                <h4><a class="link" href="" style="text-decoration:none" onclick="gamelist(event)">게임 관리
                    <span class="caret"></span>
                </a></h4>
                <ul id="game-list" class="game-off" style="list-style-type: none;">
                    <li style="padding-bottom:5px;"><a class="link" href="adminGameRegisterForm.jsp"
                                                       style="text-decoration:none">새로운 게임 등록</a></li>
                    <li><a class="link" href="adminEditGameForm1.jsp" style="text-decoration:none">게임정보 수정/삭제</a></li>
                </ul>
            </div>
            <div class="col-sm-12">
                <h4><a class="link" href="" style="text-decoration:none" onclick="adminList(event)">관리자 계정 관리
                    <span class="caret"></span>
                </a></h4>
                <ul id="admin-list" class="admin-off" style="list-style-type: none;">
                    <li style="padding-bottom:5px;"><a class="link" href="adminClientRegisterForm.jsp"
                                                       style="text-decoration:none">관리자 생성</a></li>
                    <li style="padding-bottom:5px;"><a class="link" href="adminClientEditForm.jsp"
                                                       style="text-decoration:none">관리자 수정</a></li>
                    <li><a class="link" href="adminClientDeleteForm.jsp" style="text-decoration:none">관리자 삭제</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- 구분선 -->

    <!-- 관리자 페이지 우측 메인컨텐츠 부분 -->

    <div class="col-sm-9" style="border-left: 2px solid grey;">
        <div class="row" style="height:500px;">
            <div class="col-sm-12" style="border-bottom: 1px solid grey;">
                <h3 class="text-center" style="font-weight: bold;">공지사항 게시글 상세보기</h3>
                <hr/>
                <form method="post" id="edit-form">
                    <div>
                        <table class="table" style="border: 2px solid grey;">
                            <colgroup>
                                <col width="20%">
                                <col width="60%">
                            </colgroup>
                            <%
                                request.setCharacterEncoding("utf-8");
                                int noticeNo = Integer.parseInt(request.getParameter("no"));
                                int pageNo = Integer.parseInt(request.getParameter("pageno"));
                                NoticeBoardDao noticeBoardDao = NoticeBoardDao.getInstance();
                                NoticeBoard noticeBoard = noticeBoardDao.getNoticeByNo(noticeNo);
                                AdminDao adminDao = AdminDao.getInstance();
                                Admin foundAdmin = adminDao.getAdminById(noticeBoard.getAdmin().getId());
                            %>

                            <tr>
                                <th class="info">글번호</th>
                                <th>
                                    <div class="form-group">
                                        <input class="form-control hidden" type="text" name="no" id="boardNo"
                                               value="<%=noticeBoard.getNo() %>">
                                        <%=noticeBoard.getNo() %>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <th class="info">제목</th>
                                <th>
                                    <div class="form-group">
                                        <input class="form-control" type="text" name="title" id="title"
                                               style="border: 0px;"
                                               value="<%=noticeBoard.getTitle() %>">
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <th class="info">작성자</th>
                                <th><%=foundAdmin.getName() %>
                                </th>
                            </tr>
                            <tr>
                                <th class="info">본문</th>
                                <th>
                                    <div class="form-group">
											<textarea class="col-12" name="content" style="width: 100%; min-height:300px; 
											 resize: none; border: 0;"
                                                      id="content"><%=noticeBoard.getContent() %></textarea>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <th class="info">조회수</th>
                                <th style="padding-bottom: 50px;"><%=noticeBoard.getCount() %>
                                </th>
                            </tr>
                        </table>
                        <hr/>
                        <div class="form-group hidden">
                            <input class="form-control" type="text" name="pageno" value="<%=pageNo %>">

                        </div>


                        <div class="col-sm-12">
                            <a href="adminNotice.jsp?pageno=<%=pageNo %>">
                                <button class="btn btn-success pull-right" type="button" style="margin: 20px 10px;">
                                    목록으로
                                </button>
                            </a>
                            <button class="btn btn-primary pull-right" type="button" onclick="editNotice()"
                                    style="margin: 20px 10px;">수정
                            </button>
                            <button class="btn btn-danger pull-right" type="button"
                                    onclick="deleteNotice(<%=noticeBoard.getNo() %>)" style="margin: 20px 10px;">삭제
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

</div>
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
    function editNotice() {
        var title = document.getElementById("title").value;
        if (title == "") {
            alert("제목을 입력하세요");
            return;
        }
        var content = document.getElementById("content").value;
        if (content == "") {
            alert("본문 내용을 입력하세요");
            return;
        }
        document.getElementById("edit-form").action = "noticeEdit.jsp";
        document.getElementById("edit-form").submit();

    }

    function deleteNotice(no) {
        window.open("deleteCheckPopup.jsp?no=" + no, "deleteCheck", "width=500,height=300,resizable=0");
    }

    function adminList(event) {
        event.preventDefault();

        var value = document.getElementById("admin-list").getAttribute("class");
        if (value == "admin-off") {
            document.getElementById("admin-list").setAttribute("class", "admin-on");

        } else {
            document.getElementById("admin-list").setAttribute("class", "admin-off");
        }

    }


    function gamelist(event) {
        event.preventDefault();

        var value = document.getElementById("game-list").getAttribute("class");
        if (value == "game-off") {
            document.getElementById("game-list").setAttribute("class", "game-on");

        } else {
            document.getElementById("game-list").setAttribute("class", "game-off");
        }
    }
</script>
</body>
</html>
