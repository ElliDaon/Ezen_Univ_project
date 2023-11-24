<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList" %> 
<%@ page import="app.domain.*" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<link rel="stylesheet" href="../css/noticelist_s.css">
<link rel="stylesheet" href="../css/nav_style.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
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
    </script>

<style>
  .pagination td {
    border: 0px; 
  }

  .searchtbl td {
    border: 0px; 
  }
      .noticelist td {
        padding: 0.7em 0;
        border: 1px solid #ccc;
        text-align: center;
    }

    .noticelist tr {
        padding: 0.7em 0;
        border: 1px solid #ccc;
        text-align: center;
        
    }
</style>


</head>
<body>

<c:if test="${pm != null && pm.getTotalCount() == 0}">
    <script>alert('공지가 아직 등록되지 않았습니다.');</script>
</c:if>
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
        <h3>휴보강 공지</h3>
        <table class="noticelist" style="width:800px;" >
        	
            <thead>
                <tr style="font-weight: bold ;">
                    <th style="width: 100px;">No</th>
                    <th style="width: 500px;">제목</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
            </thead>
            
            <tbody>
              <tr>
       		<c:forEach var="nv" items="${alist}">
              
			<td style=" text-align: center;">
			${nv.nidx}
			</td>
			<td style="text-align: left; padding-left: 20px" class="subject">
            <a href="${pageContext.request.contextPath}/notice/noticeContents_s.do?nidx=${nv.nidx}">
                <c:if test="${nv.n_dday eq 'true'}">
               <span style="color: orange; font-weight: bold;">new</span>
                </c:if>
                ${nv.n_subject}
            </a>
		

			</td>

	
			<td style=" text-align: center;">
 			 ${nv.n_writeday.split(' ')[0]}
			</td>
			<td style=" text-align: center;">
			${nv.n_count}
			</td>
			
			</tr>
			</c:forEach>

        	</tbody>
    </table>

<c:set var="parm" value="&subject=${pm.scri.subject}" />
    <table>

    </table>
    <br>

    <table class="pagination" border=0 style="width:700px;text-align:center;">
        <tr>
        <td style="width:100px;text-align:right;">
        <%// if (pm.isPrev()==true) { %>
        <c:if test="${pm.prev == true}">
        <a href="${pageContext.request.contextPath}/notice/noticeList_s.do?page=${pm.startPage-1}${parm}">
        <span class="material-symbols-outlined">
        arrow_back_ios_new
        </span>
        </a>
        </c:if>
        <%//} %>
        </td>
        <td> 
        <% 
        //for(int i=pm.getStartPage();i<=pm.getEndPage();i++){
        %>
        
        <c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1">
        <c:choose>
        <c:when test="${i == pm.scri.page}">
        <a href="${pageContext.request.contextPath}/notice/noticeList_s.do?page=${i}${parm}"><div class="act">${i}</div></a> &nbsp;
        </c:when>
        <c:otherwise>
        <a href="${pageContext.request.contextPath}/notice/noticeList_s.do?page=${i}${parm}"><div class="de">${i}</div></a> &nbsp;
        </c:otherwise>
        </c:choose>
        </c:forEach>
        
        <%		
        //}
        
        %>
        </td>
        <td style="width:100px;text-align:left;">
        <% //if(pm.isNext() ==true && pm.getEndPage()>0){ %>
        <c:if test="${pm.next == true&&pm.endPage>0}">
        <a href="${pageContext.request.contextPath}/notice/noticeList_s.do?page=${pm.endPage+1}${parm}">
        <span class="material-symbols-outlined">
        arrow_forward_ios
        </span>
        </a>
        <%//} %>
        </c:if>
        </td>
        </tr>
        </table>
	
   
    <br>
    
<form name="frm" 
action="${pageContext.request.contextPath}/notice/noticeList_s.do"
method="post"
onsubmit="saveSelectedValue()">
<table class="searchtbl" border=0>
    <tr>
  
    <td style="width:450px; font-weight:bold">
  <span style="color:#0067b3;">
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
  </span>
	</td>
	
		<td class="sub">
		    <select class="searchsubject" name="subject" id="subject">
		        <option value="0">과목을 선택해주세요</option>
		        <c:forEach var="cv" items="${courselist}">
		           <option value="${cv.cidx}" <c:if test="${subb == cv.cidx}">selected</c:if>>${cv.c_name}</option>
		       </c:forEach>
		    </select>
		</td>

        
    <td><button style="background-color: color: #0067b3; border: 2px solid #0067b3;" type="submit" class="btn"><span class="material-symbols-outlined">
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