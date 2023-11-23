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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<style>
 h3 {
    
    font-size: 1.47em;
    font-weight: 500;
    color: #0067b3;
   
}


.deletebtn, .writebtn{
    background-color: black;
    border-radius: 5px;
    color: whitesmoke;
    text-decoration: none;
}   
.list{
    display: flex;
    justify-content: space-between;
    align-items: center; 
    margin-top: 10px;
    
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
.text-box{
    width: 100%;
    border: 2px solid #0067b3;
    height: 36px ;
    height: 500px;
}

.noticewrite{
    border-collapse: collapse;
    width: 70%;
    
}

.contents {
    display: flex;
    flex-direction: column;
    align-items: center; 
    margin-left: -70px;
    
}
.subject{
    display: inline-block;
    background: #f2f2f2;
    color: black;
    border: 1px solid #ccc;
    border-top: solid 2px #0067b3;
    height: 36px ;
    width: 100%;
    font-size: 18px;
    font-weight: bold;
    padding : 5px;
    vertical-align: top;
    
}

.list{
    border: 0;
}

.noticeinfotd{
    border: 0;
}


.subject td{
    text-align: center;
    align-items: center;
    border: 0;
    margin: 5px;
    
}

.noticeinfo{
	text-align : right;	
   
    height: 40px;
}

.material-symbols-outlined{

    background: #0078ff;

    width: 40px;
    height: 38px;
    text-align: center;
    color: white;
    border-radius: 5px;
    font-size:35px;
    padding-top : 2px;
    
         
}



</style>

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
							  <div aria-current="false" class="menuitemin"><a href="../mypage/personalinfo_s.do" target="_parent">마이페이지</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin"><a href="../attendance/attendanceSituation_s.do" target="_parent">출석관리</a></div>
							</div>
							<div role="menuitem" class="menuitem">
							  <div aria-current="false" class="menuitemin" style="font-weight: bold"><a href="../notice/noticeList_s.do" target="_parent">공지사항</a></div>
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
                 <li><a href="../notice/noticeList_s.do" target="_parent" style="color:#0078ff; font-weight: bold;">
                 <i class="fa fa-envelope-open-o" aria-hidden="true"></i>
                  휴보강 공지</a></li>
               </ul>
             </li>
           </ul>
          </div>
        </div>
    <div class="contents">
        <h3>휴보강 공지사항</h3>
        <table class="noticewrite">
        <tr class="subject">
            
            <td>제목 &nbsp; :</td>
            <td>&nbsp;&nbsp;&nbsp;[${nv.n_category}][${nv.n_skipdate}][${nv.c_name}]
            </td>        
        </tr>
        <tr class="noticeinfo">
        	<td class="noticeinfotd">
        	조회수 : ${nv.n_count} &nbsp;&nbsp;  작성일자 : ${nv.n_writeday}
       		</td>
       		
        </tr>
        <tr>
            <td class="text-box">
                ${nv.n_contents}
            </td>
        </tr>
        <tr>
            <td class="list">
                <a class="link" href="noticeList_s.do"><span class="material-symbols-outlined">
                    list_alt
                </span></a>
            

            </td>
        </tr> 
        </table>
    </div>
  </div>
</div>
</body>
</html>