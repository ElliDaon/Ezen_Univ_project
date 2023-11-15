<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="../css/main.css">
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
	<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
    <div class="header">

        <iframe src = "../main/navigation_s.jsp" width = "100%" height="55" ></iframe>

    </div>
    <div class="container">
        <div class="sidebar">
            <div class="myinfo">
                <iframe src = "../leftmenu/myinfo_s.jsp" width="100%" height="100%"></iframe>
            </div>
        </div>
        <div class="contents">
            <div class="first-line">
                <div class="notice">
                    <h3>휴보강공지</h3><br>
                    <table>
                        <thead>
                            <tr>
                                <td>목록</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><a href="#">[휴강] [2023.10.25] 무선통신이론</a></td>
                            </tr>
                            <tr>
                                <td>[휴강] [2023.10.26] 즐거운 수학</td>
                            </tr>
                            <tr>
                                <td>[보강] [2023.10.27] 무선통신이론</td>
                            </tr>
                            <tr>
                                <td>[휴강] [2023.10.28] 시스템정보이론</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="banner" style="padding-top: 50px;">
                    <a href="https://www.cubeitac.com/" target="_blank"><img src="../images/banner.png" width="90%" height="150px"></a>
                </div>
            </div>
            <div class="p-table">
                <table class="table" id="mytable" style="font-size:12px; padding: 5px;">
                    <thead>
                        <tr>
                            <td style="width:5%; font-weight: bold; font-size: 15px;">교시</td>
                            <td style="width:15%; font-weight: bold; font-size: 15px;">월</td>
                            <td style="width:15%; font-weight: bold; font-size: 15px;">화</td>
                            <td style="width:15%; font-weight: bold; font-size: 15px;">수</td>
                            <td style="width:15%; font-weight: bold; font-size: 15px;" >목</td>
                            <td style="width:15%; font-weight: bold; font-size: 15px;">금</td>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="tv" items="${tablelist}">
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
            <div class="sitemap">
            	<span class="sitemapcls"><ion-icon name="close-outline"></ion-icon></span>
            	<h2>SITEMAP</h2>
            	<div class="link-area">
	            	<div class="main-title">
	            		<h3>마이페이지</h3>
	            		<ul>
	            			<li><a href="../mypage/personalinfo_s.do">개인정보</a></li>
	            			<li><a href="../mypage/modifyinfo_s.do">개인정보 수정</a></li>
	            			<li><a href="../mypage/courseList_s.do">수강목록</a></li>
	            			<li><a href="../mypage/mytable_s.do">시간표 조회</a></li>
	            			<li><a href="../mypage/searchP_table_s.do">교수 시간표 조회</a></li>
	            		</ul>
	            	</div>
	            	<div class="main-title">
	            		<h3>출석관리</h3>
	            		<ul>
	            			<li><a href="../attendance/attendanceSituation_s.do">출석현황 조회</a></li>
	            		</ul>
	            	</div>
	            	<div class="main-title">
	            		<h3>공지사항</h3>
	            		<ul>
	            			<li><a href="../notice/noticeList_s.do">휴보강 공지</a></li>
	            		</ul>
	            	</div>
            	</div>
            </div>
        </div>
    </div>
    <div class="sitemap_icon">
    	<span class="sitemap-popup"><ion-icon name="map-outline"></ion-icon></span>
    </div>
    <script src="../js/main.js"></script>
</body>
</html>