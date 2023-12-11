<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "app.domain.*" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>출석 현황 조회</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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
            border-collapse: collapse;
        }
        .contents table thead{
           background: #f2f2f2;
           font-weight: bold;
           color: #555;
        }
        .contents table tr, td{
           padding: 0.5em 0;
           border: 1px solid #ccc;
           text-align: center;
        }
        .list_table.slist{
        	width: 1300px;
        	height: 600px;
        	overflow-y: scroll;
        }
		#showAttendanceList {
			cursor: pointer;
			border: none;
			background: #0067B3;
			color: white;
			width: 120px;
			padding: 3px;
		}
	</style>
    <style>
        /* 추가한 스타일 */
        .attendlist{
            display: none;
        }
        
        .countNo tbody>tr {
            counter-increment: aaa;
         }
        .countNo tbody>tr>td:first-child:before {
            content: counter(aaa) " ";
         }
         
         .list_table_student tbody>tr {
            counter-increment: aaa;
         }
        .list_table_student tbody>tr>td:first-child:before {
            content: counter(aaa) " ";
         }
         
    </style>
    <script>
	$(document).ready(function(){
	        professorInfo();
	        
	        $("button[name='c_name']").click(function () {
	        	var c_name = $(this).text();
	        	$(".selectedWrap>input[name='selectedC_name']").val(c_name);
	        	var cidx = $(this).val();
	        	getAttendanceTable(cidx);

	        	

	        }); 
	});
	  
	function professorInfo(){
	  	
	  	var str = "";
	  	
	  	var p_no =${sessionScope.p_no};
	  	var p_name = "${sessionScope.p_name}";
	  	var p_major = "${sessionScope.p_major}";
	  	
	  	str = "<strong>[교수]</strong><br>"
	  		 + p_name + "("+ p_no +")<br>"
	  		 + "[" + p_major + "]";
	  	
	  	$("#myinfo").html(str);
	  	return;
	}
  
	
   	
   	function getAttendanceTable(cidx){
   		
   		$.ajax({
   			type : "post",
   			url : "${pageContext.request.contextPath}/attendance/getAttendanceTable.do",
   			data : {
   				"cidx" : cidx
   				},
   			dataType : "json",
   			success : function(data){
   				
   				var str = "";
   				str = "<thead><tr>";
   				
   				$(data).each(function(){
   					str = str + "<td style='width: 60px; height: 50px;'>"+this.a_date+"("+this.ct_week+")<br>"+this.pe_period+"교시</td>";
   				});
   				
   				str = str + "</tr></thead><tbody></tbody>";
   				$("#list_table").html("<table class='listNo' id='listNo'>"+str+"</table>");
   				
				getStudentList(cidx);
   				
   				return ;
   			},
   			error: function(request, status, error){
   				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
   			}
   		});
   	
   	
   	}

   	function getStudentList(cidx){

   		$.ajax({
   			type : "post",
   			url : "${pageContext.request.contextPath}/attendance/getStudentList.do",
   			data : {
   				"cidx" : cidx
   				},
   			dataType : "json",
   			success : function(data){
   				var studentlist = "<table style='width: 80px;'><thead><tr>"
   								+"<td style='width: 30px; height: 60px;'>No</td>"
   								+"<td style='width: 50px;'>학생</td></tr></thead><tbody>";
   				$(data).each(function(){
	   				var str = "<tr>";

   					studentlist = studentlist + "<tr><td style='height:60px;'></td><td>"+this.s_name+"<br>("+this.s_no+")</td></tr>"
   					var count = this.c_totaltime;
   					
   					for(var i=0; i<count; i++){
   						var tablehead = $('#listNo thead');
   						var headtr= tablehead.children();
   						var td = headtr.children();
   						var tddate = td.eq(i).text();
   						var onlydate = tddate.substring(0,2)+tddate.substring(3,5)+"_"+tddate.substring(8,9);
   						str = str + "<td id='"+this.s_no+"_"+onlydate+"' style='height: 60px;'></td>";
   					}
   					str = str + "</tr>";
   					$("#listNo tbody").append(str);
   				});
   					studentlist = studentlist + "</tbody></table>";
   					$("#list_table_student").html(studentlist);
				
	    		
   				getEachCheck(cidx);
   				return;
   			},
   			error: function(request, status, error){
   				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
   			}
   		});
   	}
	
   	function getEachCheck(cidx){
   		$.ajax({
   			type : "post",
   			url : "${pageContext.request.contextPath}/attendance/getEachCheck.do",
   			data : {
   				"cidx" : cidx
   				},
   			dataType : "json",
   			success : function(data){
   				var td_id = "";
   				
   				$(data).each(function(){
					var attend = this.e_attendance;
   					
					td_id = "#" + this.s_no + "_" + this.a_date + "_" + this.pe_period;
					$(td_id).html(attend);
					var attend_style = $(td_id);
					if(attend ==='결석'){
						attend_style.css('color','red');
					}else if(attend === '지각' || attend ==='조퇴'){
						attend_style.css('color','orange');
					}

   				});
				
   				
	    		
   				return;
   			},
   			error: function(request, status, error){
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
      <div class="container" style="height:1500px;">
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
                 <li><a href="../attendance/attendanceSituation_p.do" target="_parent" style="color:#0078ff; font-weight: bold;">
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
                 <li><a href="../attendance/lackOfAttendance.do" target="_parent">
                 <i class="fa fa-calendar-times-o" aria-hidden="true" ></i>
                 출석 미달 관리</a></li>
               </ul>
             </li>
           </ul>
          </div>
        </div>
        <div class="contents">
            <h3>출석현황조회</h3>
            <div class="first_line">
                년도 <input type="text" name="year" value="${year}" disabled/> 학기 <input type="text" name="term" value="${semester}" disabled/>
            </div>
            <div class="list_table">
                <table class='countNo'>
                    <thead>
                        <tr>
                            <td style="width:50px">NO</td>
                            <td style="width:80px">이수구분</td>
                            <td>강의명</td>
                            <td style="width:150px">세부전공</td>
                            <td style="width:80px">수강학년</td>
                            <td style="width:150px">강의실</td>
                            <td style="width:150px">시간표</td>
                            <td style="width:80px">수강인원</td>
                            <td style="width:80px">출석률</td>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="av" items="${list}">
                        <tr>
                            <td></td>
                            <td>${av.c_sep}</td>
                            <td><button type="button" name="c_name" id="c_name" value="${av.cidx}" >${av.c_name}</button></td>
                            <td>${av.c_major}</td>
                            <td>${av.c_grade}</td>
                            <td>${av.ct_room}</td>
                            <td>${av.c_times}</td>
                            <td>${av.s_cnt}</td>
                            <td>${av.atpercent}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <br>
            <div class="first_line">
                <div style="display:inline-block;" class="selectedWrap">
                강의명 <input type="text" id="selectedCourse" value="" name="selectedC_name" style="width:250px;" disabled/>
                </div>
            </div>
            <div style="display: flex; flex-direction: row; ">
	            <div id="list_table_student" class="list_table_student" style="width: 115px; ">

	            </div>
	            <div id="list_table" class="list_table_slist" style="width: 1185px; overflow: scroll;">
	            
	            </div>
            </div>
          </div>
        </div>
      </div>
</body>
</html>