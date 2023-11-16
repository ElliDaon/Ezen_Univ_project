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
<style>
	.mytable{
		height: 900px;
		font-size: 20px;
		overflow-y: scroll;
	}
	tbody tr:hover {
	background: #F2F2F2;
	}
</style>
<script>


function chooseCourse(){
	
	var opt = document.getElementById("selectcourse");
    var cidx = opt.options[opt.selectedIndex].value;

    totalStudentCount(cidx);
    professorManagement(cidx);
    
    return;
}


function professorManagement(cidx){

 	$.ajax({
		type : "get",
		url : "<%=request.getContextPath()%>/attendance/professorManagement.do?cidx=" + cidx,
		dataType : "json",
		success : function(data){
			$('#mytable').empty();
			var str = "<table><thead><tr><td style='width:50px'>주차</td><td style='width:400px'>수업일자</td>"
                	+"<td style='width:400px'>수업시간</td><td style='width:50px'>출석</td><td style='width:50px'>조퇴</td>"
                	+"<td style='width:50px'>지각</td><td style='width:50px'>결석</td><td style='width:150px'>처리</td>"
            		+"</tr></thead><tbody>";
			
            $.each(data, function(i) {
            	str += "<tr><td>"+data[i].w_week+"</td><td>"+data[i].wk+"("+data[i].ct_week+")</td><td>"
            		+data[i].pe_period+"교시("+data[i].pe_start+" ~ "+data[i].pe_end+")</td>"
                    +"<td>"+data[i].att+"</td><td>"+data[i].early+"</td><td>"+data[i].late+"</td>"
                    +"<td>"+data[i].absent+"</td><td><button type='button' class='btn' onclick='attendancdManagement()'>출결처리</button></td></tr>";
            });
            str += "</tbody></table>";
            $('#mytable').append(str);
		},
		error : function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		} 
	});
            
	return; 
	
}



function totalStudentCount(cidx){

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

function attendancdManagement(){

	var str = ""
	var tdArr = new Array();
	var checkBtn = $('.btn');
	var cidx = $('#selectcourse').val();

	var tr = checkBtn.parent().parent();
	var td = tr.children();

	
	var no = td.eq(0).text();
	var dates = td.eq(1).text();
	var week = td.eq(1).text();
	var period = td.eq(2).text();
	var now = new Date();	
	var year = now.getFullYear();
	
	dates = year+"-"+dates.substring(0,2)+"-"+dates.substring(3,5);
	week = week.substring(7,8);
	period = period.substring(0,1);
	
	// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
	td.each(function(i){	
		tdArr.push(td.eq(i).text());
	});

	
	str += "cidx: "+cidx+"\n 주차: " +no+"\n 수업일자: "+dates+"\n 수업요일: "+week+"\n 수업교시: "+period;	
	
	//alert(str);
	
 	$.ajax({
		type : "get",
		url : "<%=request.getContextPath()%>/attendance/attendanceManagement.do?",
		data : {
			"cidx" : cidx,
			"no" : no,
			"dates" : dates,
			"week" : week,
			"period" : period
			},
		dataType : "json",
		success : function(data){
			window.location.href = "<%=request.getContextPath()%>/attendance/professorAttendProcessing.do?cidx="+data.cidx+"&w_week="+data.w_week+"&dates="+data.dates+"&ct_week="+data.ct_week+"&period="+data.period;
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
                    <select id="selectcourse" onchange="chooseCourse()">
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
	        <div class="mytable" id="mytable">
	            
	                    
	                
	        </div>
        </div>
	</div>

</body>
</html>