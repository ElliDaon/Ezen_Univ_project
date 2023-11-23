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
    <link rel="stylesheet" href="../css/courseList.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
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
                 <li><a href="../mypage/personalinfo_s.do" target="_parent">&ensp;&ensp;개인정보</a></li>
                 <li><a href="../mypage/modifyinfo_s.do" target="_parent">&ensp;&ensp;개인정보 수정</a></li>
               </ul>
             </li>
             <li>
              <ul>
               <li><a href="../mypage/courseList_s.do" target="_parent" style="color:#0078ff; font-weight: bold;">
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
            <h3>수강현황조회</h3>
            <div class="first_line">
                년도 <input type="text" name="year" value="${year}" disabled/> 학기 <input type="text" name="turm" value="${semester}" disabled/>
            </div>
            <div class="list_table">
                <table>
                    <thead>
                        <tr>
                            <th style="width:10px">NO</th>
                            <th style="width:50px">과목명</th>
                            <th style="width:30px">세부전공</th>
                            <th style="width:10px">수강학년</th>
                            <th style="width:30px">교수</th>
                            <th style="width:30px">이수구분</th>
                            <th style="width:10px">학점</th>
                            <th style="width:30px">강의실</th>
                            <th style="width:30px">시간표</th>
                        </tr>
                    </thead>
                    <tbody>
                    
                    	<c:forEach var="cv" items="${list}" varStatus="i">
                        <tr>
                            <td>${i.count}</td>
                            <td>${cv.c_name}</td>
                            <td>${cv.c_major}</td>
                            <td>${cv.c_grade}</td>
                            <td>${cv.p_name}</td>
                            <td>${cv.c_sep}</td>
                            <td>${cv.c_grade}</td>
                            <td>${cv.ct_room}</td>
                            <td>${cv.c_times}</td>
                    		
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