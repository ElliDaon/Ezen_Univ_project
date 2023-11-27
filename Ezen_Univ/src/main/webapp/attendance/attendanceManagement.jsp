<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="../css/nav_style.css">
    <link rel="stylesheet" href="../css/attmanage.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    
    $(document).ready(function(){
	    $("#attbtn").on("click",function(){
	    	var fm = document.attendancefrm;
	    	var ctidx = fm.ctidx.value;
	    	var a_date = fm.a_date.value;
	    	var pe_start = fm.pe_start.value;
	    	var pe_end = fm.pe_end.value;
	    	var cidx = fm.cidx.value;
	    	var widx = fm.widx.value;
	    	var period = fm.period.value;
	    	
	    	var checkbox = $("input[name='student']:checked");
	    	
	    	var jsonArray 	= new Array();
	    	//jsonArray.push(list);
	    	checkbox.each(function (i) {
	    		var jsonObj = new Object();
	    		
	    		var tr = checkbox.parent().parent().eq(i);
				var td = tr.children();
				var attendvalue = td.eq(4).children().val();
				
				jsonObj.clidx = $(this).val();
				jsonObj.attendvalue = attendvalue;
				
				jsonObj = JSON.stringify(jsonObj);
				
				jsonArray.push(JSON.parse(jsonObj));
				
	        });
			
	    	
	    	let arrays = JSON.stringify(jsonArray);
	    	//alert("list:\n"+JSON.stringify(list));
	    	
	    	$.ajax({
	    		type : "get",
	    		url : "<%=request.getContextPath()%>/attendance/attendanceAction.do",
	    		data : {
	    			ctidx:ctidx,
	    			a_date:a_date,
	    			pe_start:pe_start,
	    			pe_end:pe_end,
	    			cidx:cidx,
	    			widx:widx,
	    			period:period,
	    			Array:arrays
	    		},
	    		dataType : "json",
	    		success : function(data){
	    			if(data.value == 0){
						alert("입력오류");	    				
	    			}else{
		    			alert("성공");
		    			var loc = "<%=request.getContextPath()%>/attendance/attendancePreManagement.do";
		    			location.href=loc;
	    			}
	    			
	    		},
	    		error : function(request, status, error){
	    			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    		} 
	    	});
	    	return;
	    	
	    });
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
                <form name="attendancefrm"> 
            	<div class="first_line">
                    강의명
                    <input type="text" name="c_name" value="${av.c_name}" disabled>
                    <input type="hidden" name="ctidx" value="${av.ctidx}">
                    <input type="hidden" name="a_date" value="${av.a_date}">
                    <input type="hidden" name="pe_start" value="${av.pe_start}">
                    <input type="hidden" name="pe_end" value="${av.pe_end}">
                    <input type="hidden" name="cidx" value="${av.cidx}">
                    <input type="hidden" name="widx" value="${av.widx}">
                    <input type="hidden" name="period" value="${av.pe_period}">
           		</div>
           		<br>
           		<div class="student-list">
           		<div style="display:flex;">
           		<h3>
           			<i class="fa fa-pencil-square" aria-hidden="true"></i>
           			${str2}(${av.pe_start}~${av.pe_end})
           		</h3>
                	<button type="button" name="attbtn" id="attbtn" class="btn">저장</button>
                </div>
                    <div class="std-list">
                        <table class="std-list-tbl">
                            <thead>
                                <tr>
                                    <th style="width: 5%;">
                                        <input type="checkbox" name="student" value="selectAll" onclick="selectAtt(this)" checked>
                                    </th>
                                    <th style="width: 5%;">NO</th>
                                    <th style="width: 20%;">이름</th>
                                    <th style="width: 20%;">학번</th>
                                    <th style="width: 10%;">출결구분</th>
                                    <th style="width: 30%;">처리</th>
                                    <th style="width: 10%;">비고</th>
                                </tr>
                            </thead>
                            <tbody>
                           		<c:forEach var="mv" items="${list}" varStatus="i">
                                <tr style="height: 20px;">
                                    <td>
                                        <input type="checkbox" name="student" value="${mv.clidx}" checked>
                                    </td>
                                    <td>${i.count}</td>
                                    <td>${mv.s_name}</td>
                                    <td>${mv.s_no}</td>
                                    <td><input class="attenvalue" type="text" id="value${i.count}" name="value${i.count}" value="${mv.e_attendance}" disabled></td>
                                    <td>
                                        <input type="radio" id="att${i.count}" name="attendvalue${i.count}" value="출석" onclick="getValue(event,${i.count})"><label for="att${i.count}">출석</label>
                                        <input type="radio" id="late${i.count}" name="attendvalue${i.count}" value="지각" onclick="getValue(event,${i.count})"><label for="late${i.count}">지각</label>
                                        <input type="radio" id="early${i.count}" name="attendvalue${i.count}" value="조퇴" onclick="getValue(event,${i.count})"><label for="early${i.count}">조퇴</label>
                                        <input type="radio" id="absent${i.count}" name="attendvalue${i.count}" value="결석" onclick="getValue(event,${i.count})"><label for="absent${i.count}">결석</label>
                                    	<script>
	                                        $(document).ready(function () {
	                                            var value = $("input[name='value${i.count}']").val();
	                                            var radioName = "attendvalue${i.count}";
	                                            
	                                            if (value === '출석') {
	                                                $("input[name='" + radioName + "'][value='출석']").prop('checked', true);
	                                            } else if (value === '지각') {
	                                                $("input[name='" + radioName + "'][value='지각']").prop('checked', true);
	                                            }else if (value === '조퇴') {
	                                                $("input[name='" + radioName + "'][value='조퇴']").prop('checked', true);
	                                            }else if (value === '결석') {
	                                                $("input[name='" + radioName + "'][value='결석']").prop('checked', true);
	                                            }
	                                            
	                                           
	                                            
	                                       
	                                        
	                                     // 페이지 로드 시 체크된 상태를 감지하여 CSS 변경
		                                        $('input[name="attendvalue${i.count}"]').each(function() {
		                                            var value = $(this).val();
		                                            var checked = $(this).prop('checked');
		                                            
		                                            var $label = $(this).next();
		                                            
		                                            if (checked && value === '출석') {
		                                                $label.css('background-color', '#459B60');
		                                                $label.css('border', '1px solid #459B60');
		                                                $label.css('color', 'white');
		                                            } else if (checked && (value === '지각' || value === '조퇴')) {
		                                                $label.css('background-color', '#E3C22A');
		                                                $label.css('border', '1px solid #E3C22A');
		                                                $label.css('color', 'white');
		                                            } else if (checked && value === '결석') {
		                                                $label.css('background-color', '#D95321');
		                                                $label.css('border', '1px solid #D95321');
		                                                $label.css('color', 'white');
		                                            } else {
		                                                $label.css('background-color', 'white');
		                                                $label.css('border', '1px solid 555555');
		                                                $label.css('color', '#555555');
		                                            }
		                                        });
	
		                                        // 라디오 버튼의 체크 상태가 변경될 때의 이벤트 핸들러
		                                        $('input[name="attendvalue${i.count}"]').change(function() {
		                                            $('input[name="attendvalue${i.count}"]').each(function() {
		                                                var value = $(this).val();             
		                                                var checked = $(this).prop('checked'); 
		                                                
		                                                var $label = $(this).next();
		                                                 
		                                                if (checked && value === '출석') {
		                                                    $label.css('background-color', '#459B60');
		                                                    $label.css('border', '1px solid #459B60');
		                                                    $label.css('color', 'white');
		                                                } else if (checked && (value === '지각' || value === '조퇴')) {
		                                                    $label.css('background-color', '#E3C22A');
		                                                    $label.css('border', '1px solid #E3C22A');
		                                                    $label.css('color', 'white');
		                                                } else if (checked && value === '결석') {
		                                                    $label.css('background-color', '#D95321');
		                                                    $label.css('border', '1px solid #D95321');
		                                                    $label.css('color', 'white');
		                                                } else {
		                                                    $label.css('background-color', 'white');
		                                                    $label.css('border', '1px solid 555555');
		                                                    $label.css('color', '#555555');
		                                                }
		                                            });
		                                        });
	                                        });
                                    	</script>
                                    </td>
                                    <td></td>
                                </tr>
                           		</c:forEach>
                            </tbody>
                        </table>
                    </div>
            	</div>
        	</form>
        </div>
      </div>
    </div>
    <script src="../js/attendanceManage.js"></script>
</body>
</html>