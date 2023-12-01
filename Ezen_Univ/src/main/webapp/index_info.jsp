<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% response.setHeader("P3P","CP='CAO PSA CONi OTR OUR DEM ONL'");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@200;300&family=Passion+One:wght@400;700&family=Quicksand&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Paytone+One&display=swap" rel="stylesheet">
<link rel="website icon" type="png" href="images/ezen.png">
<link rel="stylesheet" href="css/index_info.css">
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<script>
$(document).ready(function(){
	$("#idcheck").on("click",function(){
		let memberIdCheck=document.joinfrm.memberId.value;
		
		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/member/memberIdCheck.do",
			data: {"memberId" : memberIdCheck},
			dataType: "json",
			success: function(data){
				if(memberIdCheck==""){
					alert("아이디를 입력해주세요!!");
				}else if(data.value == 0){
					alert("사용할 수 있는 아이디입니다.");
					$('#check-id-icon').css('color','green');
				}else{

					alert("중복되는 아이디 입니다.");
					$('#check-id-icon').css('color','red');
					memberIdCheck = "";
				}
			},
			error: function(){
				alert("실패");
			}
		});
	});
});
</script>
<script>


function adminLogin(){
	var fm = document.adminfrm;
	
	if(fm.adminId.value==""){
		alert("아이디를 입력하세요");
		fm.adminId.focus();
		return;
	}else if(fm.adminPwd.value==""){
		alert("비밀번호를 입력하세요");
		fm.adminPwd.focus();
		return;
	}
	
	fm.action ="<%=request.getContextPath()%>/admin/adminLogin.do"; 
    fm.method = "post"; 
    fm.submit();
    return;
}

function login(){
    var fm = document.frm;
    
    if(fm.memberId.value ==""){
		alert("아이디를 입력하세요");
		fm.memberId.focus();
		return;
	} else if(fm.memberPwd.value ==""){
		alert("비밀번호를 입력하세요");
		fm.memberPwd.focus();
		return;
	}
    
    var value = document.querySelector('input[name="select"]:checked').value;
   // alert(value);
    if(value==='student'){
        fm.action ="<%=request.getContextPath()%>/member/studentLoginAction.do"; 
	    fm.method = "post"; 
	    fm.submit();
	    return;
    }else{
    	fm.action ="<%=request.getContextPath()%>/member/professorLoginAction.do"; 
	    fm.method = "post"; 
	    fm.submit();
	    return;
    }  
}

function join(){
	var fm = document.joinfrm;

	if(fm.memberId.value ==""){
		alert("아이디를 입력하세요");
		fm.memberId.focus();
		return;
	}else if(fm.memberPwd.value ==""){
		alert("비밀번호를 입력하세요");
		fm.memberPwd.focus();
		return;
	}else if(fm.memberPwd.value !== fm.memberPwd2.value){
		alert("비밀번호가 일치하지 않습니다");
		fm.memberPwd2.value="";
		fm.memberPwd2.focus();
		return;
	}else if(fm.memberName.value==""){
		alert("이름을 입력해주세요");
		fm.memberName.focus();
		return;
	}else if(fm.memberPhone.value==""){
		alert("휴대폰번호를 입력해주세요");
		fm.memberPhone.focus();
		return;
	}else if(fm.memberEmail.value==""){
		alert("이메일을 입력해주세요");
		fm.memberEmail.focus();
		return;
	}else if (!CheckEmail(fm.memberEmail.value)){
		alert("이메일 형식이 유효하지 않습니다.");
		fm.memberEmail.value="";
		fm.memberEmail.focus();
		return;	
	}else if(fm.memberBirth.value==""){
		alert("생년월일을 입력해주세요");
		fm.memberBirth.focus();
		return;
	}else if(fm.memberMajor.value==""){
		alert("전공을 선택해주세요");
		fm.memberMajor.focus();
		return;
	}
	
	
	var selectvalue = document.querySelector('input[name="selectjoin"]:checked').value;

	if(selectvalue==='student'){
        fm.action ="<%=request.getContextPath()%>/member/studentJoinAction.do"; 
	    fm.method = "post"; 
	    fm.submit();
	    return;
    }else{
    	fm.action ="<%=request.getContextPath()%>/member/professorJoinAction.do"; 
	    fm.method = "post"; 
	    fm.submit();
	    return;
    }
}

function CheckEmail(str){ 
	//정규표현식 - 일정한 패턴에따라 해당되는 위치에 해당하는 값의 범위를 지정
     var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
     if(!reg_email.test(str)) { 
          return false;  
     }  
     else {
          return true; 
     } 
} 

