<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="../css/iframe.css">
<link rel="stylesheet" href= "../css/noticelist_p.css">
<link rel="stylesheet" href="../css/nav_style.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>

h3 {
    
    font-size: 1.47em;
    font-weight: 500;
    color: #0067b3;
    margin-bottom: 10px;
   
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
    border: 1px solid #ccc;
    height: 36px ;
    height: 500px;
    padding: 15px;
}

.noticewrite{
    border-collapse: collapse;
    width: 50%;
}

.contents {
    display: flex;
    flex-direction: column;
    
}
.subject {
    display: flex;
    align-items: center;
    width: 100%;
    background: #f2f2f2;
    color: black;
    font-weight: bold;
    border: 1px solid #ccc;
    border-top: solid 2px #0067b3;
    display: flex;
    
   
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
    margin: 10px;
    margin-top: 12px;
  
}

.noticeinfo{
	text-align : right;	
   
    height: 40px;
}

.material-symbols-outlined{

    background: #0067b3;
    width: 40px;
    height: 38px;
    text-align: center;
    color: white;
    font-size:35px;
    padding-top : 2px;
         
}
.listbtn{
   
    background: #0067b3;

    width: 70px;
    height: 38px;
    font-size: 15;
    text-align: center;
    vertical-align: middle;
    color: white;
    font-weight: bold; 
    border: 0;

}


.modify{
    background: #0067b3;

    width: 40px;
    height: 38px;
    font-size: 15;
    text-align: center;
    vertical-align: middle;
    color: white;
    font-weight: bold; 
    border: 0;
}
.delete{
    background: #0067b3;

    width: 40px;
    height: 38px;
    font-size: 15;
    text-align: center;
    vertical-align: middle;
    color: white;
    font-weight: bold;
    border: 0;
     
}
</style>

<script type="text/javascript">
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
</script>

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
        <h3>휴보강 공지사항</h3>
        <table class="noticewrite">
        <tr class="subject">
            <td>제목 &nbsp; :</td>
            <td>&nbsp;&nbsp;&nbsp; [${nv.n_category}][${nv.n_skipdate}][${nv.c_name}]
            </td>        
        </tr>
        <tr class="noticeinfo">
        	<td class="noticeinfotd">
        	<strong>조회수</strong> : ${nv.n_count} &nbsp;&nbsp;  <strong>작성일자</strong> : ${nv.n_writeday} &nbsp;&nbsp; <strong>작성자</strong> : ${nv.p_name}
       		</td>
       		
        </tr>
        <tr>
            <td class="text-box">              
                <p style="white-space: pre;">${fn:replace(fn:replace(nv.n_contents,'<','&lt;'),'>','&gt;')}
                </p>
            </td>
        </tr>
        <tr>
            <td class="list">
                <a class="link" href="noticeList_p.do">
                    <button class="listbtn" type="button">목록</button>
                </a>
            
                <div>
                <button type="button" class="modify" onclick="location.href='<%=request.getContextPath()%>/notice/noticeModify.do?nidx=${nv.nidx}'">수정</button>
                <button type="button" class="delete" onclick="if (confirm('정말 삭제하시겠습니까?')) window.location.href='<%=request.getContextPath()%>/notice/noticeDelete.do?nidx=${nv.nidx}'">삭제</button>
                </div>
            </td>
        </tr> 
        </table>
    </div>
  </div>
</div>

</body>
</html>