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
   <link rel="stylesheet" href="../css/courseRegister.css">
    <style>
        .container{
            display: flex;
        }
        .sidebar{
            width: 50%;
        }
        .myinfo{
            width: 100%;
        }
        .menubar{
            width: 100%;
        }
        .contents{
            padding: 20px;
        }
        
    </style>
    <script>
    $(document).ready(function(){
        // 현재 날짜를 가져와서 input에 설정
        var currentDate = new Date();
        var year = currentDate.getFullYear();
        
        var month = currentDate.getMonth() + 1;
        var term = (month >= 3 && month <= 8) ? 1 : 2;
        
        $('#yearInput').val(year);
        $('#termInput').val(term);
        courseRegisterList(year, term);
        
        // 화면 컨트롤
        
        $('#courseList1').hide();
        $('#courseList2').hide();
        
        $('#registerBtn').on('click', function() {
            $('#courseList1').show();
        });
        
        $('#nextBtn').on('click', function() {
            $('#courseList1').hide();
            $('#courseList2').show();
        });
        
        $('#previousBtn').on('click', function() {
            $('#courseList2').hide();
            $('#courseList1').show();
        });
        
        //테이블 행추가
             
        $("#addRow").on("click", function() {
            var courseroomValue = $("input[name='ct_room']").val();
            var weekValue = $("input[list='courseweek-options']").val();
            var periodValue = $("input[name='pe_period']:checked").val();

            var cells = $("#myTable td");
            var allCellsFilled = true;

            cells.each(function() {
                if ($(this).text() === "" || $(this).html() === "&nbsp;") {
                    $(this).text(courseroomValue);
                    $(this).next().text(weekValue);
                    $(this).next().next().text(periodValue);
                    allCellsFilled = false;
                    return false; // loop 종료
                }
            });

            if (allCellsFilled) {
                // 새로운 행 추가
                var newRow = "<tr><td>" + courseroomValue + "</td><td>" + weekValue + "</td><td>" + periodValue + "</td><td><button class='deleteRow'>Delete</button></td></tr>";
                $("#myTable").append(newRow);
            }

            // 입력값 초기화
            $("input[list='courseweek-options']").val("");
            $("input[name='period']").prop('checked', false);

            // 버튼을 행의 마지막 셀에 추가
            $("#myTable tr").each(function() {
                if ($(this).find("td").length > 0) {
                    var lastCell = $(this).find("td").last();
                    if (lastCell.find(".deleteRow").length === 0) {
                        lastCell.append('<button class="deleteRow">Delete</button>');
                    }
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
            var c_major = $('#c_major').val();

            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/admin/registerView.do",
                data: {
                    "c_major": c_major
                },
                dataType: "json",
                cache: false,
                success: function(data) {
                    var professorNumberOption = $("#professorNumber-options");
                    var professorNameOption = $("#courseprofessor-options");

                    // 기존 datalist 비우기
                    professorNumberOption.empty();
                    professorNameOption.empty();

                    // JSON 데이터를 datalist에 추가
                    $.each(data, function(index, item) {
                        var NumberOption = $("<option>").attr("value", item.p_no);
                        var NameOption = $("<option>").attr("value", item.p_name);
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
        var confirmation = confirm("삭제하시겠습니까?"); // 확인 창 표시
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
    	var parsedData = JSON.parse("["+data+"]");
    	var str="";		
    	parsedData.forEach(function (item){
    		var delBtn= "<button type='button' id='btn' onclick='courseDel("+item.cidx+");'>삭제</button>";
    		str = str + "<tr><td>"+item.cidx+"</td><td>"+item.c_name+"</td><td>"+item.p_no+"</td><td>"+item.p_name+"</td><td>"+item.c_major+"</td><td>"+item.c_grade+"</td><td>"+item.c_sep+"</td><td>"+item.c_score+"</td><td>"+item.ct_room+"</td><td>"+item.c_times+"</td><td>"+delBtn+"</td></tr>"	
    			
    	});
    	
    	$("#courseList tbody").html(str);
    	
    	return;
    }
    

    </script>
    
    
    <script>
    function check(){

	var fm = document.frm; //문서객체안의 폼객체이름

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
	}else{
		//취미체크 확인함수(취미는 값이 여러개라 memberHobby배열로 담는다)
		var tf = checkYn(fm.memberHobby);
		if(tf==false){
			return;  //결과값이 거짓이면 진행막기
		}
	}
	
<%-- 	fm.action ="<%=request.getContextPath()%>/member/memberJoinAction.do";  //처리하기위해 이동하는 주소
	fm.method = "post";  //이동하는 방식  get 노출시킴 post 감추어서 전달
	fm.submit(); //전송시킴 --%>
	return;
}
	</script>
</head>
<body>
    <div class="header">
        <iframe src = "../main/navigation_a.jsp" width = "100%" height="55" ></iframe>
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
                년도 <input type="number" id="yearInput" name="yearInput" min="1900" max="2099" placeholder="YYYY" required disabled/>
                학기 <input type="number" id="termInput" name="termInput" min="1" max="2" required disabled/>
             </div>
             <div id="courseList" class="list_table">
                <table>
                    <thead>
                        <tr>
                            <td style="width:30px">과목번호</td>
                            <td style="width:80px">과목명</td>
                            <td style="width:10px">교수번호</td>
                            <td style="width:30px">교수이름</td>
                            <td style="width:80px">전공</td>
                            <td style="width:30px">수강학년</td>
                            <td style="width:30px">이수구분</td>
                            <td style="width:30px">학점</td>
                            <td style="width:50px">강의실</td>
                            <td style="width:50px">시간표</td>
                            <td style="width:15px">삭제</td>
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
			<div id =courseList1>
			<h3>강의등록</h3>
			<table class="register" style="width:100%">
				<tr>
					<td align="center" width="15%">과목명</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="c_name" value="" Placeholder="이곳에 직접 입력하세요">
					</td>
					<td align="center" width="15%">전공</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="c_major" id="c_major" list="major-options" />
						<datalist id="major-options">
							<option value="건축공학과" />
							<option value="고분자나노공학과" />
							<option value="유기소재섬유공학과" />
							<option value="기계공학과" />
							<option value="기계설계공학부" />
							<option value="기계시스템공학부" />
							<option value="도시공학과" />
							<option value="바이오메디컬공학부" />
							<option value="산업정보시스템공학과" />
							<option value="소프트웨어공학과" />
							<option value="신소재공학부" />
							<option value="전기공학과" />
							<option value="전자공학과" />
							<option value="정보통신공학과" />
							<option value="컴퓨터인공지능학부" />
							<option value="토목환경자원에너지공학부" />
							<option value="항공우주공학" />
							<option value="화학공학과" />
						</datalist>
						&ensp;
						<input type="button" name="btn" value="조회" id="registerView">
		            </td>
				</tr>
				<tr>
					<td align="center">이수구분</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="c_sep" list="seperation-options" />
						<datalist id="seperation-options">
							<option value="교양선택" />
							<option value="교양필수" />
							<option value="전공선택" />
							<option value="전공필수" />
						</datalist>
					</td>
		            <td align="center">교수번호</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="p_no" list="professorNumber-options" Placeholder="전공조회시 목록선택"/>
						<datalist id="professorNumber-options">
						</datalist>
		            </td>
				<tr>
					<td align="center">수강학년</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="c_grade" list="grade-options" />
						<datalist id="grade-options">
							<option value="1" />
							<option value="2" />
							<option value="3" />
							<option value="4" />
					</datalist>
					</td>
					<td align="center">담당교수</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="p_name" list="courseprofessor-options" Placeholder="전공조회시 목록선택"/>
						<datalist id="courseprofessor-options">
						</datalist>
		            </td>
				</tr>
				<tr>
					<td align="center">학점</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="c_score" list="score-options" />
						<datalist id="score-options">
							<option value="1" />
							<option value="2" />
							<option value="3" />
						</datalist>
					</td>
					<td align="center">총강의시간</td>
					<td style="padding: 0px 0px 0px 15px; width:35%;">
						<input type="text" name="c_totaltime" list="totalTime-options" />
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
			
			<div id="courseList2">
			<h3>강의등록</h3>
			<table id="myTable" class="register" style="width:100%" >
				<tr>
					<th>강의실</th>
					<th>요일</th>
					<th>시간</th>
					<th>삭제</th>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
			<table class="register" style="width:100%">
			<tr>	
				<td align="center">강의실</td>
				<td style="padding: 0px 0px 0px 15px; width:25%;">
					<input type="text" name="ct_room" value="" Placeholder="이곳에 직접 입력하세요">
				</td>
				<td align="center">요일</td>
				<td style="padding: 0px 0px 0px 15px; width:20%;">
					<input type="text" name="ct_week" list="courseweek-options" />
					<datalist id="courseweek-options">
						<option value="월" />
						<option value="화" />
						<option value="수" />
						<option value="목" />
						<option value="금" />
						<option value="토" />
					</datalist>
				</td>
				<td align="center">교시</td>
				<td style="padding: 0px 0px 0px 30px; width:35%;">
					<label for="1교시"><input type="radio" id="1period" name="pe_period" value=1> 1교시</label>&emsp;
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
			</tr>
			</table>	
				<div align="right">
					<input type="button" name="btn" id="addRow" value="추가">
				</div>
			<div align="center">
				<input type="button" name="btn" id="previousBtn" value="이전">
				<input type="button" name="btn" value="등록" onclick="check();">
			</div>
			</div>
		</form>
         </div>

      </div>
</body>
</html>
