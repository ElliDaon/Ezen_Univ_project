<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../css/nav_style.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
							  <div aria-current="false" class="menuitemin"><a href="../mypage/personalinfo_p.do" target="_parent">마이페이지</a></div>
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
<!--         <table class="navigation" width="1151" heigh="41" border="1" cellpadding="0" cellspacing="0">
            <tbody>
            <tr>
                <td class="nav_logo" align="center">
                    <a href="./main_p.do" target="_parent">
                        <img src="../images/ezen_univ.png" width="150">
                    </a>
                </td>
                <td>
                    <a href="../mypage/personalinfo_p.do" target="_parent">마이페이지</a>
                </td>
                <td>
                    <a href="../attendance/attendanceSituation_p.do" target="_parent">출석관리</a>
                </td>
                <td>
                    <a href="../notice/noticeList_p.do" target="_parent">공지사항</a>
                </td>
                <td width="500"></td>
            </tr>
        </tbody>
        </table> -->
</body>
