<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.util.*" %>
<%@ page import = "app.domain.*" %>

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

function totalStudentCount(){
	 var opt = document.getElementById("selectcourse");
     var cidx = opt.options[opt.selectedIndex].value;
     //alert(cidx);
	$.ajax({
		type : "get",
		url : "<%=request.getContextPath()%>/attendance/tscount.do?cidx="+cidx,
		data : {
			"cidx" : cidx
			},
		dataType : "json",
		success : function(data){
			//alert("성공");
			$('#totalScount').empty();
			var str = data.s_cnt;
			$(".selectedWrap>input[name='totalScount']").val(str);
		},
		error : function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		} 
	});
	return;
}




</script>
</head>
<body>
    <div class="header">
        <iframe src = "../main/navigation_s.jsp" width = "100%" height="55" ></iframe>
    </div>
    <div class="container">
	    <div class="sidebar">
	        <div class="myinfo">
	            <iframe src = "../leftmenu/myinfo_p.jsp" width="100%" height="200"></iframe>
	        </div>
	        <div class="menubar">
	            <iframe src = "../leftmenu/attendance_p.jsp" width="100%" height="466"></iframe>
	        </div>
	    </div>
	    <div class="contents">
            <h3>출석관리</h3>
            <div class="first_line">
                <div> 
                    교과목명
                    <select id="selectcourse" onchange="totalStudentCount()">
                      <option></option>
                      <c:forEach var="av" items="${list}">
                        <option value="${av.cidx}">${av.c_name}</option>
                      </c:forEach>
                    </select>
                    &ensp;
                   	<div style="display:inline-block" class="selectedWrap">
					총 수강 인원 <input type="text" id="totalScount" name="totalScount" value="" disabled/>
                    </div>
                </div>
            </div>
	        <div class="mytable">
	            <table>
	                <thead>
	                    <tr>
	                        <td style="width:50px">주차</td>
	                        <td style="width:400px">수업일자</td>
	                        <td style="width:400px">수업시간</td>
	                        <td style="width:50px">출석</td>
                            <td style="width:50px">지각</td>
                            <td style="width:50px">조퇴</td>
                            <td style="width:50px">결석</td>
                            <td style="width:150px">처리</td>
	                    </tr>
	                </thead>
	                <tbody>
	                    <tr>
	                        <td>1</td>
	                        <td>03월 02일</td>
	                        <td>10:00~10:50</td>
	                        <td>20</td>
                            <td>0</td>
                            <td>0</td>
                            <td>0</td>
                            <td><button type="button" value="" onclick="location.href='attendanceManagement.jsp'">출결처리</button></td>
	                    </tr>
						<tr>
	                        <td></td>
	                        <td>03월 02일 11:00~11:50</td>
	                        <td>20</td>
                            <td>0</td>
                            <td>0</td>
                            <td>0</td>
                            <td><button type="button">출결처리</button></td>
	                    </tr>
						<tr>
	                        <td>2</td>
	                         <td>03월 09일 10:00~10:50</td>
	                        <td>12</td>
                            <td>1</td>
                            <td>7</td>
                            <td>1</td>
                            <td><button type="button">출결처리</button></td>
	                    </tr>
						<tr>
	                        <td></td>
	                        <td>03월 09일 11:00~11:50</td>
	                        <td>12</td>
                            <td>1</td>
                            <td>7</td>
                            <td>1</td>
                            <td><button type="button">출결처리</button></td>
	                    </tr>
						<tr>
	                        <td>3</td>
	                        <td>03월 16일 10:00~10:50</td>
	                        <td>17</td>
                            <td>3</td>
                            <td>0</td>
                            <td>0</td>
                            <td><button type="button">출결처리</button></td>
	                    </tr>
						<tr>
	                        <td></td>
	                        <td>03월 16일 11:00~11:50</td>
	                        <td>17</td>
                            <td>3</td>
                            <td>0</td>
                            <td>0</td>
                            <td><button type="button">출결처리</button></td>
	                    </tr>
						<tr>
	                        <td>4</td>
	                        <td>03월 23일 10:00~10:50</td>
	                        <td>20</td>
                            <td>0</td>
                            <td>0</td>
                            <td>0</td>
                            <td><button type="button">출결처리</button></td>
	                    </tr>
						<tr>
	                        <td></td>
	                        <td>03월 23일 11:00~11:50</td>
	                        <td>20</td>
                            <td>0</td>
                            <td>0</td>
                            <td>0</td>
                            <td><button type="button">출결처리</button></td>
	                    </tr>
	                </tbody>
	            </table>
	        </div>
        </div>
	</div>

</body>
</html>