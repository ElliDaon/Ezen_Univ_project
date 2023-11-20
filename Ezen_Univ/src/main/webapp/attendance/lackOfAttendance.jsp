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
    <link rel="stylesheet" href="../css/attendanceSituation.css">
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	 <script>
	 
	 function displaySecondTable(cidx){

		    
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
        <iframe src = "../main/navigation_p.jsp" width = "100%" height="55" ></iframe>
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
            
            <h3>C언어</h3>
            <div class="list_table" id="studentList">

            </div>
        </div>
	</div>

</body>
</html>