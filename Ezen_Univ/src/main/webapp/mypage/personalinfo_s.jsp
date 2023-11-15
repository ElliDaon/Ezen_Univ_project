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
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <div class="header">
        <iframe src = "../main/navigation_s.jsp" width = "100%" height="55" ></iframe>
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
            <h3>학생정보</h3>
            <table border=1 style="width:600px; text-align:center;">
				<tr>
				<tr>
					<th>학번</th>
					<td>${mv.s_no}</td>
					<th>이름</th>
					<td>${mv.s_name}</td>
				</tr>
				<tr>
					<th>학년</th>
					<td>${mv.s_grade}</td>
					<th>연락처</th>
					<td>${mv.s_phone}</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>${mv.s_birth}</td>
					<th>학과</th>
					<td>${mv.s_major}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan='3'>${mv.s_email}</td>
				</tr>
			</table>
        </div>
    </div>
</body>
</html>