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
	<link rel="stylesheet" href="../css/modifypassword.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    </style>
</head>
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
	
	    function pwcheck(){
    		var pw = $("#newPass").val();
	   		var num = pw.search(/[0-9]/g);
	   		var eng = pw.search(/[a-z]/ig);
   		    var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
   		    
   		    if(pw.length < 8 || pw.search(/\s/) != -1 || num < 0 || eng < 0 || spe < 0 ){
   		    	$('#newpwcheck').text('형식확인').css('color','red');
   		    }else{
   		    	$('#newpwcheck').text('check').css('color','green');
   		    }
   		    
	
			if($('#newPass').val() == $('#newPassCheck').val()){
				$('#pwcheck').text('비밀번호 일치').css('color','green');
			}else{
				$('#pwcheck').text('비밀번호 불일치').css('color','red');
			}
		}
    
    	function check(){
	  		var fm = document.modifypass;
    		var ch1 = document.getElementById('newpwcheck').innerHTML;

    		if(fm.newPass.value == ""){
    			alert("새로운 비밀번호를 입력해주세요.");
        		fm.newPass.focus();
        		return;
    		}else if(fm.newPassCheck.value == ""){
    			alert("비밀번호 확인란을 입력해주세요.");
        		fm.newPassCheck.focus();
        		return;
    		}else if(fm.newPass.value !== fm.newPassCheck.value){
    			alert("비밀번호 확인을 체크해주세요");
        		fm.newPassCheck.value="";
        		return;
    		}else if(ch1 !== "check"){
    			alert("비밀번호 형식을 체크해주세요");
    			fm.newPass.focus();
    			return;
    		}
    		
    		fm.action = "<%=request.getContextPath()%>/mypage/modifypassword_pAction.do";
        	fm.method = "post"; 
        	fm.submit();
        	return;
    	}
    </script>
<body>
	<div id="main-header">
		<header class="mainHeader">
			<section class="mainHeaderSection">
				<div>
					<a href="../main/main_p.do" class="logoLink" target="_parent"><img src="../images/ezen_univ.png" width="150"></a>
					<div class="headerMenu">
						<nav class="menuList">
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin" style="font-weight: bold"><a href="../mypage/personalinfo_p.do" target="_parent">마이페이지</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../attendance/attendanceSituation_p.do" target="_parent">출석관리</a></div>
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
      <div class="container">
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
          <div class="topmenu_name">마이페이지</div>
          <div class="bottom">
           <ul>
             <li class="personalinfo">
              <ul>
               <li><i class="fa fa-user-circle" aria-hidden="true"></i>
               개인정보</li>
              </ul>
               <ul>
                 <li><a href="../mypage/personalinfo_p.do" target="_parent">&ensp;&ensp;개인정보</a></li>
                 <li><a href="../mypage/modifyinfo_p.do" target="_parent" style="color:#0078ff; font-weight: bold;">&ensp;&ensp;개인정보 수정</a></li>
               </ul>
             </li>
             <li class="personalinfo">
              <ul>
               <li><i class="fa fa-book" aria-hidden="true"></i>
               강의정보</li>
              </ul>
               <ul>
                 <li><a href="../mypage/courseList_p.do" target="_parent">&ensp;&ensp;강의 현황</a></li>
                 <li><a href="../mypage/searchP_table_p.do" target="_parent">&ensp;&ensp;교수 시간표 조회</a></li>
               </ul>
             </li>
           </ul>
          </div>
        </div>
        <div class="contents">
            <table class="table" width="600px" name="frm">
				<tr>
				 <td>
				  <table width="100%">
				   <tr align="center">
					<td style="font-size:20px"><b><i class="fa fa-key" aria-hidden="true"></i> 비밀번호 변경</b></td>
				   </tr>
				  </table>
				  
				  <table class="table2" width="100%">
				   <form name="modifypass">
					<table>
					   <tr>
						   <td width="35%" align="right">아이디</td>
						   <td width="65%">${p_id}</td>
					   </tr>
					   <tr>
						   <td align="right">현재 비밀번호</td>
						   <td><input type="password" id="nowPass" name="nowPass" required /></td>
					   </tr>
					   <tr>
						   <td align="right">비밀번호</td>
						   <td><input type="password" id="newPass" name="newPass" oninput="pwcheck()" /></td>
					   </tr>
					   <tr>
						   <td align="right">비밀번호 확인</td>
						   <td><input type="password" id="newPassCheck" name="newPassCheck" oninput="pwcheck()" /></td>
					   </tr>
					   <tr>
						   <td colspan="2" align="center" style="color:red">※ 영문, 숫자, 특수기호 포함 8자 이상</td>
					   </tr>
					</table>
					<table class="table3" width="100%">
					   <tr align="center">
						   <td>
						   <input type="button" name="btn" value="변경" onclick="check();">
						   </td>
					   </tr>
					</table>
				   </form>
				  </table>
				 </td>
				</tr>
			   </table>
			   <div class="newpasscheck">
			   <span id="newpwcheck"></span>
			   </div>
			   <div class="passcheck">
			   <span id="pwcheck"></span>
			   </div>
        </div>
    </div>
</body>
</html>