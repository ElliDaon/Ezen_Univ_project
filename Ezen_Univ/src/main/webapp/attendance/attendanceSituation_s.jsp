<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "app.domain.*" %>
<%
//포워든 공유속성때문에 넘겨받을 수 있다
//ArrayList<AttendanceVo> list = null;
//list = (ArrayList<AttendanceVo>)request.getAttribute("list"); %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="../css/iframe.css">
    <link rel="stylesheet" href="../css/attendanceSituation.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>

function search_detail(cidx){

	countAction(cidx);
	listAction(cidx);
	//alert(cidx);
	return;
}

function countAction(cidx){

	
	$.ajax({
		type : "get",	//cidx값 하나만 넘기니까 get방식으로 주소를 넘긴다 -> get방식은 하단의 URL 끝에 ?붙여서 cidx 붙여주기
		url : "<%=request.getContextPath()%>/attendance/attendanceCount.do?cidx="+cidx,
		dataType : "json",
		cache : false,
		success : function(data){
			$('#details_first').empty();
			str = '출석 <input type="text" name="attendance" value="'+data.attcnt+'" disabled/>&emsp;'
        	+'지각 <input type="text" name="late" value="'+data.latecnt+'" disabled/>&emsp;'
        	+'조퇴 <input type="text" name="leave_early" value="'+data.leavecnt+'" disabled/>&emsp;' 
        	+'결석 <input type="text" name="absent" value="'+data.absentcnt+'" disabled/>'
			
        	$('#details_first').append(str);
		},
		error : function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	return;
}

function listAction(cidx){
	
	$.ajax({
		type : "get",	//cidx값 하나만 넘기니까 get방식으로 주소를 넘긴다 -> get방식은 하단의 URL 끝에 ?붙여서 cidx 붙여주기
		url : "<%=request.getContextPath()%>/attendance/attendanceList.do?cidx="+cidx,
		dataType : "json",
		cache : false,
		success : function(data){
			
			$('#attendanceList').empty();
			
			var str2="";
			str2 = "<table><thead><tr><td>주차</td><td>수업일자</td><td>수업시간</td><td>출결현황</td></tr></thead>"
			str2 += '<tbody>'
				$.each(data, function(i) {
				str2 += '<tr><td>'+data[i].widx+'</td>'
						+'<td>'+data[i].atdate+'</td>'
						+'<td>'+data[i].attime+'</td>'
						+'<td>'+data[i].e_attendance+'</td></tr>';
				});
				str2 += '</tbody></table>';
			
			$('#attendanceList').append(str2);
		},
		error : function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
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
    <div class="header">
        <iframe src = "../main/navigation_s.jsp" width = "100%" height="55" ></iframe>
    </div>
    <div class="container">
	    <div class="sidebar">
	        <div class="myinfo">
	            <iframe src = "../leftmenu/myinfo_s.jsp" width="100%" height="200"></iframe>
	        </div>
	        <div class="menubar">
	            <iframe src = "../leftmenu/attendance_s.jsp" width="100%" height="466"></iframe>
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
                            <td style="width:10px">학점</td>
                            <td style="width:30px">교수</td>
                            <td style="width:30px">강의실</td>
                            <td style="width:40px">시간표</td>
                            <td style="width:30px">결석률</td>
                            <td style="width:30px">미달여부</td>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="av" items="${list}">
                        <tr>
                            <td></td>
                            <td>${av.c_sep}</td>
                            <td><button type="button" id="c_name" value="${av.cidx}" onclick="search_detail(${av.cidx})">${av.c_name}</button></td>
                            <td>${av.c_score}</td>
                            <td>${av.p_name}</td>
                            <td>${av.ct_room}</td>
                            <td>${av.c_times}</td>
                            <td>${av.abpercent}</td>
                            <c:choose>
	                            <c:when test="${av.abyn eq 'Y'}">
		                            <td style="font-weight:bold; color: red;">${av.abyn}</td>
	                            </c:when>
	                            <c:otherwise>
	    	                        <td>${av.abyn}</td>
	                            </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <br>
            <div class="contents_details">
	            <div class="details_first_line" id="details_first">
	            	
	            </div>
	            <div class="mytable" id="attendanceList">
	                <%-- <table>
	                    <thead>
	                        <tr>
	                            <td style="width:30px">주차</td>
	                            <td style="width:100px">수업일자</td>
	                            <td style="width:100px">수업시간</td>
	                            <td style="width:50px">출결현황</td>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <c:forEach var="av" items="${alist}">
	                        <tr>
	                            <td>${av.widx}</td>
	                            <td>${av.atdate}</td>
	                            <td>${av.attime}</td>
	                            <td>${av.e_attendance}</td>
	                        </tr>
	                      </c:forEach>
	                    </tbody>
	                </table> --%>
	            </div>
            </div>
        </div>
	</div>

</body>
</html>