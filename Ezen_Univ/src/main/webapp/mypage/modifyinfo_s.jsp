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
	<link rel="stylesheet" href="../css/modifyinfo.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <script>
      $(document).ready(function(){
        studentInfo();
       });
  
      function studentInfo(){
  	
          var str = "";
  	
          var s_no =${sessionScope.s_no};
          var s_name = "${sessionScope.s_name}"
              var s_major = "${sessionScope.s_major}";
  	
          str = "<strong>[학생]</strong><br>"
              + s_name + "("+ s_no +")<br>"
              + "[" + s_major + "]";
  	
          $("#myinfo").html(str);
  	  return;
      }
    
    
    function check(){
    	var fm = document.modify;
    	
    	if(fm.studentPhone.value==""){
    		alert("번호를 입력해주세요.");
    		fm.professorPhone.focus();
    		return;
    	}else if(fm.studentEmail.value==""){
    		alert("이메일을 입력해주세요.");
    		fm.professorEmail.focus();
    		return;
    	}
    	
    	fm.action = "<%=request.getContextPath()%>/mypage/modifyinfo_sAction.do";
    	fm.method = "post"; 
    	fm.submit();
    	return;
    }
    </script>
</head>
<body>
	<div id="main-header">
		<header class="mainHeader">
			<section class="mainHeaderSection">
				<div>
					<a href="../main/main_s.do" class="logoLink" target="_parent"><img src="../images/ezen_univ.png" width="150"></a>
					<div class="headerMenu">
						<nav class="menuList">
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin" style="font-weight: bold"><a href="../mypage/personalinfo_s.do" target="_parent">마이페이지</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../attendance/attendanceSituation_s.do" target="_parent">출석관리</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../notice/noticeList_s.do" target="_parent">공지사항</a></div>
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
               <li><a href="../mypage/personalinfo_s.do" target="_parent"><i class="fa fa-user-circle" aria-hidden="true"></i>
               개인정보</a></li>
              </ul>
               <ul>
                 <li><a href="../mypage/personalinfo_s.do" target="_parent">&ensp;&ensp;개인정보</a></li>
                 <li><a href="../mypage/modifyinfo_s.do" target="_parent" style="color:#0078ff; font-weight: bold;">&ensp;&ensp;개인정보 수정</a></li>
               </ul>
             </li>
             <li>
              <ul>
               <li><a href="../mypage/courseList_s.do" target="_parent">
               <i class="fa fa-book" aria-hidden="true"></i>
               수강목록
               </a></li>
              </ul>
             </li>
             <li class="personalinfo">
              <ul>
               <li><a href="../mypage/mytable_s.do" target="_parent"><i class="fa fa-book" aria-hidden="true"></i>
               시간표</a></li>
              </ul>
               <ul>
                 <li><a href="../mypage/mytable_s.do" target="_parent">&ensp;&ensp;시간표 조회</a></li>
                 <li><a href="../mypage/searchP_table_s.do" target="_parent">&ensp;&ensp;교수 시간표 조회</a></li>
               </ul>
             </li>
           </ul>
          </div>
        </div>
        <div class="contents">
            <table class="table" name="frm" style="width:600px;">
				<tr>
				 <td>
				  <table style="width:100%;">
				   <tr align="center">
					<td style="font-size:20px"><h3><i class="fa fa-user-circle" aria-hidden="true"></i> 개인정보 수정</h3></td>
				   </tr>
				  </table>
				  <table class="table2" style="width:100%;">
				   <form action="" method="" name="modify">
					<table>
					   <tr>
						   <td width="35%" align="right" style="font-weight:bold; color:#555555;">아이디</td>
						   <td width="65%">${mv.s_id}</td>
					   </tr>
					   <tr>
						   <td width="35%" align="right" style="font-weight:bold; color:#555555;">이   름</td>
						   <td width="65%">${mv.s_name}</td>
					   </tr>
					   <tr>
						   <td width="35%" align="right" style="font-weight:bold; color:#555555;">학   번</td>
						   <td width="65%">${mv.s_no}</td>
					   </tr>
					   <tr>
						   <td width="35%" align="right" style="font-weight:bold; color:#555555;">생년월일</td>
						   <td width="65%">${mv.s_birth}</td>
					   </tr>
					   <tr>
						   <td width="35%" align="right" style="font-weight:bold; color:#555555;">학   과</td>
						   <td width="65%">${mv.s_major}</td>
					   </tr>
					   <tr>
						   <td align="right" style="font-weight:bold; color:#555555;">연락처</td>
						   <td><input type="tel" id="studentPhone" name="studentPhone" placeholder="01000000000" value="${mv.s_phone}" /></td>
					   </tr>
					   <tr>
						   <td align="right" style="font-weight:bold; color:#555555;">이메일</td>
						   <td><input type="email" id="studentEmail" name="studentEmail" placeholder="id@ezen_univ.com" value="${mv.s_email}" /></td>
					   </tr>
					</table>
					<table class="table3" style="width:100%;">
					   <tr align="center">
						   <td>
						   <input type="button" name="btn" value="확인" onclick="check();">
						   </td>
					   </tr>
					</table>
				   </form>
				  </table>
				 </td>
				</tr>
			   </table>
            <br>
            <table>
            	<tr>
				<td class="pwd" onClick="location.href='../mypage/modifypassword_s.do'" style="cursor:pointer;">
				<i class="fa fa-keyboard-o" aria-hidden="true"></i>&ensp;비밀번호 변경하기</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
</body>
</html>