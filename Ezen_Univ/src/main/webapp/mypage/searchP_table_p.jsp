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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<style>
		.search_professor{
			background: rgb(194, 194, 255);
			margin-top: 10px;
			padding-left: 20px;
			width: 600px;
			height: 30px;
			padding-top: 5px;
		}
		.search_professor input[type="text"]{
			margin-left: 5px;
			width: 100px;
		}
		.search_professor input[type="submit"]{
			margin-left: 5px;
			width: 50px;			
		}
		.professor_list{
			width: 30%;
			margin-top: 10px;
		}
		.professor_list table{
			width: 100%;
			border-collapse: collapse;
   			border-bottom: 1px solid black;
    		border-top: 1px solid black;
    		text-align: center;
		}
		.professor_list table thead{
			background: rgb(194, 194, 255);
			font-weight: bold;
		}
		.ptable{
   			margin-top: 20px;
		}
		.ptable table{
		    width: 80%;
		    border-collapse: collapse;
		    border-bottom: 1px solid black;
		    border-top: 1px solid black;
		    text-align: center;
		}
		.ptable table thead{
		    font-weight: bold;
		    background: rgb(194, 194, 255);
		}
		.ptable table tbody tr{
		    height: 50px;
		    font-size: 12px;
		}
		.ptable table tbody tr,td{
		    border: 1px solid gray;
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
	
	
	function searchP(){
		let p_name = $("#p_name").val();
		
		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/mypage/searchProfessorList.do",
			data: {
				"p_name" : p_name,
				},
			dataType: "json",
			success: function(data){
				var fm = document.pnamefrm;
				if(fm.p_name.value==""){
					alert("이름을 입력해주세요!!");
					return;
				}
				var str = "";
				str = "<thead><tr><td>학과</td><td>이름</td></tr></thead><tbody>";
				$(data).each(function(){
					str = str + "<tr><td>" + this.major + "</td><td>" + "<button name='professor_name' value='" + this.pidx 
					+ "' onclick='searchTable("+ this.pidx +")'>" + this.name + "</button></td></tr>";
				});
				str = str + "</tbody>";
				$("#professor_list").html("<table>"+str+"</table>");
				return;
			},
			error: function(){
				alert("실패");
			}
		});
	}
	
	function searchTable(pidx){
		var fm = document.pnamefrm;
		let year = fm.year.value;
		let turm = fm.turm.value;
		
		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/mypage/searchProfessorTable.do",
			data: {
				"pidx" : pidx,
				"year" : year,
				"turm" : turm
				},
			dataType: "json",
			success: function(data){
				
				var str = "";
				str = "";
				str += "<table><thead><tr><td style='width:5%'>교시</td>"
                    +"<td style='width:15%'>월</td>"
                    +"<td style='width:15%'>화</td>"
                    +"<td style='width:15%'>수</td>"
                    +"<td style='width:15%'>목</td>"
                    +"<td style='width:15%'>금</td>"
                	+"</tr></thead>";
				$(data).each(function(){
					str = str + "<tr><td>" + this.period + "</td><td>" + this.mon +  "</td><td>" + this.two
						+"</td><td>" + this.wed + "</td><td>" + this.thu + "</td><td>" + this.fri + "</td></tr>";
				});
				$("#ptable").html(str+"</table>");
				return;
			},
			error: function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
	</script>
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
                 <li><a href="../mypage/personalinfo_p.do" target="_parent">&ensp;&ensp;개인정보</a></li>
                 <li><a href="../mypage/modifyinfo_p.do" target="_parent">&ensp;&ensp;개인정보 수정</a></li>
               </ul>
             </li>
             <li class="personalinfo">
              <ul>
               <li><i class="fa fa-book" aria-hidden="true"></i>
               강의정보</li>
              </ul>
               <ul>
                 <li><a href="../mypage/courseList_p.do" target="_parent">&ensp;&ensp;강의 현황</a></li>
                 <li><a href="../mypage/searchP_table_p.do" target="_parent" style="color:#0078ff; font-weight: bold;">&ensp;&ensp;교수 시간표 조회</a></li>
               </ul>
             </li>
           </ul>
          </div>
        </div>
        <div class="contents">
            <h2>교수 시간표 조회</h2>
            <div class="search_professor">
            	<form name="pnamefrm">
            		년도 <input type="text" name="year" value="${year}" disabled/> 학기 <input type="text" name="turm" value="${semester}" disabled/>
            		교수이름<input type="text" id="p_name" name="p_name"> <button type="button" name="namebtn" onclick="searchP()">검색</button>
            	</form>
            </div>
            <div class="professor_list" id="professor_list">

            </div>
            <div class="p_table">
                <div class="ptable" id="ptable">
				</div>
        	</div>
        </div>
      </div>
    </div>
</body>
</html>