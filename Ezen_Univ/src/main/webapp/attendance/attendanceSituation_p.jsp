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
    <link rel="stylesheet" href="../css/iframe.css">
    <link rel="stylesheet" href="../css/attendanceSituation.css">
    <link rel="stylesheet" href="../css/nav_style.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <script>
    	function search_detail(c_name){
			$('#selectedCourse').empty();
			var str = c_name;
			$(".selectedWrap>input[name='selectedC_name']").val(str);
			
			return;
		}
    	
    	function searchList(){
    		let c_name = $("#selectedCourse").val();
    		let a_date = $("#attendanceDate").val();
    		let a_start = $("#timeSlot").val();
    		
    		$.ajax({
    			type : "post",
    			url : "${pageContext.request.contextPath}/attendance/searchList.do",
    			data : {
    				"c_name" : c_name,
    				"a_date" : a_date,
    				"a_start" : a_start
    				},
    			dataType : "json",
    			success : function(data){
    				
    				var str = "";
    				str = "<thead><tr>"
    				+ "<td style='width:10px'>NO</td>"
    				+ "<td style='width:30px'>전공</td>"
    				+ "<td style='width:20px'>이름</td>"
    				+ "<td style='width:20px'>학번</td>"
    				+ "<td style='width:20px'>출석상태</td>"
    				+ "</tr></thead><tbody>";
    				
    				$(data).each(function(){
    					str = str + "<tr><td></td><td>" + this.s_major + "</td><td>" 
    					+ this.s_name + "</td><td>" + this.s_no+ "</td><td><span>"
    					+ this.e_attendance + "</span></td></tr>";
    				});
    				
    				str = str + "</tbody>";
    				$("#list_table").html("<table class='listNo'>"+str+"</table>");
    				
		    		$("td span").each(function(){
		    			var txt = $(this).text();
		    			if (txt === '결석') {
		    				$(this).css('color','red');
		    			}else if (txt === '지각' || txt === '조퇴') {
		    				$(this).css('color','orange');
		    			}else {
		    				$(this).css('color','black');
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
         
         .listNo tbody>tr {
            counter-increment: aaa;
         }
        .listNo tbody>tr>td:first-child:before {
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
    <div class="container">
        <div class="sidebar">
            <div class="myinfo">
                <iframe src="../leftmenu/myinfo_p.jsp" width="100%" height="200"></iframe>
            </div>
            <div class="menubar">
                <iframe src="../leftmenu/attendance_p.jsp" width="100%" height="466"></iframe>
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
                            <td style="width:10px">NO</td>
                            <td style="width:30px">이수구분</td>
                            <td style="width:50px">과목명</td>
                            <td style="width:30px">세부전공</td>
                            <td style="width:10px">수강학년</td>
                            <td style="width:30px">강의실</td>
                            <td style="width:30px">시간표</td>
                            <td style="width:30px">수강인원</td>
                            <td style="width:10px">출석률</td>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="av" items="${list}">
                        <tr>
                            <td></td>
                            <td>${av.c_sep}</td>
                            <td><button type="button" id="c_name" value="${av.cidx}" onclick="search_detail('${av.c_name}')">${av.c_name}</button></td>
                            <td>${av.c_major}</td>
                            <td>${av.c_grade}</td>
                            <td>${av.ct_room}</td>
                            <td>${av.c_times}</td>
                            <td>${av.s_cnt}</td>
                            <td>%</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <br>
            <div class="attendance-input hidden">
                <div style="display:inline-block;" class="selectedWrap">
                선택한 과목 : <input type="text" id="selectedCourse" value="" name="selectedC_name" disabled/>
                </div>
                <input class="date" type="date" id="attendanceDate" name="attendanceDate">
                <select id="timeSlot" name="timeSlot">
                    <option value="09:00">1교시</option>
                    <option value="10:00">2교시</option>
                    <option value="11:00">3교시</option>
                    <option value="12:00">4교시</option>
                    <option value="13:00">5교시</option>
                    <option value="14:00">6교시</option>
                    <option value="15:00">7교시</option>
                    <option value="16:00">8교시</option>
                    <option value="17:00">9교시</option>
                </select>
                <button type="button" id="showAttendanceList" onclick="searchList()">출석 목록 조회</button>
            </div>
            <br>
            <div id="list_table" class="list_table">
            
            </div>
    </div>
</body>
</html>