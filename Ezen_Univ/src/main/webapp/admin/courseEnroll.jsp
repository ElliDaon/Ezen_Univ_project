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
    <link rel="stylesheet" href="../css/nav_style.css">
    <link rel="stylesheet" type="text/css" href="../css/admin.css">
   <style type="text/css">

		/* 마우스 호버 시에 스타일 변경 */
	.course-name {
	    cursor: pointer; /* 마우스가 요소 위로 올라갔을 때 포인터로 변경 */
	    color: blue; /* 기본 텍스트 색상 */
	    text-decoration: none; /* 기본 텍스트에 밑줄 없음 */
	}
	
	.course-name:hover {
	    text-decoration: underline; /* 마우스 호버 시에 밑줄 추가 */
	}
	
	/* 클릭 시에 스타일 변경 (선택 사항) */
	.course-name:active {
	    color: red; /* 클릭 시 텍스트 색상 변경 */
	}
   
   </style>
    
    <script>
    $(document).ready(function(){
        // 현재 날짜를 가져와서 년도, 학기 input에 입력
        let currentDate = new Date();
        let year = currentDate.getFullYear();
        
        let month = currentDate.getMonth() + 1;
        let term = (month >= 2 && month <= 7) ? 1 : 2;
        
        $('#yearInput').val(year);
        $('#termInput').val(term);
        courseRegisterList(year, term);
    
        
        // 전체 체크
        $("#studentSelectAll").change(function () {
            $("[name='studentCheckbox']").prop('checked', $(this).prop("checked"));
        });
        
     	// 일괄 처리 버튼 클릭 이벤트
        $("#batchBtn").click(function () {
            let confirmation = confirm("일괄 등록하겠습니까?"); // 확인 창 표시
            if (confirmation) {
	        	let cidx = $(this).val();
	            let selectedStudent = [];
	            //console.log("클릭한 버튼의 value 값:", cidx);
	
	            // 선택된 체크박스의 값을 배열에 추가
	            $("[name='studentCheckbox']:checked").each(function () {
	            	selectedStudent.push($(this).val());
	            });
	
	            // 배열을 JSON 문자열로 변환
	            let jsonIds = JSON.stringify(selectedStudent);
	
	            // AJAX를 통해 서버로 전송
	            $.ajax({
	                type: 'POST',
	                url: "${pageContext.request.contextPath}/admin/checkedEnrollAction.do",
	                data: {
	                    selectedStudent : jsonIds,
	                    cidx : cidx
	                },
	                success: function (data) {
	                	alert("해당 학생들의 등록이 완료되었습니다");
	                	document.location.href = document.location.href;
	                	
	                },
	                error: function (error) {
	                    console.error(error);
	                }
	            });
            }
        });

    });
    
    // 등록 버튼 이벤트
    function courseAccept(sidx,cidx){
    	let confirmation = confirm("해당 학생을 등록하겠습니까?"); // 확인 창 표시
        if (confirmation) {
            $.ajax({
                type: 'POST',
                url: "${pageContext.request.contextPath}/admin/EnrollAction.do",
                data: {
                    "sidx": sidx,
                    "cidx": cidx
                },
                success: function(data) {
                	alert("해당 학생의 등록이 완료되었습니다");
                	document.location.href = document.location.href;
                	
                	
                },	
                error: function(error) {
                	 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            });
        }

    }
    
    
    // 강의등록 리스트
    // 해당 년도, 학기에 관련된 리스트만.
    function courseRegisterList(year, term) {
        //alert("통신 시도");
        $.ajax({
            type: 'POST',
            url: "${pageContext.request.contextPath}/admin/courseRegisterList.do",
            data: {
                "year": year,
                "term": term
            },
            success: function(data) {
            	//alert("통신 확인");
            	courseList(data);	//수강등록 리스트 테이블 불러오기
            	
            },	
            error: function(error) {
            	 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    }
    
    //수강등록 리스트 테이블
    function courseList(data){
    	let parsedData = JSON.parse("["+data+"]");
    	let str="";		
    	parsedData.forEach(function (item){
    	
    		str += "<tr data-id='" + item.cidx + "'><td>" + item.cidx + "</td>" +
    			"<td class='course-name'>" + item.c_name + "</td>" +
    			"<td>" + item.p_no + "</td>" +
    			"<td>" + item.p_name + "</td>" +
    			"<td class='major-name'>" + item.c_major + "</td>" +
    			"<td class='grade'>" + item.c_grade + "</td>" +
    			"<td>" + item.c_sep + "</td>" +
    			"<td>" + item.c_score + "</td>" +
    			"<td>" + item.ct_room + "</td>" +
    			"<td>" + item.c_times + "</td></tr>";	
    			
    	});
    	
    	$("#courseList tbody").html(str);	// 수강리스트 tbody 부분에 입력
    	$('#studentList').hide();	// 수강등록 리스트 테이블가 나오기 전에 보이면 안됌. hide로 숨겨놓음
    	
    	// 해당 수강에 등록해야할 학생들 리스트
	
       	$(".course-name").click(function () {
    		//alert("확인");
    		let cidx = $(this).closest('tr').data('id');
    		let c_name = $(this).closest('tr').find('.course-name').text();
    		let c_major = $(this).closest('tr').find('.major-name').text();
    		let c_grade = $(this).closest('tr').find('.grade').text();
    		
            $.ajax({
                type: 'POST',
                url: "${pageContext.request.contextPath}/admin/courseMatchStudent.do",
                data: {
                	"cidx": cidx,
                	"c_major": c_major,
                	"c_grade": c_grade
                },
                success: function(data) {
                	//alert("통신 확인");
                	$("#studentList h4").text(c_name);	//학생 리스트 h4에 불러온 과목명 입력
                	courseMatchStudent(data, cidx);	//학생들 리스트 정보와 함께 cidx값도 같이 넘기기
                	
                	
                },
                error: function(error) {
                	 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            });
        });
       	
       	return;
    }
    
    // 학생들 리스트 테이블
    function courseMatchStudent(data, cidx){
    	
    	//console.log("해당 courseId 값"+courseId);
    	let parsedData = JSON.parse("["+data+"]");
    	let str="";
    	
    	parsedData.forEach(function (item, index){
    		let acceptBtn= "<button type='button' id='btn' onclick='courseAccept("+item.sidx+","+cidx+");'>등록</button>";
    		let autoIncrementNumber = index + 1;	//인덱스 자동증가
    		
    		str += "<tr><td><input type='checkbox' name='studentCheckbox' value="+item.sidx+"></td>" +
    	 		"<td>" + autoIncrementNumber + "</td>" +
    	 		"<td>" + item.s_name + "</td>" +  
    	 		"<td>" + item.s_no + "</td>" +
    	 		"<td>" + item.s_grade + "</td>" +
    	 		"<td>" + item.s_major + "</td>" +
    	 		"<td>" + acceptBtn +"</td></tr>";			
    	});
    	
    	$("#batchBtn").val(cidx);
    	$("#studentList tbody").html(str);	// 학생리스트 tbody 부분에 입력
    	$('#studentList').show();	// <div id="studentList"> 학생 테이블 표 활성화
    	
    	
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
							  <div aria-current="false" class="menuitemin" style="font-weight: bold"><a href="../admin/courseEnroll.do" target="_parent">수강등록</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../admin/openDate.do" target="_parent">개강일자등록</a></div>
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
		    	<iframe src = "../leftmenu/myinfo_a.jsp" width="100%" height="100"></iframe>
		    </div>
		    <div class="menubar">
		    	<iframe src = "../leftmenu/courseEnroll_a.jsp" width="100%" height="100%"></iframe>
		    </div>
       	</div>
        <div class="contents">
            <h3>강의 리스트</h3>
            <div class="first_line">
               년도 <input type="number" id="yearInput" name="yearInput" disabled/>
               학기 <input type="number" id="termInput" name="termInput" disabled/>
            </div>
            <div id="courseList" class="list_table">
               <table>
                   <thead>
                       <tr>
                           <td style="width:30px">과목번호</td>
                           <td style="width:100px">과목명</td>
                           <td style="width:10px">교수번호</td>
                           <td style="width:30px">교수이름</td>
                           <td style="width:80px">전공</td>
                           <td style="width:30px">수강학년</td>
                           <td style="width:30px">이수구분</td>
                           <td style="width:30px">학점</td>
                           <td style="width:50px">강의실</td>
                           <td style="width:50px">시간표</td>
                          
                       </tr>
                   </thead>	
                   <tbody>
					<!-- courseList tbody부분 -->
                   </tbody>
               </table>
            </div>
            <br>
            <div id="studentList">
            <h4></h4>
                <div class="first_line">
                    <button type="button" id="batchBtn" style="cursor: pointer" value="">일괄 등록</button>
                </div>
                <div class="list_table">
	                <table>
	                    <thead>
	                        <tr>
	                            <td style="width: 30px;">
                                    <input type="checkbox" name="studentSelectAll" id="studentSelectAll" />
                                </td>
	                            <td style="width: 30px">순번</td>
	                            <td style="width: 100px">이름</td>
	                            <td style="width: 120px">학번</td>
	                            <td style="width: 40px">학년</td>
	                            <td style="width: 180px">학과</td>
	                            <td style="width: 40px">처리</td>
	                        </tr>
	                    </thead>
	                    <tbody>
		                	<!-- studentList tbody부분 -->
	                    </tbody>
	                </table>
                </div> 
            </div>
        </div>
    </div>
</body>
</html>