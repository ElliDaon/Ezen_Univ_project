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
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel="stylesheet" href="../css/nav_style.css">
    <style>
        .container{
            display: flex;
        }
        .sidebar{
            width: 50%;
        }
        .myinfo{
            width: 100%;
        }
        .menubar{
            width: 100%;
        }
        .contents{
            padding: 10px;
        }
        h3{
        	margin: 10px;
        }
        .contents table{
            margin: 10px;
			width: 600px;
			text-align: center;
			border-collapse: collapse;
			height: 50px;
        }
        .contents table tr,td{
			border: 1px solid black;
			padding-top: 5px;
			padding-bottom: 5px;
        }
        .contents table th{
        	background: rgb(194, 194, 255);
        	
        }
        
    </style>
</head>
<body>
	<div id="main-header">
		<header class="mainHeader">
			<section class="mainHeaderSection">
				<div>
					<a href="../main/main_p.do" class="logoLink" target="_parent"><img src="../images/ezen_univ.png" width="150"></a>
					<div class="headerMenu">
						<nav class="menuList">
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin" style="font-weight: bold"><a href="../mypage/personalinfo_p.do" target="_parent">마이페이지</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../attendance/attendanceSituation_p.do" target="_parent">출석관리</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../notice/noticeList_p.do" target="_parent">공지사항</a></div>
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
                <iframe src = "../leftmenu/myinfo_p.jsp" width="100%" height="200"></iframe>
            </div>
            <div class="menubar">
                <iframe src = "../leftmenu/mypage_menu_p.jsp" width="100%" height="500"></iframe>
            </div>
        </div>
        <div class="contents">
            <h3>교수 정보</h3>
            
            <table>
				<tr>
				<tr>
					<th>교수번호</th>
					<td>${mv.p_no}</td>
					<th>이름</th>
					<td>${mv.p_name}</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>${mv.p_birth}</td>
					<th>연락처</th>
					<td>${mv.p_phone}</td>
				</tr>
				<tr>
					<th>학과</th>
					<td colspan='3'>${mv.p_major}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan='3'>${mv.p_email}</td>
				</tr>
			</table>
        </div>
    </div>
</body>
</html>