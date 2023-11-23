<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList" %> 
<%@ page import="app.domain.*" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href= "../css/noticelist_p.css">
<link rel="stylesheet" href="../css/nav_style.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
<c:if test="${pm != null && pm.getTotalCount() == 0}">
    <script>alert('공지가 아직 등록되지 않았습니다.');</script>

</c:if>

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
        <h1>휴보강 공지</h1>
        <table class="noticelist" border=1 style="width:800px;" >
        	
            <thead>
                <tr>
                    <th style="width: 100px;">No</th>
                    <th>제목</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
            </thead>
            
            <tbody>
       		<c:forEach var="nv" items="${alist}">
			<tr>
			<td>
			${nv.nidx}
			</td>
			<td class="subject">
            <a href="${pageContext.request.contextPath}/notice/noticeContents.do?nidx=${nv.nidx}">
                <c:if test="${nv.n_dday eq 'true'}">
                <mark><span style="color: orange; font-weight: bold;">new</span></mark>
                </c:if>
                ${nv.n_subject}
            </a>
		

			</td>

	
			<td>
 			 ${nv.n_writeday.split(' ')[0]}
			</td>
			<td>
			${nv.n_count}
			</td>
			
			</tr>
			</c:forEach>

        	</tbody>
    </table>

<c:set var="parm" value="&subject=${pm.scri.subject}" />
    <table>
        <tr>
            <td style="width:700px"></td>
            <td>
                <div class="writediv"> 
                    <a class="noticeWrite" href="noticeWrite.do">
                        글쓰기
                    </a>
                </div>
            </td>
        </tr>
    </table>
    <br>

<table class="pagination" border=0 style="width:700px;text-align:center;">
<tr>
<td style="width:100px;text-align:right;">

<c:if test="${pm.prev == true}">
<a href="${pageContext.request.contextPath}/notice/noticeList_p.do?page=${pm.startPage-1}${parm}">
<span class="material-symbols-outlined">
arrow_back_ios_new
</span>
</a>
</c:if>

</td>
<td> 


<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1">
<c:choose>
<c:when test="${i == pm.scri.page}">
<a href="${pageContext.request.contextPath}/notice/noticeList_p.do?page=${i}${parm}"><div class="act">${i}</div></a> &nbsp;
</c:when>
<c:otherwise>
<a href="${pageContext.request.contextPath}/notice/noticeList_p.do?page=${i}${parm}"><div class="de">${i}</div></a> &nbsp;
</c:otherwise>
</c:choose>
</c:forEach>


</td>
<td style="width:100px;text-align:left;">

<c:if test="${pm.next == true&&pm.endPage>0}">
<a href="${pageContext.request.contextPath}/notice/noticeList_p.do?page=${pm.endPage+1}${parm}">
<span class="material-symbols-outlined">
arrow_forward_ios
</span>
</a>

</c:if>
</td>
</tr>
</table>
	
   
<br>
    
<form name="frm" 
action="${pageContext.request.contextPath}/notice/noticeList_p.do"
method="post"
onsubmit="saveSelectedValue()">
<table class="searchtbl" border=0>
    <tr>
  
    <td style="width:450px; font-weight:bold">
	<c:set var="subb" value="${sub}" />
	<c:choose>
    	<c:when test="${subb == 0}">
         선택된 과목 : 전체 과목
    	</c:when>
    		<c:otherwise>
        		<c:forEach var="cv" items="${courselist}">
            	<c:if test="${cv.cidx == subb}">
 		 선택된 과목 : ${cv.c_name} 
            	</c:if>
        	</c:forEach>
    		</c:otherwise>
	</c:choose>
	</td>
	
		<td class="sub">
		    <select class="searchsubject" name="subject" id="subject">
		        <option value="0">과목을 선택해주세요</option>
		        <c:forEach var="cv" items="${courselist}">
		           <option value="${cv.cidx}" <c:if test="${subb == cv.cidx}">selected</c:if>>${cv.c_name}</option>
		       </c:forEach>
		    </select>
		</td>

        
        <td><button type="submit" class="btn"><span class="material-symbols-outlined">
        screen_search_desktop
        </button></span></td>
 </tr>
</table>
</form>

      
   
    </div>
  </div>
</div>
    

</body>
</html>