<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../css/searchInfo.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script>
    function searchid(){
        var fm = document.searchIdfrm;
        var memberName = fm.memberName.value;
        var memberEmail = fm.memberEmail.value;
        $("#idinfo").empty();
        var value = document.querySelector('input[name="select"]:checked').value;
        if(value==='student'){
        
        	$.ajax({
        		type: "post",
        		url: "${pageContext.request.contextPath}/member/searchStudentId.do",
    			data: {
    				"memberName" : memberName,
    				"memberEmail" : memberEmail
    			},
    			dataType: "json",
    			success: function(data){
    				var str = "";
    				if(data!=null){
    					str += "<p class='idinfo'>회원님의 아이디는 <span>";
    					str += data.memberId;
    					str += "</span> 입니다.</p>";
    					$("#idinfo").html(str);
    					return;
    				}else{
    					str += "<p class='idinfo'><span>조회되는 아이디가 없습니다.</span></p>";	
    					$("#idinfo").html(str);
    					return;
    				}
    			},
    			error: function(request, status, error) {
    		        alert(data);
    		        alert("status : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
    		      }
        	});
        }else{
        	$.ajax({
        		type: "post",
        		url: "${pageContext.request.contextPath}/member/searchProfessorId.do",
    			data: {
    				"memberName" : memberName,
    				"memberEmail" : memberEmail
    			},
    			dataType: "json",
    			success: function(data){
    				var str = "";
    				if(data!=null){
    					str += "<p class='idinfo'>회원님의 아이디는 <span>";
    					str += data.memberId;
    					str += "</span> 입니다.</p>";
    					$("#idinfo").html(str);
    					return;
    				}else{
    					str += "<p class='idinfo'><span>조회되는 아이디가 없습니다.</span></p>";	
    					$("#idinfo").html(str);
    					return;
    				}
    			},
    			error: function(request, status, error) {
    		        alert("status : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
    		      }
        		
        	});
        }
       
    }
    function searchpwd(){
    	var fm = document.searchPwdfrm;
        var memberId = fm.memberId.value;
        var memberName = fm.memberName.value;
        var memberEmail = fm.memberEmail.value;
        
        var value = document.querySelector('input[name="select_pwd"]:checked').value;
        if(value==='student'){
        	
        	$.ajax({
        		type: "post",
        		url: "${pageContext.request.contextPath}/member/searchStudentPwd.do",
    			data: {
    				"memberId" : memberId,
    				"memberName" : memberName,
    				"memberEmail" : memberEmail
    			},
    			dataType: "json",
    			success: function(data){
    				var str = "";
    				if(data==null){
    					const pwdinfo = document.querySelector('.pwdinfo');
    					const notfound = document.querySelector('.notfound');
    					pwdinfo.classList.remove('active');
    					notfound.classList.add('active');
    					
    					return;
    				}else{
    					const pwdinfo = document.querySelector('.pwdinfo');
    					const notfound = document.querySelector('.notfound');
    					pwdinfo.classList.add('active');
    					notfound.classList.remove('active');
    					return;
    				}
    			},
    			error: function(request, status, error) {
    		        alert("status : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
    		      }
        		
        	});
        	
        }else{
        	$.ajax({
        		type: "post",
        		url: "${pageContext.request.contextPath}/member/searchProfessorPwd.do",
    			data: {
    				"memberId" : memberId,
    				"memberName" : memberName,
    				"memberEmail" : memberEmail
    			},
    			dataType: "json",
    			success: function(data){
    				var str = "";
    				if(data==null){
    					const pwdinfo = document.querySelector('.pwdinfo');
    					const notfound = document.querySelector('.notfound');
    					pwdinfo.classList.remove('active');
    					notfound.classList.add('active');
    					return;
    				}else{
    					const pwdinfo = document.querySelector('.pwdinfo');
    					const notfound = document.querySelector('.notfound');
    					pwdinfo.classList.add('active');
    					notfound.classList.remove('active');
    					return;
    				}
    			},
    			error: function(request, status, error) {
    		        alert("status : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
    		      }
        		
        	});
        }
    }

    function PwdChange(){
    	var fm = document.searchPwdfrm;
        var memberId = fm.memberId.value;
        var memberName = fm.memberName.value;
        var memberEmail = fm.memberEmail.value;
        
        var cngfrm = document.PwdCngfrm;
        var newpwd = cngfrm.newpwd.value;
        var newpwdCheck = cngfrm.newpwdCheck.value;
        
       	if(newpwd==""){
       		alert('새로운 비밀번호를 입력해주세요');
       		return;
       	}
   		var pwcolor=$('#checkpw2').css("color");
   		if(pwcolor == "rgb(255, 0, 0)"){
   			alert('새로운 비밀번호를 확인해주세요');
   			return;
   		}
        var value = document.querySelector('input[name="select_pwd"]:checked').value;
        if(value==='student'){
    		$.ajax({
        		type: "post",
        		url: "${pageContext.request.contextPath}/member/changeStudentPwd.do",
    			data: {
    				"memberId" : memberId,
    				"memberName" : memberName,
    				"memberEmail" : memberEmail,
    				"newpwd" : newpwd,
    			},
    			dataType: "json",
    			success: function(data){
    				var str = "";
    				if(data.value == null){
    					alert('인증 오류입니다. 다시 시도해주세요.');
    					return;
    				}else{
    					alert('변경이 완료되었습니다. 새로운 비밀번호로 로그인해주세요.');
    					window.close();
    				}
    			},
    			error: function(request, status, error) {
    		        alert("status : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
    		      }
        		
        	});
    	}else{
    		
    		$.ajax({
        		type: "post",
        		url: "${pageContext.request.contextPath}/member/changeProfessorPwd.do",
    			data: {
    				"memberId" : memberId,
    				"memberName" : memberName,
    				"memberEmail" : memberEmail,
    				"newpwd" : newpwd,
    			},
    			dataType: "json",
    			success: function(data){
    				var str = "";
    				if(data.value == null){
    					alert('인증 오류입니다. 다시 시도해주세요.');
    					return;
    				}else{
    					alert('변경이 완료되었습니다. 새로운 비밀번호로 로그인해주세요.');
    					window.close();
    				}
    			},
    			error: function(request, status, error) {
    		        alert("status : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
    		      }
        		
        	});
    	}
    }
    function authenCodeCheck(){
    	var fm = document.authenCode;
    	var securepass = fm.securepass.value;
    	
    	$.ajax({
    		type: "post",
    		url: "${pageContext.request.contextPath}/member/securepassCheck.do",
			data: {
				"securepass" : securepass
			},
			dataType: "json",
			success: function(data){
				
				if(data.value=='1'){
					alert('인증이 완료되었습니다.');
					const changepw = document.querySelector('.changepw');
					changepw.classList.add('active');
					return;
				}else{
					alert('인증번호를 확인해주세요.');
				}
				
			},
			error: function(request, status, error) {
		        alert("status : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		      }
    		
    	});
    }
    </script>
</head>
<body>

    <div class="wrapper">
        <h2>회원정보찾기</h2><hr>
        <div class="searchId-box">
            <h3>| 아이디찾기 |</h3><br>
            <form name = "searchIdfrm">
                <div class="searchId">
                    <input type="text" id="memberName"><label>이름</label>
                    <input type="email" id="memberEmail"><label>이메일</label><br>
                    <div class="choose">
						<input type="radio" id="select_stu" name="select" value="student" checked><label for="select_stu">student</label> &nbsp | &nbsp 
						<input type="radio" id="select_pro" name="select" value="professor"><label for="select_pro">professor</label>
	                     &nbsp &nbsp<button type="button" class="btn" onclick="searchid()">찾기</button>
					</div>
                </div>
            </form>
            <div id="idinfo">
           		
            </div>
        </div>
        <hr>
        <div class="searchId-box">
            <h3>| 비밀번호찾기 |</h3><br>
                <form name="searchPwdfrm">
                <div class="searchPwd">
                    <input type="text" id="memberId"><label>아이디</label><input type="text" id="memberName"><label>이름</label><br>
                    <input type="email" id="memberEmail"><label>이메일</label><br>
                    <div class="choose-pwd">
						<input type="radio" id="select_stu_pwd" name="select_pwd" value="student" checked><label for="select_stu_pwd">student</label> &nbsp | &nbsp 
						<input type="radio" id="select_pro_pwd" name="select_pwd" value="professor"><label for="select_pro_pwd">professor</label>
	                    &nbsp &nbsp<button type="button" class="btn" onclick="searchpwd()">찾기</button>
					</div>
                </div>
                </form>
             <form name="authenCode" > 
             <div id="pwdinfo" class="pwdinfo">
             	<p>해당 이메일로 인증번호를 발송하였습니다.</p><br>
             	
             	인증번호 <input type="text" id="securepass" name="securepass">
             	<button type="button" onclick="authenCodeCheck()">인증</button><br>
            </div>   
            </form>
            <div id="notfound" class="notfound">
            	<p>회원정보를 찾을 수 없습니다.</p>
            </div>
             <form name="PwdCngfrm">
             <div class="changepw">
             	<div class="pwdinfo-input" id="pwdinfo-input" name="pwdinfo-input">
             	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp비밀번호
             	<input type="password" name="newpwd" id="newpwd" oninput="pwcheck2()">
             	<span id="checkpw">※ 영문, 숫자, 특수기호 포함 8자 이상</span><br>
             	비밀번호 확인
             	<input type="password" name="newpwdCheck" id="newpwdCheck" oninput="pwcheck2()">
             	<span id="checkpw2">check</span>
             	</div><br>
             	<button type="button" class="changebtn" onclick="PwdChange()">변경</button>
             </div>
      		</form>
        </div>
    </div>
    <script src="../js/searchInfo.js"></script>
</body>
</html>