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
    <link rel="stylesheet" href="../css/nav_style.css">
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
	<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <script>
      $(document).ready(function(){
            studentInfo();
      });
      
      function studentInfo(){
      	
      	var str = "";
      	
      	var s_no =${sessionScope.s_no};
      	var s_name = "${sessionScope.s_name}"
      	var s_major = "${sessionScope.s_major}";
      	
      	str = "<strong>[학생]</strong><br>"
      		 + s_name + "("+ s_no +")<br>"
      		 + "[" + s_major + "]";
      	
      	$("#myinfo").html(str);
      	return;
      }
    </script>
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
							  <div aria-current="false" class="menuitemin" style="font-weight: bold"><a href="../attendance/attendanceSituation_s.do" target="_parent">출석관리</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin" style="font-weight: bold"><a href="../notice/noticeList_s.do" target="_parent">공지사항</a></div>
							</div>
						</nav>
					</div>
				</div>
			</section>
		</header>
	</div>
    <div class="main">
      <div class="container">
        <div class="sidebar">
          <div class="top">
            <div id="myinfo" class="myinfo">
              <!-- <iframe src = "../leftmenu/myinfo_s.jsp" width="100%" height="100%"></iframe> -->
            </div>
            <br>
            <div class="logStatus" style="font-weight: bold">
              <a href="<%=request.getContextPath()%>/member/memberLogout.do" target="_parent">logout</a>
            </div>
          </div>
        </div>
        <div class="contents">
            <div class="first-line">
                <div class="notice">
                    <div class="thisis">휴보강 공지사항</div>
                    <div class="noticeList">
                       <ul>
                        <c:forEach var="nv" items="${alist}">
                          <li class="currentNotice"><a href="${pageContext.request.contextPath}/notice/noticeContents.do?nidx=${nv.nidx}">${nv.n_subject}</a></li>
                        </c:forEach>
                      </ul>
                    </div>
                </div>
                <div class="banner" style="padding-top: 40px;">
                    <a href="https://www.cubeitac.com/" target="_blank"><img src="../images/banner.png"></a>
                </div>
            </div>
            <br>
            <div class="p-table">
            <div class="thisis">2023년도 2학기 시간표</div>
              <div>
                <table class="table" id="mytable">
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
            </div>
            <div class="sitemap">
            	<span class="sitemapcls"><ion-icon name="close-outline"></ion-icon></span>
            	<h2>SITEMAP</h2>
            	<div class="link-area">
	            	  <ul class="article">
	            	   <li class="depth_1">
	            		<h3>마이페이지</h3>
            			<ul>
	            			<li><a href="../mypage/personalinfo_s.do">개인정보</a></li>
	            			<li><a href="../mypage/modifyinfo_s.do">개인정보 수정</a></li>
	            			<li><a href="../mypage/courseList_s.do">수강목록</a></li>
	            			<li><a href="../mypage/mytable_s.do">시간표 조회</a></li>
	            			<li><a href="../mypage/searchP_table_s.do">교수 시간표 조회</a></li>
	            		</ul>
	            	   </li>
	            	   <li class="depth_1">
	            		<h3>출석관리</h3>
	            		<ul>
	            			<li><a href="../attendance/attendanceSituation_s.do">출석현황 조회</a></li>
	            		</ul>
	            	   </li>
	            	   <li class="depth_1">
	            		<h3>공지사항</h3>
	            		<ul class="noticeList">
	            			<li><a href="../notice/noticeList_s.do">휴보강 공지</a></li>
	            		</ul>
	            	   </li>
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