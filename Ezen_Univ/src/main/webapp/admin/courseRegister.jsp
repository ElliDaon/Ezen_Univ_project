<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강의등록</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="../css/iframe.css">
    <link rel="stylesheet" href="../css/admin.css">
    <link rel="stylesheet" href="../css/nav_style.css">

    <script>
    $(document).ready(function(){
        // 현재 날짜를 가져와서 input에 설정
        let currentDate = new Date();
        let year = currentDate.getFullYear();
        
        let month = currentDate.getMonth() + 1;
        let term = (month >= 2 && month <= 7) ? 1 : 2;
        
        $('#yearInput').val(year);
        $('#termInput').val(term);
        courseRegisterList(year, term);
        
        // 화면 컨트롤
        
        $('#courseListInput').hide();
        $('#courseTimeListInput').hide();
        
        $('#registerBtn').on('click', function() {
            $('#courseListInput').show();
        });
        
        
        // 다음 버튼 눌렀을 시 교수번호와 교수이름 교차검증. 이후 다음 화면을 보여줌.
        
        $('#nextBtn').on('click', function() {
        	//alert("확인");
        	let p_no = $("input[list='professorNumber-options']").val();
        	let p_name = $("input[list='courseprofessor-options']").val();
        	
            if(p_no ===""){
            	alert("교수번호를 입력하세요");
            	return;
            }else if(p_name ===""){
            	alert("교수이름을 입력하세요");
            	return;
            }
        	
              $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/admin/professorVerification.do",
                dataType: "json",
                data: {
                    "p_no": p_no,
                    "p_name": p_name
                },
                cache: false,
                success: function (data) {
                	if(data.value==1){
                		$('#courseListInput').hide();
                        $('#courseTimeListInput').show();
                	}else{
                		alert("해당 교수번호와 이름이 서로 맞지 않습니다.");
                	}
                },
                error: function () {
                    alert("통신오류 실패");
                }
            });  
        	 
        });
        
        $('#previousBtn').on('click', function() {
            $('#courseTimeListInput').hide();
            $('#courseListInput').show();
        });
        
        //테이블 행추가
             
        $("#addRow").on("click", function() {
            let courseroomValue = $("input[name='ct_room']").val();
            let weekValue = $("input[list='courseweek-options']").val();
            let periodValue = $("input[name='pe_period']:checked").val();
            let semesterValue = $("input[list='semester-options']").val();
            let yearValue = $("input[list='year-options']").val();

            
            if(courseroomValue ===""){
            	alert("강의실을 입력하세요");
            	return;
            }else if(weekValue ===""){
            	alert("요일을 입력하세요");
            	return;
            }else if(semesterValue ===""){
            	alert("학기를 입력하세요");
            	return;
            }else if(yearValue ===""){
            	alert("년도를 입력하세요");
            	return;
            }
            
            // 해당 강의실과 시간이 겹치지 않으면 테이블 행 추가
            
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/admin/courseTimeVerification.do",
                dataType: "json",
                data: {
                	"courseroomValue": courseroomValue,
                	"weekValue": weekValue,
                    "periodValue": periodValue,
                    "semesterValue": semesterValue,
                    "yearValue": yearValue
                },
                cache: false,
                success: function (data) {
                	if(data.cnt==0){
						
                        let cells = $("#myTable td");
                        let allCellsFilled = true;

                        cells.each(function() {
                            if ($(this).text() === "" || $(this).html() === "&nbsp;") {
                                $(this).text(courseroomValue);
                                $(this).next().text(weekValue);
                                $(this).next().next().text(periodValue);
                                $(this).next().next().next().text(semesterValue);
                                $(this).next().next().next().next().text(yearValue);
                                allCellsFilled = false;
                                return false; // loop 종료
                            }
                        });

                        if (allCellsFilled) {
                            // 새로운 행 추가
                            let newRow = "<tr><td>" + courseroomValue + "</td>" +
            						"<td>" + weekValue + "</td>" +
                            		"<td>" + periodValue + "</td>" +
                            		"<td>" + semesterValue + "</td>" +
                            		"<td>" + yearValue + "</td>" +
                            		"<td><button class='deleteRow'>Delete</button></td></tr>";
                            $("#myTable").append(newRow);
                        }

                        // 입력값 초기화
                        $("input[list='courseweek-options']").val("");

                        // 버튼을 행의 마지막 셀에 추가
                        $("#myTable tr").each(function() {
                            if ($(this).find("td").length > 0) {
                                let lastCell = $(this).find("td").last();
                                if (lastCell.find(".deleteRow").length === 0) {
                                    lastCell.append('<button class="deleteRow">Delete</button>');
                                }
                            }
                        });
                		
                	}else{
                		alert("해당 장소와 시간에 등록된 정보가 있습니다.");
                	}
                },
                error: function () {
                    alert("통신오류 실패");
                }
            }); 
            
                      
        });
        
        
		// 행삭제 버튼
        $("#myTable").on("click", ".deleteRow", function() {
            $(this).closest("tr").remove();
            
        });
   		
   		
		// 강의등록 조회버튼 시 교수번호와 교수이름 가져오는 펑션
        $('#registerView').on('click', function() {
            //alert("확인");
            let c_major = $('#c_major').val();

            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/admin/registerView.do",
                data: {
                    "c_major": c_major
                },
                dataType: "json",
                cache: false,
                success: function(data) {
                    let professorNumberOption = $("#professorNumber-options");
                    let professorNameOption = $("#courseprofessor-options");

                    // 기존 datalist 비우기
                    professorNumberOption.empty();
                    professorNameOption.empty();

                    // JSON 데이터를 datalist에 추가
                    $.each(data, function(index, item) {
                        let NumberOption = $("<option>").attr("value", item.p_no);
                        let NameOption = $("<option>").attr("value", item.p_name);
                        professorNumberOption.append(NumberOption);
                        professorNameOption.append(NameOption);
                    });
                },
                error: function(request, status, error) {
                    alert("통신오류 실패");
                    alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            });
        });
  
    });
	
    // 강의등록 리스트 
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
            	courseList(data);
            	
            },	
            error: function(error) {
            	 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    }
    
    //강의등록 삭제
    function courseDel(cidx) {
        let confirmation = confirm("삭제하시겠습니까?"); // 확인 창 표시
        if (confirmation) {
            $.ajax({
                type: "get",
                url: "${pageContext.request.contextPath}/admin/courseDelete.do?cidx="+cidx,
                dataType: "json",
                cache: false,
                success: function (data) {
                    document.location.href = document.location.href;
                },
                error: function () {
                    alert("통신오류 실패");
                }
            });
        }
    }
    
    //강의등록 리스트 테이블
    function courseList(data){
    	let parsedData = JSON.parse("["+data+"]");
    	let str="";		
    	parsedData.forEach(function (item){
    		let delBtn= "<button type='button' id='btn2' onclick='courseDel("+item.cidx+");'>삭제</button>";
    		str = str + "<tr><td>"+item.cidx+"</td>" +
			"<td>"+item.c_name+"</td>" +
    		"<td>"+item.p_no+"</td>" +
    		"<td>"+item.p_name+"</td>" +
    		"<td>"+item.c_major+"</td>" +
    		"<td>"+item.c_grade+"</td>" +
    		"<td>"+item.c_sep+"</td>" +
    		"<td>"+item.c_score+"</td>" +
    		"<td>"+item.ct_room+"</td>" +
    		"<td>"+item.c_times+"</td>" +
    		"<td>"+delBtn+"</td></tr>";
    			
    	});
    	
    	$("#courseList tbody").html(str);
    	
    	return;
    }
    
    function check(){    	    	
		let fm = document.frm; //문서객체안의 폼객체이름
	
		if(fm.c_name.value ==""){
			alert("과목명을 입력하세요");
			return;
		}else if (fm.c_major.value ==""){
			alert("전공을 입력하세요");
			return;		
		}else if (fm.c_sep.value ==""){
			alert("이수구분을 입력하세요");
			return;		
		}else if (fm.p_no.value ==""){
			alert("교수번호을 입력하세요");
			return;		
		}else if (fm.c_grade.value ==""){
			alert("수강학년을 입력하세요");
			return;		
		}else if (fm.p_name.value ==""){
			alert("교수이름을 입력하세요");
			return;		
		}else if (fm.c_score.value ==""){
			alert("학점을 입력하세요");
			return;
		}else if (fm.c_totaltime.value ==""){
			alert("총강의시간을 입력하세요");
			return;
		}
		
		let tableData = [];
		
		$("#myTable tr:gt(0)").each(function () {
		    let rowData = $(this).find("td");
		    
		    // 빈 값 체크
		    if ($(rowData).filter(':empty').length > 0) {
		        alert("시간표를 입력하지 않았습니다.");
		        // 반복을 끝내고 함수를 종료
		        return false;
		    }

		    let courseDetails = {    
		        room: $(rowData[0]).text(),
		        day: $(rowData[1]).text(),
		        period: $(rowData[2]).text(),
		        semester: $(rowData[3]).text(),
		        year: $(rowData[4]).text()
		    };
		    tableData.push(courseDetails);
		});
	    
  
	    fm.action = "<%=request.getContextPath()%>/admin/courseRegisterAction.do";
	    fm.method = "post";
	    let tableInput = $("<input>")
	        .attr("type", "hidden")
	        .attr("name", "tableData")
	        .val(JSON.stringify(tableData));
	     
	    $(fm).append(tableInput);
	    fm.submit();
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
							  <div aria-current="false" class="menuitemin" style="font-weight: bold"><a href="../admin/courseRegister.do" target="_parent">강의등록</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../admin/courseEnroll.do" target="_parent">수강등록</a></div>
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
                <iframe src = "../leftmenu/courseRegister_a.jsp" width="100%" height="700"></iframe>
            </div>
        </div>
        <div class="contents">
             <h3>강의등록현황</h3>
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
                            <td style="width:20px">교수번호</td>
                            <td style="width:30px">교수이름</td>
                            <td style="width:80px">전공</td>
                            <td style="width:30px">수강학년</td>
                            <td style="width:30px">이수구분</td>
                            <td style="width:30px">학점</td>
                            <td style="width:50px">강의실</td>
                            <td style="width:50px">시간표</td>
                            <td style="width:15px">처리</td>
                        </tr>
                    </thead>
                    <tbody>
						<!-- courseList tbody부분 -->
                    </tbody>
                </table>
             </div>
            <br>
            <div align="right">
            	<input type="button" name="btn" id="registerBtn" value="강의 등록하기" style="width:120px";>
            </div>
		<form name="frm">
			<div id =courseListInput>
			<h3>강의등록</h3>
			<br>
			<table id="registerTable" class="register" style="width:100%">
				<tr>
					<td align="center" width="15%">과목명</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="c_name" value="" Placeholder="이곳에 직접 입력하세요" autocomplete="off"/>
					</td>
					<td align="center" width="15%">전공</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="c_major" id="c_major" list="major-options" autocomplete="off"/>
						<datalist id="major-options">
							<option value="건축학과" />
							<option value="경제학과" />
							<option value="경영학과" />
							<option value="정보통신공학과" />
							<option value="기계공학과" />
							<option value="기계설계공학부" />
							<option value="기계시스템공학부" />
							<option value="도시공학과" />
							<option value="바이오메디컬공학부" />
						</datalist>
						&ensp;
						<input type="button" name="btn" value="조회" id="registerView">
		            </td>
				</tr>
				<tr>
					<td align="center">이수구분</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="c_sep" list="seperation-options" autocomplete="off"/>
						<datalist id="seperation-options">
							<option value="교양선택" />
							<option value="교양필수" />
							<option value="전공선택" />
							<option value="전공필수" />
						</datalist>
					</td>
		            <td align="center">교수번호</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="p_no" list="professorNumber-options" Placeholder="전공조회시 목록선택" autocomplete="off"/>
						<datalist id="professorNumber-options">
						</datalist>
		            </td>
				<tr>
					<td align="center">수강학년</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="c_grade" list="grade-options" autocomplete="off"/>
						<datalist id="grade-options">
							<option value="1" />
							<option value="2" />
							<option value="3" />
							<option value="4" />
					</datalist>
					</td>
					<td align="center">담당교수</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="p_name" list="courseprofessor-options" Placeholder="전공조회시 목록선택" autocomplete="off"/>
						<datalist id="courseprofessor-options">
						</datalist>
		            </td>
				</tr>
				<tr>
					<td align="center">학점</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="c_score" list="score-options" autocomplete="off"/>
						<datalist id="score-options">
							<option value="1" />
							<option value="2" />
							<option value="3" />
						</datalist>
					</td>
					<td align="center">총강의시간</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="c_totaltime" list="totalTime-options" autocomplete="off"/>
						<datalist id="totalTime-options">
							<option value="32" />
							<option value="48" />
						</datalist>
					</td>
				</tr>
			</table>	
				<div align="center">
					<input type="button" name="btn" id="nextBtn" value="다음">
				</div>
			</div>
		</form>
			<div id="courseTimeListInput">
			<h3>강의등록-시간표</h3>
			<br>
			<table id="studentTable" class="register" style="width:100%" >
				<tr>
					<th data-key="room">강의실</th>
					<th data-key="day">요일</th>
					<th data-key="period">교시</th>
					<th data-key="semester">학기</th>
					<th data-key="year">년도</th>
					<th>처리</th>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
			<br>
			<table id="registerTable2" class="register" style="width:100%">
			<tr>	
				<td align="center" style="width:5%">강의실</td>
				<td style="padding: 0px 0px 0px 15px; width:12%;">
					<input type="text" name="ct_room" value="" Placeholder="이곳에 직접 입력하세요" autocomplete="off"/>
				</td>
				<td align="center" style="width:5%">요일</td>
				<td style="padding: 0px 0px 0px 15px; width:12%;">
					<input type="text" name="ct_week" list="courseweek-options" autocomplete="off"/>
					<datalist id="courseweek-options">
						<option value="월" />
						<option value="화" />
						<option value="수" />
						<option value="목" />
						<option value="금" />
						<option value="토" />
					</datalist>
				</td>
				<td align="center" style="width:5%">교시</td>
				<td style="padding: 0px 0px 0px 30px; width:25%;">
					<label for="1교시"><input type="radio" id="1period" name="pe_period" value=1 checked> 1교시</label>&emsp;
					<label for="2교시"><input type="radio" id="2period" name="pe_period" value=2> 2교시</label>&emsp;
					<label for="3교시"><input type="radio" id="3period" name="pe_period" value=3> 3교시</label>&emsp;
					<br>
					<label for="4교시"><input type="radio" id="4period" name="pe_period" value=4> 4교시</label>&emsp;
					<label for="5교시"><input type="radio" id="5period" name="pe_period" value=5> 5교시</label>&emsp;
					<label for="6교시"><input type="radio" id="6period" name="pe_period" value=6> 6교시</label>&emsp;
					<br>
					<label for="7교시"><input type="radio" id="7period" name="pe_period" value=7> 7교시</label>&emsp;
					<label for="8교시"><input type="radio" id="8period" name="pe_period" value=8> 8교시</label>&emsp;
					<label for="9교시"><input type="radio" id="9period" name="pe_period" value=9> 9교시</label>&emsp;
				</td>
				<td align="center" style="width:5%">학기</td>
				<td style="padding: 0px 0px 0px 30px; width:12%;">
					<input type="text" name="ct_semester" list="semester-options" />
					<datalist id="semester-options">
						<option value="1" />
						<option value="2" />
					</datalist>
				</td>
				<td align="center" style="width:5%">년도</td>
				<td style="padding: 0px 0px 0px 30px; width:12%;">
					<input type="text" name="ct_year" list="year-options" />
					<datalist id="year-options">
						<option value="2023" />
						<option value="2024" />
						<option value="2025" />
						<option value="2026" />
						<option value="2027" />
						<option value="2028" />
						<option value="2029" />
						<option value="2030" />
						<option value="2031" />
					</datalist>
				</td>
			</tr>
			</table>	
				<div align="right">
					<input type="button" name="btn" id="addRow" value="추가" >
				</div>
			<div align="center">
				<input type="button" name="btn" id="previousBtn" value="이전">
				<input type="button" name="btn" value="등록" onclick="check();">
			</div>
			</div>
         </div>

      </div>
</body>
</html>
