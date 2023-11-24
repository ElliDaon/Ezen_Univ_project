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
<link rel="website icon" type="png" href="images/ezen.png">
<link rel="stylesheet" href="css/index_style.css">
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
	var checkId = $('#check-id-icon').css("color");
	var checkPwd1 = $('#pwd-check1').css("color");
	var checkPwd2 = $('#pwd-check2').css("color");
	
	if(fm.memberId.value ==""){
		alert("아이디를 입력하세요");
		fm.memberId.focus();
		return;
	}else if(checkId === "rgb(255, 0, 0)"){
		alert("아이디 중복확인을 체크해주세요.");
		fm.memberId.value="";
		fm.memberId.focus();
		return;
	}else if(fm.memberPwd.value ==""){
		alert("비밀번호를 입력하세요");
		fm.memberPwd.focus();
		return;
	}else if(checkPwd1 === "rgb(255, 0, 0)"){
		alert("비밀번호 형식을 확인해주세요");
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
	<div class="first">
		<h1>Ezen University</h1><br>
		<strong style="font-size: 20px;">[출결시스템]</strong><br><br>
		<p>저희 프로젝트에 관한 자세한 설명은 오른쪽 상단의 INFO 카테고리에서 확인바랍니다.<br><br></p>
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
				<button type="submit" id="loginbtn" class="btn" onclick="login()">Login</button>
				<div class="remember-forgot">
					
					<button id="popup-btn" onclick="window.open('member/searchInfo.jsp','window_name','width=600,height=800,location=no,status=no,scrollbars=yes');">ID | password 찾기</button>
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