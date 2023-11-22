<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>가입승인</title>    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="../css/iframe.css">
    <link rel="stylesheet" href="../css/admin.css">
    <link rel="stylesheet" href="../css/nav_style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        $(document).ready(function() {
        	// 새로고침되도 기존 라디오버튼 값 로컬스토리에 저장해서 불러오기
        	// and 새로고침 되도 해당 회원목록 유지하기
        	
            // 로컬 스토리지에서 "selectedMember" 값을 가져오기
            const selectedMember = localStorage.getItem('selectedMember');

            // 로컬 스토리지에서 "isStudentChecked" 값을 가져오기
            const isStudentChecked = localStorage.getItem('isStudentChecked') === 'true';

            // 로컬 스토리지에서 "isProfessorChecked" 값을 가져오기
            const isProfessorChecked = localStorage.getItem('isProfessorChecked') === 'true';

            
            // "selectedMember" 값에 따라 처음 화면 목록 설정
            if (selectedMember === 'professorAll') {
                $('#studentAllList').hide();
                $('#studentCheckedBtn').hide();
                $('#professorAllList').show();
                $('#professorCheckedBtn').show();
            } else {
                $('#professorAllList').hide();
                $('#professorCheckedBtn').hide();
                $('#studentAllList').show();
                $('#studentCheckedBtn').show();
            }

            // 라디오 버튼 체크 상태 설정
            $('#studentRadio').prop('checked', !isProfessorChecked);
            $('#professorRadio').prop('checked', isProfessorChecked);

            // 라디오 버튼 변경 이벤트 핸들러
            $('input[name="MemberList"]').on('change', function() {
                const selectedValue = $("input[name='MemberList']:checked").val();
                
                if (selectedValue === 'studentAll') {
                    localStorage.setItem('isStudentChecked', 'true');
                    localStorage.setItem('isProfessorChecked', 'false');
                } else {
                    localStorage.setItem('isStudentChecked', 'false');
                    localStorage.setItem('isProfessorChecked', 'true');
                }
            });

            // "선택보기" 버튼 클릭 이벤트 핸들러
            $("#view").on("click", function() {
                const selectedValue = $("input[name='MemberList']:checked").val();

                // 상태를 로컬 스토리지에 저장
                localStorage.setItem('selectedMember', selectedValue);

                // 목록보기 설정
                if (selectedValue === 'studentAll') {
                    $('#professorAllList').hide();
                    $('#professorCheckedBtn').hide();
                    $('#studentAllList').show();
                    $('#studentCheckedBtn').show();
                    $('#professorAllList input[type="checkbox"]').prop('checked', false);
                } else {
                    $('#studentAllList').hide();
                    $('#studentCheckedBtn').hide();
                    $('#professorAllList').show();
                    $('#professorCheckedBtn').show();
                    $('#studentAllList input[type="checkbox"]').prop('checked', false);
                }

            });
            
			// 학생 전체 클릭 체크박스
            $("#studentSelectAll").on("change", function() {
                let isChecked = $(this).prop("checked");
                $("[name='student']").prop("checked", isChecked);
            });
			// 교수 전체 클릭 체크박스
            $("#professorSelectAll").on("change", function() {
                let isChecked = $(this).prop("checked");
                $("[name='professor']").prop("checked", isChecked);
            });
			
	        // 학생 일괄승인 버튼 클릭 이벤트
            $('#submitButton1').on('click', function(event) {
                let confirmation = confirm("일괄승인하겠습니까?"); // 확인 창 표시
                if (confirmation) {
	                let newAction = '${pageContext.request.contextPath}/admin/acceptStudentAllOk.do';
	                $('#studentAccept').prop('action', newAction); 
	                $('#studentAccept').submit(); // 폼 제출
                }
            });
            // 학생 일괄거부 버튼 클릭 이벤트
            $('#submitButton2').on('click', function(event) {
                let confirmation = confirm("일괄거부하겠습니까?"); // 확인 창 표시
                if (confirmation) {
	                let newAction = '${pageContext.request.contextPath}/admin/acceptStudentAllNo.do';
	                $('#studentAccept').prop('action', newAction); 
	                $('#studentAccept').submit(); // 폼 제출
                }
            });
	        // 교수 일괄승인 버튼 클릭 이벤트
            $('#submitButton3').on('click', function(event) {
                let confirmation = confirm("일괄승인하겠습니까?"); // 확인 창 표시
                if (confirmation) {
	                let newAction = '${pageContext.request.contextPath}/admin/acceptProfessorAllOk.do';
	                $('#professorAccept').prop('action', newAction);
	                $('#professorAccept').submit(); // 폼 제출
                }
            });
            // 교수 일괄거부 버튼 클릭 이벤트
            $('#submitButton4').on('click', function(event) {
                let confirmation = confirm("일괄거부하겠습니까?"); // 확인 창 표시
                if (confirmation) {
	                let newAction = '${pageContext.request.contextPath}/admin/acceptProfessorAllNo.do';
	                $('#professorAccept').prop('action', newAction);
	                $('#professorAccept').submit(); // 폼 제출
                }
            });

        });
	     function acceptStudentOk(sidx){
	         let confirmation = confirm("해당 학생의 회원가입을 승인하겠습니까?"); // 확인 창 표시
	         if (confirmation) {
		    	// 학생 회원가입 승인
		     	$.ajax({
		    		type : "post",
		    		url : "${pageContext.request.contextPath}/admin/acceptStudentOk.do?sidx="+sidx,
		    		data:{"sidx":sidx},
		    		dataType : "json",
		    		cache : false,
		    		success : function(data){
		    			//alert("통신성공");
		    			document.location.href = document.location.href;		
		    			
		    		},
		    		error : function(){
		    			alert("통신오류 실패");			
		    		}		
		    	});	 
	    	}
	     }
	     function acceptProfessorOk(pidx){
	         let confirmation = confirm("해당 교수의 회원가입을 승인하겠습니까?"); // 확인 창 표시
	         if (confirmation) {
	    		// 교수 회원가입 승인
		     	$.ajax({
		     		type : "post",
		     		url : "${pageContext.request.contextPath}/admin/acceptProfessorOk.do?pidx="+pidx,
		     		data:{"pidx":pidx},
		     		dataType : "json",
		     		cache : false,
		     		success : function(data){
		     			//alert("통신성공");
		     			document.location.href = document.location.href;		
		     			
		     		},
		     		error : function(){
		     			alert("통신오류 실패");			
		     		}		
		     	});	
	     	}
	     }
	     function acceptStudentNo(sidx){
	         let confirmation = confirm("해당 학생의 회원가입을 거부하겠습니까?"); // 확인 창 표시
	         if (confirmation) {
	     		// 학생 회원가입 거부
		      	$.ajax({
		     		type : "post",
		     		url : "${pageContext.request.contextPath}/admin/acceptStudentNo.do?sidx="+sidx,
		     		data:{"sidx":sidx},
		     		dataType : "json",
		     		cache : false,
		     		success : function(data){
		     			//alert("통신성공");
		     			document.location.href = document.location.href;		
		     			
		     		},
		     		error : function(){
		     			alert("통신오류 실패");			
		     		}		
		     	});	 
	     	}
	     }
	     function acceptProfessorNo(pidx){
	         let confirmation = confirm("해당 교수의 회원가입을 거부하겠습니까?"); // 확인 창 표시
	         if (confirmation) {
		     	// 교수 회원가입 거부
		      	$.ajax({
		      		type : "post",
		      		url : "${pageContext.request.contextPath}/admin/acceptProfessorNo.do?pidx="+pidx,
		      		data:{"pidx":pidx},
		      		dataType : "json",
		      		cache : false,
		      		success : function(data){
		      			//alert("통신성공");
		      			document.location.href = document.location.href;		
		      			
		      		},
		      		error : function(){
		      			alert("통신오류 실패");			
		      		}		
		      	});	
	      	}
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
							  <div aria-current="false" class="menuitemin" style="font-weight: bold"><a href="../admin/accept.do" target="_parent">가입승인</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../admin/courseRegister.do" target="_parent">강의등록</a></div>
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
   <div class="main">
      <div class="container">
        <div class="sidebar">
          <div class="top">
            <div id="myinfo" class="myinfo" style="margin-top:20px;">
              <!-- <iframe src = "../leftmenu/myinfo_s.jsp" width="100%" height="100%"></iframe> -->
              [관리자모드]
            </div>
            <br>
            <div class="logStatus" style="font-weight: bold">
              <a href="<%=request.getContextPath()%>/member/memberLogout.do" target="_parent">logout</a>
            </div>
          </div>
          <br>
          <div class="topmenu_name">가입승인</div>
          <div class="bottom">
           <ul>
             <li class="personalinfo">
               <ul>
                 <li><a href="../admin/accept.do" target="_parent" style="color:#0078ff; font-weight: bold;">
                 <i class="fa fa-id-card-o" aria-hidden="true"></i>
                  회원가입승인</a></li>
               </ul>
             </li>
           </ul>
          </div>
        </div>
        <div class="contents">
            <div>
            <h3>회원가입 승인</h3>
                <div class="first_line">
                	  <div id= "checkedMember" style="padding-right: 5px;">
	                      <input type="radio" name="MemberList" value="studentAll" id="studentRadio" >학생
	                      <input type="radio" name="MemberList" value="professorAll" id="professorRadio" >교수
	                      <input type="button" name="btn" value="선택보기" id="view">
                      </div>
                      <div id= "studentCheckedBtn">
	                      <input type="submit" id="submitButton1" value="일괄승인">
	                      <input type="submit" id="submitButton2" value="일괄거부">
                      </div>
                      <div id= "professorCheckedBtn">
	                      <input type="submit" id="submitButton3" value="일괄승인">
	                      <input type="submit" id="submitButton4" value="일괄거부">
                      </div>
                </div>
       
                <!-- 학생리스트 -->
                <form id ="studentAccept" method="post">
                <div id ="studentAllList" class="list_table">
                    <table>
                        <thead>
                            <tr>
                                <td style="width: 50px;">
                                    <input type="checkbox" name="studentSelectAll" id="studentSelectAll"/>
                                </td>
                                <td style="width: 50px;">순번</td>
                                <td style="width: 80px;">구분</td>
                                <td style="width: 100px;">이름</td>
                                <td style="width: 150px;">생년월일</td>
                                <td style="width: 300px;">이메일</td>
                                <td style="width: 200px;">전공</td>
                                <td colspan="2" width: 50px;>처리</td>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="mv" items="${slist}" varStatus="status">
                            <tr>
                                <td>
                                    <input type="checkbox" name="student" value="${mv.sidx}">
                                </td>
                                <td>${slist.size()-status.count+1}</td>
                                <td>학생</td>
                                <td>${mv.s_name}</td>
                                <td>${mv.s_birth}</td>
                                <td>${mv.s_email}</td>
                                <td>${mv.s_major}</td>
                                <td style="padding-right:10px">
                                    <button type="button" id="btn" onclick='acceptStudentOk(${mv.sidx})'>승인</button>
                                    <button type="button" id="btn2" onclick='acceptStudentNo(${mv.sidx})'>거부</button>                
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                </form>
                
                <!-- 교수리스트 -->
                <form id="professorAccept" method="post">
                <div id ="professorAllList" class="list_table">
                    <table>
                        <thead>
                            <tr>
                                <td style="width: 50px;">
                                    <input type="checkbox" name="professorSelectAll"  id="professorSelectAll"/>
                                </td>
                                <td style="width: 50px">순번</td>
                                <td style="width: 80px">구분</td>
                                <td style="width: 100px">이름</td>
                                <td style="width: 150px">생년월일</td>
                                <td style="width: 300px">이메일</td>
                                <td style="width: 200px">전공</td>
                                <td colspan="2" width: 50px;>처리</td>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="mv" items="${plist}" varStatus="status">
                            <tr>
                                <td>
                                    <input type="checkbox" name="professor" value="${mv.pidx}">
                                </td>
                                <td>${plist.size()-status.count+1}</td>
                                <td>교수</td>
                                <td>${mv.p_name}</td>
                                <td>${mv.p_birth}</td>
                                <td>${mv.p_email}</td>
                                <td>${mv.p_major}</td>
                                <td style="padding-right:10px">
                                    <button type="button" id="btn3" onclick='acceptProfessorOk(${mv.pidx})'>승인</button>
                                    <button type="button" id="btn4" onclick='acceptProfessorNo(${mv.pidx})'>거부</button>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                </form>
            </div>
        </div>
      </div>
    </div>
	
</body>
</html>