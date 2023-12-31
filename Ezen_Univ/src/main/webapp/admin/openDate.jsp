<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>개강일자등록</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<link rel="stylesheet" href="../css/admin.css">
    <link rel="stylesheet" href="../css/nav_style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <style>
    .contents table tr, td {
    padding: 0.7em 0;
    border: 1px solid #ccc;
    text-align: center;
}
    </style>
    
    <script>
	$(document).ready(function() {
	    
	    let currentDate = new Date();
	    let year = currentDate.getFullYear();
	    
	    let month = currentDate.getMonth() + 1;
	    let term = (month >= 2 && month <= 7) ? 1 : 2;

	    openDateList(year, term);
		
        // 로컬 스토리지에서 "selectedMember" 값을 가져오기
        const selectedMember = localStorage.getItem('selectedMember');

        // 로컬 스토리지에서 "isStudentChecked" 값을 가져오기
        const isStudentChecked = localStorage.getItem('isStudentChecked') === 'true';

        // 로컬 스토리지에서 "isProfessorChecked" 값을 가져오기
        const isProfessorChecked = localStorage.getItem('isProfessorChecked') === 'true';
		
        // 로그아웃 링크 클릭 시 로컬 스토리지 초기화
        $('#logoutLink').click(function() {
            localStorage.removeItem('selectedMember');
            localStorage.removeItem('isStudentChecked');
            localStorage.removeItem('isProfessorChecked');

        });

		const dateInput = document.getElementById('dateInput');
		const dateInfoYear = document.getElementById('dateInfoYear');
		const dateInfoSemester = document.getElementById('dateInfoSemester');
	    let fm = document.frm;
	    fm.action = "<%=request.getContextPath()%>/admin/openDateRegisterAction.do";
	    fm.method = "post";
		
	    dateInput.addEventListener('change', function() {
	
	        let confirmation = confirm("해당 일자로 선택하시겠습니까?"); // 확인 창 표시
	        if (confirmation) {
	 
		        const selectedDate = dateInput.value;
		        const parsedDate = new Date(selectedDate);
		        const yearValue = parsedDate.getFullYear();
		        dateInfoYear.value = yearValue;
		        
		        const selectedMonth = parsedDate.getMonth()+1;
		        const selectedDay = parsedDate.getDay();
				
		        if(selectedDay !==1){
		        	alert('월요일을 선택해야 합니다. 다시 선택해주세요.');
		        	return;	
		        }
		 
		        if(selectedMonth >= 2 && selectedMonth <= 3){
		        	dateInfoSemester.value = '1';
		        }else if(selectedMonth >= 8 && selectedMonth <= 9){
		        	dateInfoSemester.value = '2';
		        }else {
		            alert('개강 입력이 가능한 일자는 1학기 2~3월, 2학기 8~9월에 등록 가능합니다.')
		            
		            return;
		        }
		        
	             $.ajax({
	                type: "post",
	                url: "${pageContext.request.contextPath}/admin/openDateRegisterCheck.do",
	                dataType: "json",
	                data:{
	                	"dateInfoYear": dateInfoYear.value,
	                	"dateInfoSemester": dateInfoSemester.value
	                },
	                cache: false,
	                success: function (data) {
						if(data.cnt ==0){
							
							fm.submit();		
						}else if(data.cnt >=0){
	                		
		                    let confirmation = confirm("해당 년도, 학기에 이미 입력되어있습니다. 그래도 등록하시겠습니까?"); // 확인 창 표시
		                    if (confirmation) {
		                    	fm.action = "<%=request.getContextPath()%>/admin/openDateUpdateAction.do";
		                   		fm.submit();
		                    };
	                	};    
	                },
	                error: function () {
	                    alert("통신오류 실패");
	                }
	            });
	
	        }
	    });
	});
	
     // 등록된 개강날짜 리스트 
    function openDateList(year, term) {
        //alert("통신 시도");
        $.ajax({
            type: 'POST',
            url: "${pageContext.request.contextPath}/admin/openDateList.do",
            data: {
                "year": year,
                "term": term
            },
            success: function(data) {
            	openDateListTable(data);
            	
            },	
            error: function(error) {
            	 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    }
     
    function openDateListTable(data){
    	let parsedData = JSON.parse("["+data+"]");
    	let str = "<table style='width:1000px;'><thead><tr><th>주차</th><th>시작 날짜</th><th>종료 날짜</th></tr></thead><tbody>";	
    	parsedData.forEach(function (item){
    		
    		str += "<tr><td>"+item.w_week+"</td>" +
			"<td>"+item.w_start+"</td>" +
    		"<td>"+item.w_end+"</td></tr>";
    	});
    	str += "</tbody></table>";
    	
    	
    	$("#openDateList").html(str);
    	
    	return;
    }
     
</script>
</head>
<body>
	<div id="main-header">
		<header class="mainHeader">
			<section class="mainHeaderSection">
				<div>
					<a href="../admin/accept.do" class="logoLink" target="_parent"><img src="../images/ezen_univ.png" width="150"></a>
					<div class="headerMenu">
						<nav class="menuList">
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../admin/accept.do" target="_parent">가입승인</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../admin/courseRegister.do" target="_parent">강의등록</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../admin/courseEnroll.do" target="_parent">수강등록</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin" style="font-weight: bold"><a href="../admin/openDate.do" target="_parent">개강일자등록</a></div>
							</div>
						</nav>
					</div>
				</div>
			</section>
		</header>
	</div>
    <div class="main">
      <div class="container" style="height:1100px;">
        <div class="sidebar">
          <div class="top">	
            <div id="myinfo" class="myinfo" style="margin-top:20px;">
              <!-- <iframe src = "../leftmenu/myinfo_s.jsp" width="100%" height="100%"></iframe> -->
              [관리자모드]
            </div>
            <br>
            <div class="logStatus" style="font-weight: bold">
              <a href="<%=request.getContextPath()%>/member/memberLogout.do" target="_parent" id="logoutLink">logout</a>
            </div>
          </div>
          <br>
          <div class="topmenu_name">개강등록</div>
          <div class="bottom">
           <ul>
             <li class="personalinfo">
               <ul>
                 <li><a href="../admin/openDate.do" target="_parent" style="color:#0078ff; font-weight: bold;">
                 <i class="fa fa-calendar" aria-hidden="true"></i>
                  개강일자등록</a></li>
               </ul>
             </li>
           </ul>
          </div>
        </div>
	    <div class="contents">
	    <form name="frm" >
	        <h3>개강일자 등록</h3>
	        <div class="first_line"> 
		        개강일자 선택&emsp;<input type="date" id="dateInput" name="dateInput" style="width:150px;"/>
		        <input type="hidden" id="dateInfoYear" name="dateInfoYear" />
	            <input type="hidden" id="dateInfoSemester" name="dateInfoSemester" />
	        </div>
	        <br>
	        <h3>현재 학기에 등록된 날짜</h3>
	        <div style="display:flex;">
	        <div id="openDateList">
	        <!-- 등록된 날짜가 주차배열로 보여줌 -->
	        </div>
	        <div class="fixed">
	        <h2>※ 공지 ※</h2>
	        <br>
	        개강일자는 1학기 기준 <span>2~3월</span> / 2학기 기준 <span>8~9월</span>, 요일은 <span>월요일</span>만 등록 가능합니다.
	        </div>
	        </div>
	    </form>
	    </div>
	    
	    
	</div>
</div>

</body>
</html>





