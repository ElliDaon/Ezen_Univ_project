<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- %
 if (session.getAttribute("pidx") ==null){
	 out.println("<script>alert('로그인하셔야 합니다.');</script>");	 
	 out.println("<script>location.href='"+request.getContextPath()+"/index.jsp'</script>");
 }
% -->
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="../css/nav_style.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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

function check(){

	var fm = document.frm; //문서객체안의 폼객체이름
	
	
	if(fm.when.value ==""){
		alert("날짜를 선택하세요");
		fm.when.focus();
		
		return;
		
	}else if (fm.contents.value ==""){
		alert("내용을 입력하세요");
		fm.contents.focus();
		
		return;
	}
	
	confirm('정말 글을 등록하시겠습니까?');
	
	//처리하기위해 이동하는 주소
	fm.action ="<%=request.getContextPath()%>/notice/noticeWriteAction.do";  
	fm.method = "post";  //이동하는 방식  get 노출시킴 post 감추어서 전달
	fm.submit(); //전송시킴
	alert("글이 작성되었습니다.");
	return;
}

</script>

<link rel="stylesheet" href="../css/iframe.css">
<style>


 h3 {
    
    font-size: 1.47em;
    font-weight: 500;
    color: #0067b3;
    margin-bottom: 10px;
   
}

.subject {
    display: flex;
    align-items: center;
    width: 100%;
    background: #f2f2f2;
    color: black;
    border: 1px solid #ccc;
    border-top: solid 2px #0067b3;
    display: flex;
}
.writebtn{
    background: #0067b3;
    width: 70px;
    height: 38px;
    text-align: center;
    color: white;
    font-size:17px;
    font-weight: bold;
    border: 0;

}
.list1{
    display: flex;
    justify-content: space-between;
    border: 0;
}

.material-symbols-outlined{


background: #0067b3;
width: 40px;
height: 38px;
text-align: center;
color: white;
font-size:35px;
padding-top : 3px;
border: 0;

     
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
.container{
    display: flex;
   
} 
.list{
   
    border-radius: 5px;
    color: whitesmoke;
    text-decoration: none;
    
}
    
.text-area{
    width: 100%;
    border: 1px solid #ccc;
    height: 500px;
    
}

.noticeWrite{
    border-collapse: collapse;
    width: 50%;   
}


.subject td{
    
    text-align: center;
    align-items: center;
    border: 0;
    margin: 10px;
    margin-top: 12px;
  
}

.btnlist{

  
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
       
}

td {
    border:  none;
}


</style>

</head>
<body>
	<div id="main-header">
		<header class="mainHeader">
			<section class="mainHeaderSection">
				<div>
					<a href="../main/main_p.do" class="logoLink" target="_parent"><img src="../images/ezen_univ.png" width="150"></a>
					<div class="headerMenu">
						<nav class="menuList">
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../mypage/personalinfo_p.do" target="_parent">마이페이지</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../attendance/attendanceSituation_p.do" target="_parent">출석관리</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin" style="font-weight: bold"><a href="../notice/noticeList_p.do" target="_parent">공지사항</a></div>
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
          <div class="topmenu_name">공지사항</div>
          <div class="bottom">
           <ul>
             <li class="personalinfo">
               <ul>
                 <li><a href="../notice/noticeList_p.do" target="_parent" style="color:#0078ff; font-weight: bold;">
                 <i class="fa fa-envelope-open-o" aria-hidden="true"></i>
                  휴보강 공지</a></li>
               </ul>
             </li>
           </ul>
          </div>
        </div>
    <div class="contents">
        
        <form name="frm">
        <table class="noticeWrite">
                <h3>휴보강 공지등록</h3>
             <tr class="subject">
            <td><strong>제목</strong>&nbsp;&nbsp;&nbsp;</td>
            <td>
            <select name="noticetype">
                <option value="휴강">휴강</option>
                <option value="보강">보강</option>
            </select>
            </td>
            <td>
            <select name="coursetype">
            	<c:forEach var="cv" items="${courselist}">
                <option value="${cv.cidx}">${cv.c_name}</option>
                </c:forEach>
            </select>
            </td>
            <td>
                <input type="date" name="when">
            </td>
        </tr>
        <tr>
            <td>

            </td>
        </tr>
        <tr>
            
            <td>
                <textarea name="contents" class="text-area"></textarea>
            </td>
            
        </tr>
        
        <tr style="border: none;">
            <td style="height: 10px; border: none;"></td>
        </tr>

        <tr>
           
            <td class="list1">
    			<a class="list" href="noticeList_p.do" onclick="return confirm('글은 저장되지 않습니다. 정말 나가시겠습니까?')">
                    <input type="button" class="writebtn" value="목록" ></input> 
   				</a>
                    <input type="button" class="writebtn" value="등록" onclick="check();" ></input> 
            </td>
            

        </tr>

        </table>


        </form>
       
        
        </div>
      </div>
    </div>
</body>
</html>