function guideForStudent(){
	var pdfPath = "<%=request.getContextPath()%>/guide/guide_student.jsp";
	window.open(pdfPath, '_blank');
	if (!pdfPath) {
        alert('팝업 창이 차단되었습니다. 팝업 차단을 해제하고 다시 시도하세요.');
    }
}
function guideForProfessor(){
	var pdfPath = "<%=request.getContextPath()%>/guide/guide_professor.jsp";
	window.open(pdfPath, '_blank');
	if (!pdfPath) {
        alert('팝업 창이 차단되었습니다. 팝업 차단을 해제하고 다시 시도하세요.');
    }
}
function guideForAdmin(){
	var pdfPath = "<%=request.getContextPath()%>/guide/guide_admin.jsp";
	window.open(pdfPath, '_blank');
	if (!pdfPath) {
        alert('팝업 창이 차단되었습니다. 팝업 차단을 해제하고 다시 시도하세요.');
    }
}
</script>
<body>	
	<header>
		<h2 class="logo"><a href="index.jsp">Ezen_Univ</a></h2>
		<nav class="navigation">
			<a href="index.jsp">HOME</a>
			<a href="index_info.jsp">INFO</a>
			<button class="btnLogin-popup">SIGN-IN</button>
		</nav>
	</header>
	
	<div class="info">
		<div class="info-title">
			<img src="./images/ezen.png">
			<span>출결시스템</span><br>
		</div><br><br>
		<div class="appfnc">
			<h2><ion-icon name="extension-puzzle-outline"></ion-icon> 출결시스템 이용안내</h2><br>
			<ion-icon name="caret-forward"></ion-icon> ezen-univ 출결시스템은 간편하게 사용 가능한 출결관리를 위한 시스템입니다.<br>
			<ion-icon name="caret-forward"></ion-icon> 복잡하지 않고 직관적인 UI로 사용하기 편리하게 설계되었습니다.<br>
			<div class="login_info">
				<div class="login_info_li">
					<div class="info_li_title">
						<ion-icon name="play-circle-outline"></ion-icon>
						<h4>학생 로그인</h4>
					</div>
					- I D : ezentest<br>
					- PWD : 1111
				</div>
				<div class="login_info_li">
					<div class="info_li_title">
						<ion-icon name="play-circle-outline"></ion-icon>
						<h4>교수 로그인</h4>
					</div>
					- I D : test011<br>
					- PWD : 0101
				</div>
				<div class="login_info_li">
					<div class="info_li_title">
						<ion-icon name="play-circle-outline"></ion-icon>
						<h4>관리자 로그인</h4>
					</div>
					- I D : adminezen<br>
					- PWD : ezen1111
				</div>
				<div class="admin_login">
					<button class="admin_login_btn"><label>관리자 로그인</label></button>
				</div>
			</div>
			<br><hr><br>
			<h2><ion-icon name="extension-puzzle-outline"></ion-icon> 주요기능</h2><br>
			<ion-icon name="caret-forward"></ion-icon> 출석체크<br>
			<ion-icon name="caret-forward"></ion-icon> 개인별 출석 현황 조회<br>
			<ion-icon name="caret-forward"></ion-icon> 시간표 조회<br>
			<br><hr><br>
			<h2><ion-icon name="extension-puzzle-outline"></ion-icon> 이용방법</h2><br>
			<ion-icon name="caret-forward"></ion-icon> 출결시스템 가입 필수<br>
			<ion-icon name="caret-forward"></ion-icon> 이용안내 메뉴얼<br>
			
			
			<div class="admin_login_wrapper">
				<form name="adminfrm">
				<span class="admin-close"><ion-icon name="close-outline"></ion-icon></span>
				<p class="adminlogin_top">Admin Login</p>
				<br>
				<input type="text" name="adminId" id="adminId" placeholder="adminezen"><br>
				<input type="password" name="adminPwd" id="adminPwd" placeholder="ezen1111"><br>
				<button name="adminLogin_btn" onclick="adminLogin()">LOGIN</button>
				</form>
			</div>
			
			
			<div class="info-btn">
				<button onclick="guideForProfessor()">
					<label>교수 &nbsp&nbsp&nbsp&nbsp<ion-icon name="exit-outline"></ion-icon></label>
				</button>
				<button onclick="guideForStudent()">
					<label>학생 &nbsp&nbsp&nbsp&nbsp<ion-icon name="exit-outline"></ion-icon></label>
				</button>
				<button onclick="guideForAdmin()">
					<label>관리자 &nbsp&nbsp&nbsp&nbsp<ion-icon name="exit-outline"></ion-icon></label>
				</button>
			</div>
			<br><hr><br>
			<div class="team">
				<div class="team-img">
					<h2>OUR TEAM</h2><br>
					<img src="./images/3d_team.png" width=50%>
				</div>
				<div class="team-info">
					<h3>[ Ezen_Developer ]</h3><br>
					<div class="github"><ion-icon name="logo-github"></ion-icon>&nbsp GITHUB :&nbsp <a href="https://github.com/ElliDaon/Ezen_Univ_project.git" target="_blank">https://github.com/ElliDaon/Ezen_Univ_project.git</a></div>
					<div class="personal-info">
						<div class="personal-info-detail">
							<h4>문다온</h4><br>
							<span>[ PM ]</span>
						</div>
						<div class="personal-info-detail">
							<h4>김민정</h4><br>
							<span>[ PL ]</span>
						</div>
						<div class="personal-info-detail">
							<h4>박건도</h4><br>
							<span>[ PA ]</span>
						</div>
						<div class="personal-info-detail">
							<h4>윤대희</h4><br>
							<span>[ PA ]</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="bottom">
	
		</div>
	</div>
	
	<div class="wrapper">
		<span class="icon-close"><ion-icon name="close"></ion-icon></span>
		<div class="form-box login">
			<h2>Login</h2>
			<form name="frm" action="" method="" value=""">
				<div class="input-box">
					<span class="icon"><ion-icon name="person"></ion-icon></span>
					<input type="text" name="memberId" id="memberId" required>
					<label>ID</label>
				</div>
				<div class="input-box">
					<span class="icon"><ion-icon name="key"></ion-icon></span>
					<input type="password" name="memberPwd" id="memberPwd" required>
					<label>password</label>
				</div>
				<div class="choose">
					<input type="radio" id="select_stu" name="select" value="student" checked><label for="select_stu">student</label> | 
					<input type="radio" id="select_pro" name="select" value="professor"><label for="select_pro">professor</label>
				</div>
				<button type="submit" class="btn" onclick="login()">Login</button>
				<div class="remember-forgot">
					<button onclick="window.open('member/searchInfo.jsp','window_name','width=600,height=800,location=no,status=no,scrollbars=yes');">ID | password 찾기</button>
				</div>
				<div class="login-register">
					<p><a href="#" class="register-link">SIGN-UP</a></p>
				</div>
			</form>
		</div>
		
		<div class="form-box register">
			<h2 style="font-size: 30px;">Registration</h2>
			<form name="joinfrm" action="">
				<div class="input-box">
					<span class="icon"><ion-icon name="person"></ion-icon></span>
					<input type="text" name="memberId" id="memberId" required>
					<label>ID</label>
					<button type="button" class="check-id" id="idcheck">
						<span class="check-id-icon" id="check-id-icon"><ion-icon name="checkbox-outline"></ion-icon></span>
					</button>
				</div>
				<div class="input-box" id="input-box-pwd">
					<span class="icon"><ion-icon name="key"></ion-icon></span>
					<input type="password" name="memberPwd" id="memberPwd" oninput="pwcheck()" required>
					<label>password</label>
					<div class="pass-info"><span id="pass-info"></span></div>
					<div class="check-pwd-icon" id="pwd-check1"><ion-icon name="checkbox-outline"></ion-icon></div>
				</div>
				<div class="input-box" id="input-box-pwd2">
					<span class="icon"><ion-icon name="key"></ion-icon></span>
					<input type="password" name="memberPwd2" id="memberPwd2" oninput="pwcheck()" required>
					<label>password 확인</label>
					<div class="pass-check-info"><span id="pass-check-info"></span></div>
					<div class="check-pwd-icon2" id="pwd-check2"><ion-icon name="checkbox-outline"></ion-icon></div>
				</div>
				<div class="input-box" id="input-box-name">
					<span class="icon"><ion-icon name="pricetag"></ion-icon></span>
					<input type="text" name="memberName" id="memberName" oninput="pwcheck()" required>
					<label>이름<span>(홍길동)</span></label>
				</div>
				<div class="input-box">
					<span class="icon"><ion-icon name="call"></ion-icon></span>
					<input type="tel" name="memberPhone" id="memberPhone" required>
					<label>연락처<span>(01011112222)</span></label>
				</div>
				<div class="input-box">
					<span class="icon"><ion-icon name="mail"></ion-icon></span>
					<input type="email" name="memberEmail" id="memberEmail" required>
					<label>이메일<span>(ezen@ezen.com)</span></label>
				</div>
				<div class="input-box birth">
					<span class="icon"><ion-icon name="calendar-number"></ion-icon></span>
					<input type="text" name="memberBirth" id="memberBirth" required>
					<label>생년월일<span>(19941024)</span></label>
				</div>
				<div class="input-box birth">
					<span class="icon"><ion-icon name="school"></ion-icon></span>
					<select name="memberMajor" id="memberMajor" required>
						<option key="default-empty" hidden></option>
						<option value="건축학과">건축학과</option>
	                    <option value="경제학과">경제학과</option>
	                    <option value="경영학과">경영학과</option>
	                    <option value="정보통신공학과">정보통신공학과</option>
	                    <option value="기계공학과">기계공학과</option>
	                    <option value="기계설계공학부">기계설계공학부</option>
	                    <option value="기계시스템공학부">기계시스템공학부</option>
	                    <option value="도시공학과">도시공학과</option>
	                    <option value="바이오메디컬공학부">바이오메디컬공학부</option>
	                    <option value="전기공학과">전기공학과</option>
					</select>
					<label class="choosemajor">학과</label>
				</div>
				<div class="choosejoin">
					<input type="radio" id="join_select_stu" name="selectjoin" value="student" checked><label for="join_select_stu">student</label> | 
					<input type="radio" id="join_select_pro" name="selectjoin" value="professor"><label for="join_select_pro">professor</label>
				</div>
				<button type="submit" class="btn" onclick="join()">회원가입</button>
				<div class="login-register">
					<p><a href="#" class="login-link">LOGIN</a></p>
				</div>
			</form>
		</div>
	
	</div>
	<script src="js/index.js"></script>
</body>
</html>