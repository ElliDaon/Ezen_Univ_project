<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="../css/nav_style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
/*         .container{
            display: flex;
        } */
/*         .sidebar{
            width: 50%;
        } */
/*         .myinfo{
            width: 100%;
        } */
/*         .menubar{
            width: 100%;
        } */
/*         .contents{
            padding: 10px;
        } */
        h3{
            font-size: 1.47em;
            font-weight: 500;
            color: #0067b3;
        }
        .contents table{
            margin-top: 10px;
			width: 600px;
			/* height: 50px;
			text-align: center; */
			border-collapse: collapse;
        }
        .contents table th{
           background: #f2f2f2;
           font-weight: bold;
           color: #555;
        }
        .contents table tr, td{
           padding: 1em 0;
           border: 1px solid #ccc;
           text-align: center;
        }
    </style>
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
          <br>
          <div class="topmenu_name">마이페이지</div>
          <div class="bottom">
           <ul>
             <li class="personalinfo">
              <ul>
               <li><i class="fa fa-user-circle" aria-hidden="true"></i>
               개인정보</li>
              </ul>
               <ul>
                 <li><a href="../mypage/personalinfo_s.do" target="_parent" style="color:#0078ff; font-weight: bold;">&ensp;&ensp;개인정보</a></li>
                 <li><a href="../mypage/modifyinfo_s.do" target="_parent">&ensp;&ensp;개인정보 수정</a></li>
               </ul>
             </li>
             <li>
              <ul>
               <li><a href="../mypage/courseList_s.do" target="_parent">
               <i class="fa fa-book" aria-hidden="true"></i>
               수강목록
               </a></li>
              </ul>
             </li>
             <li class="personalinfo">
              <ul>
               <li><i class="fa fa-book" aria-hidden="true"></i>
               시간표</li>
              </ul>
               <ul>
                 <li><a href="../mypage/mytable_s.do" target="_parent">&ensp;&ensp;시간표 조회</a></li>
                 <li><a href="../mypage/searchP_table_s.do" target="_parent">&ensp;&ensp;교수 시간표 조회</a></li>
               </ul>
             </li>
           </ul>
          </div>
        </div>
        <div class="contents">
            <h3><i class="fa fa-graduation-cap" aria-hidden="true"></i> 학생정보</h3>
            <table>
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
    </div>
</body>
</html>