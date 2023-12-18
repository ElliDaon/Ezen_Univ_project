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
    <link rel="stylesheet" href="../css/nav_style.css">
    <link rel="stylesheet" href="../css/attendanceSituation.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
/* 	.mytable{
		height: 900px;
		font-size: 20px;
		overflow-y: scroll;
		width: 1330px;
	} */
	tbody tr:hover {
	background: aliceblue;
	}
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

$(document).ready(function () {
    // 페이지 로드 시 저장된 값을 가져와서 설정
    var storedCidx = localStorage.getItem('selectedCidx');
    if (storedCidx) {
        $("#selectcourse").val(storedCidx);
        chooseCourse();  // 페이지 로드 시 선택된 값에 대한 초기 AJAX 호출
    }

    // select 요소에 대한 change 이벤트 핸들러 등록
    $('#selectcourse').on('change', function () {
        var selectedCidx = $(this).val();
        chooseCourse(selectedCidx);

        // 선택된 값을 로컬 스토리지에 저장
        localStorage.setItem('selectedCidx', selectedCidx);
    });

    // 뒤로 가기 이벤트에 대한 핸들러 등록
    window.addEventListener('popstate', function (event) {
        // 저장된 값이 있을 경우 해당 값으로 AJAX 호출
        var storedCidx = localStorage.getItem('selectedCidx');
        if (storedCidx) {
            chooseCourse(storedCidx);
        }
    });
    chooseCourse(storedCidx);
});

function chooseCourse(selectedCidx) {
    $('#mytable').empty();

    // 선택된 값이 있을 때만 AJAX 호출
    if (selectedCidx) {
        totalStudentCount(selectedCidx);
        professorManagement(selectedCidx);
    }

    return;
}
	
	function professorManagement(cidx){
	
	 	$.ajax({
			type : "get",
			url : "<%=request.getContextPath()%>/attendance/professorManagement.do?cidx=" + cidx,
			dataType : "json",
			success : function(data){
				var totalcnt = parseInt($('#totalScount').val(), 10);
				$('#mytable').empty();
				var str = "<table><thead><tr><td style='width:50px'>주차</td><td style='width:250px'>수업일자</td>"
	                	+"<td style='width:400px'>수업시간</td><td style='width:50px'>출석</td><td style='width:50px'>조퇴</td>"
	                	+"<td style='width:50px'>지각</td><td style='width:50px'>결석</td><td style='width:150px'>출결처리</td>"
	            		+"</tr></thead><tbody>";
				
	            $.each(data, function(i) {
					var cnt = 0;
					
	            	str += "<tr><td>"+data[i].w_week+"</td><td>"+data[i].wk+"("+data[i].ct_week+")</td><td>"
	            		+data[i].pe_period+"교시("+data[i].pe_start+" ~ "+data[i].pe_end+")</td>"
	                    +"<td>"+data[i].att+"</td><td>"+data[i].early+"</td><td>"+data[i].late+"</td>"
	                    +"<td>"+data[i].absent;
	                    cnt += parseInt(data[i].att, 10) + parseInt(data[i].early, 10) + parseInt(data[i].late, 10) + parseInt(data[i].absent, 10);

	                	if(cnt>=totalcnt){
		                	str +="</td><td><button type='button' class='btn' style='background-color:#F2F2F2;'>출결조회</button></td></tr>";
	                	}else{
		                	str +="</td><td><button type='button' class='btn' style='background-color:#0067B3;"
		                		 +" color:white; border:1px solid #0067B3;'>출결처리</button></td></tr>";
	                	}
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

	
	$(document).on('click','.btn',function(){
	
		var str = ""
		var tdArr = new Array();
		var checkBtn = $(this);
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
	
		
		str += " 주차: " +no+"주차\n 수업일자: "+dates+"\n 수업요일: "+week+"\n 수업교시: "+period+"교시";	
		
		alert(str);
		//return;
		
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
		
	
	});

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
      <div class="container" style="height:2200px;">
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
                 <li><a href="../attendance/attendancePreManagement.do" target="_parent" style="color:#0078ff; font-weight: bold;">
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
            <h3>출석관리</h3>
            <div class="first_line">
                <div> 
                    강의명
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
	</div>

</body>
</html>