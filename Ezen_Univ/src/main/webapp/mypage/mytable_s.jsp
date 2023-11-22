<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="../css/iframe.css">
    <link rel="stylesheet" href="../css/nav_style.css">
    <link rel="stylesheet" href="../css/courseList.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
        
    </style>
</head>
<body>
	<div id="main-header">
		<header class="mainHeader">
			<section class="mainHeaderSection">
				<div>
					<a href="../main/main_s.do" class="logoLink" target="_parent"><img src="../images/ezen_univ.png" width="150"></a>
					<div class="headerMenu">
						<nav class="menuList">
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin" style="font-weight: bold"><a href="../mypage/personalinfo_s.do" target="_parent">마이페이지</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../attendance/attendanceSituation_s.do" target="_parent">출석관리</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../notice/noticeList_s.do" target="_parent">공지사항</a></div>
							</div>
						</nav>
					</div>
				</div>
			</section>
		</header>
	</div>
    <div class="container">
        <div class="sidebar">
            <div class="myinfo">
                <iframe src = "../leftmenu/myinfo_s.jsp" width="100%" height="200"></iframe>
            </div>
            <div class="menubar">
                <iframe src = "../leftmenu/mypage_menu_s.jsp" width="100%" height="500"></iframe>
            </div>
        </div>
        <div class="contents">
            <h3>강의현황조회</h3>
            <div class="first_line">
                년도 <input type="text" name="year" value="${year}" disabled/> 학기 <input type="text" name="turm" value="${semester}" disabled/>
            </div>
            <div class="my_table">
                <div class="mytable">
                    <table>
                        <thead>
                            <tr>
                                <td style="width:5%">교시</td>
                                <td style="width:15%">월</td>
                                <td style="width:15%">화</td>
                                <td style="width:15%">수</td>
                                <td style="width:15%">목</td>
                                <td style="width:15%">금</td>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="tv" items="${list}">
                            <tr>
                                <td>${tv.pe_period}</td>
                                <td>${tv.mon}</td>
                                <td>${tv.two}</td>
                                <td>${tv.wed}</td>
                                <td>${tv.thu}</td>
                                <td>${tv.fri}</td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>