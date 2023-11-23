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
    <link rel="stylesheet" href="../css/attendanceSituation.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<style>
		h3{
            font-size: 1.47em;
            font-weight: 500;
            color: #0067b3;
        }
        .contents table{
            margin-top: 10px;
			width: 1300px;
			/* height: 50px;
			text-align: center; */
			border-collapse: collapse;
        }
        .contents table thead{
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
	        professorInfo();
	});
	  
	function professorInfo(){
	  	
	  	var str = "";
	  	
	  	var p_no =${sessionScope.p_no};
	  	var p_name = "${sessionScope.p_name}"
	  	var p_major = "${sessionScope.p_major}";
	  	
	  	str = "<strong>[교수]</strong><br>"
	  		 + p_name + "("+ p_no +")<br>"
	  		 + "[" + p_major + "]";
	  	
	  	$("#myinfo").html(str);
	  	return;
	}
  	 
	 function displaySecondTable(cidx){
				
			 displayCourse(cidx);
		    
		    $.ajax({
	    		type : "get",
	    		url : "<%=request.getContextPath()%>/attendance/toomuchAbsenceListAction.do",
	    		data : {
	    			"cidx": cidx
	    		},
	    		dataType : "json",
	    		success : function(data){
	    			var str = "";
	    			str +=  "<table class='countNo'><thead><tr>"
                          + "<td style='width:10px'>NO</td><td style='width:50px'>이름</td>"
                          + "<td style='width:30px'>학번</td><td style='width:30px'>결석일수</td>"
                          + "<td style='width:30px'>결석률</td></tr></thead><tbody>";
                    
                    $(data).each(function(){
                  	  str = str + "<tr><td></td><td>"+this.s_name+"</td>"
		                        + "<td>"+this.s_no+"</td><td>"+this.count+"</td><td>"+this.per+"</td></tr>";
                    });
	    			$("#studentList").html(str+"</tbody></table>"); 
	    			return;
	    		},
	    		error : function(request, status, error){
	    			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    		} 
	    	});
	    	return;
		}
	 function displayCourse(cidx){
		$.ajax({
 		type : "get",
		url : "<%=request.getContextPath()%>/attendance/toomuchAbsenceListAction.do",
		data : {
			"cidx": cidx
		},
		dataType : "json",
		success : function(data){
			var str = "";
          
            $(data).each(function(){
          	  str = "<h3>" + this.c_name +"</h3>";
            });
			$("#courseName").html(str); 
			return;
		},
		error : function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		} 
	});
	return;
		 
}
    </script>
    <style>

        
    .countNo tbody>tr {
        counter-increment: aaa;
     }
    .countNo tbody>tr>td:first-child:before {
        content: counter(aaa) " ";
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
							  <div aria-current="false" class="menuitemin"><a href="../mypage/personalinfo_p.do" target="_parent">마이페이지</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin" style="font-weight: bold"><a href="../attendance/attendanceSituation_p.do" target="_parent">출석관리</a></div>
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
          <div class="topmenu_name">출석관리</div>
          <div class="bottom">
           <ul>
             <li class="personalinfo">
               <ul>
                 <li><a href="../attendance/attendanceSituation_p.do" target="_parent">
                 <i class="fa fa-calendar" aria-hidden="true"></i>
                  출석현황 조회</a></li>
               </ul>
             </li>
             <li class="personalinfo">
               <ul>
                 <li><a href="../attendance/attendancePreManagement.do" target="_parent">
                 <i class="fa fa-address-book-o" aria-hidden="true"></i>
                 출석 관리</a></li>
               </ul>
             </li>
             <li class="personalinfo">
               <ul>
                 <li><a href="../attendance/lackOfAttendance.do" target="_parent" style="color:#0078ff; font-weight: bold;">
                 <i class="fa fa-calendar-times-o" aria-hidden="true" ></i>
                 출석 미달 관리</a></li>
               </ul>
             </li>
           </ul>
          </div>
        </div>
	    <div class="contents">
            <h3>출석 미달자 조회</h3>
            <div class="first_line">
                년도 <input type="text" name="year" value="${year}" disabled/> 학기 <input type="text" name="turm" value="${semester}" disabled/>
            </div>
            <div class="list_table" style="margin-bottom:35px;">
                <table>
                    <thead>
                        <tr>
                            <td style="width:10px">NO</td>
                            <td style="width:50px">강의명</td>
                            <td style="width:30px">미달자 수 / 학생수</td>
                            <td style="width:30px">미달률</td>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="av" items="${list}" varStatus="i">
                        <tr>
                            <td>${i.count}</td>
                            <td onClick="displaySecondTable(${av.cidx})" style="cursor:pointer;">${av.c_name}</td>
                            <td>${av.abperal}</td>
                            <td>${av.abpercent}</td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
              <b style="color:red">※ 출석 미달자 : 결석률이 25%를 초과하는 자</b>
            </div>
            
            <div id="courseName"></div>
            <div class="list_table lack" id="studentList">

            </div>
        </div>
      </div>
	</div>

</body>
</html>