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
    <link rel="stylesheet" href="../css/attmanage.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script>
    $("#attbtn").on("click",function(){
    	var fm = document.attendancefrm;
    	var c_name = fm.c_name.value;
    	var ctidx = fm.ctidx.value;
    	var a_date = fm.a_date.value;
    	var pe_start = fm.pe_start.value;
    	var pe_end = fm.pe_end.value;
    	var cidx = fm.cidx.value;
    	var widx = fm.widx.value;
    	
    	var jsonArray 	= new Array();
    	//jsonArray.push(list);
    	$("[name='student']:checked").each(function () {
    		var jsonObj = new Object();
    		
    		var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();
			var attendvalue = td.eq(4).text();
			
			jsonObj.clidx = $(this).val();
			jsonObj.attendvalue = attendvalue;
			
			jsonObj = JSON.stringify(jsonObj);
			
			jsonArray.push(JSON.parse(jsonObj));
			
        });
		
    	var list = {
    		"c_name":c_name,
    		"ctidx":ctidx,
    		"a_date":a_date,
    		"pe_start":pe_start,
    		"pe_end":pe_end,
    		"cidx":cidx,
    		"widx":widx,
    		"Array":jsonArray
    	};
    	alert("list:\n"+list);
    	alert("c_name: "+c_name+"\n ctidx: "+ctidx+"\n a_date: "+a_date+"\n pe_start: "+pe_start+"\n pe_end: "+pe_end+"\n cidx: "+cidx + "\n widx: "+widx);
    	alert(jsonObj);
		alert(jsonArray.join("\n"));	
    	
    });
    
    </script>
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
            <h3>출석관리</h3>
                <form name="attendancefrm"> 
            	<div class="select-sub">
                    교과목명
                    <input type="text" name="c_name" value="${av.c_name}" disabled>
                    <input type="hidden" name="ctidx" value="${av.ctidx}">
                    <input type="hidden" name="a_date" value="${av.a_date}">
                    <input type="hidden" name="pe_start" value="${av.pe_start}">
                    <input type="hidden" name="pe_end" value="${av.pe_end}">
                    <input type="hidden" name="cidx" value="${av.cidx}">
                    <input type="hidden" name="widx" value="${av.widx}">

           		</div>
           		<div class="student-list">
                    <div class="btn">
                        <button type="button" id="attbtn">저장</button>
                    </div>
                    <div class="std-list">
                        <table>
                            <thead>
                                <tr>
                                    <td style="width: 5px;">
                                        <input type="checkbox" name="student" value="selectAll" onclick="selectAtt(this)">
                                    </td>
                                    <td style="width: 5px;">순번</td>
                                    <td style="width: 20px;">이름</td>
                                    <td style="width: 25px;">학번</td>
                                    <td style="width: 5px;">출결구분</td>
                                    <td style="width: 40px;">비고</td>
                                    <td style="width: 60px;">처리</td>
                                </tr>
                            </thead>
                            <tbody>
                           		<c:forEach var="mv" items="${list}" varStatus="i">
                                <tr style="height: 20px;">
                                    <td>
                                        <input type="checkbox" name="student" value="${mv.clidx}" >
                                    </td>
                                    <td>${i.count}</td>
                                    <td>${mv.s_name}</td>
                                    <td>${mv.s_no}</td>
                                    <td><input class="attenvalue" type="text" id="value${i.count}" value="" disabled></td>
                                    <td></td>
                                    <td>
                                        <input type="radio" name="attendvalue${i.count}" value="출석" onclick="getValue(event,${i.count})">출석
                                        <input type="radio" name="attendvalue${i.count}" value="지각" onclick="getValue(event,${i.count})">지각
                                        <input type="radio" name="attendvalue${i.count}" value="조퇴" onclick="getValue(event,${i.count})">조퇴
                                        <input type="radio" name="attendvalue${i.count}" value="결석" onclick="getValue(event,${i.count})">결석
                                    </td>
                                </tr>
                           		</c:forEach>
                            </tbody>
                        </table>
                    </div>
            	</div>
        	</form>
        </div>
    </div>
    <script src="../js/attendanceManage.js"></script>
</body>
</html>