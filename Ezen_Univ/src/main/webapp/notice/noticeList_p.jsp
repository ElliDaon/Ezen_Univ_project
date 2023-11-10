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
<link rel="stylesheet" href="../css/noticelist_p.css">

</head>
<body>
<div class="header">
    <iframe src = "../main/navigation_p.jsp" width = "100%" height="55" ></iframe>
</div>
<div class="wrapper">
    <div class="sidebar">
        <div class="myinfo">
            <iframe src = "../leftmenu/myinfo_p.jsp" width="100%" height="200"></iframe>
        </div>
        <div class="menubar">
            <iframe src = "../leftmenu/notice_p.jsp" width="100%" height="100%"></iframe>
        </div>
    </div>
    
    <div class="container">
        <h1>휴보강 공지</h1>
 
        <table class="noticelist" border=1 style="width:800px;" >	
            <thead>
                <tr>
                    <th style="width: 100px;">글번호</th>
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

<table border=0 style="width:600px;text-align:center;">
<tr>
<td style="width:100px;text-align:right;">
<%// if (pm.isPrev()==true) { %>
<c:if test="${pm.prev == true}">
<a href="${pageContext.request.contextPath}/notice/noticeList_p.do?page=${pm.startPage-1}${parm}">
◀
</a>
</c:if>
<%//} %>
</td>
<td> 
<% 
//for(int i=pm.getStartPage();i<=pm.getEndPage();i++){
%>
<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1">

<a href="${pageContext.request.contextPath}/notice/noticeList_p.do?page=${i}${parm}">${i}</a> &nbsp;
<%		
//} 
%>
</c:forEach>
</td>
<td style="width:100px;text-align:left;">
<% //if(pm.isNext() ==true && pm.getEndPage()>0){ %>
<c:if test="${pm.next == true&&pm.endPage>0}">
<a href="${pageContext.request.contextPath}/notice/noticeList_p.do?page=${pm.endPage+1}">
▶
</a>
<%//} %>
</c:if>
</td>
</tr>
</table>
	
   
    <br>
    
<form name="frm" 
action="${pageContext.request.contextPath}/notice/noticeList_p.do"
method="post">
        <table border=0>
            <tr>
                <td style="width:500px"></td>
                <td>
                    <select name="subject">
                    <c:forEach var="cv" items="${courselist}">
                        <option value="${cv.cidx}">${cv.c_name}</option>
                        </c:forEach>
                    </select>
                </td>
                
                <td><input type="submit" class="btn" value="검색"></td>
            </tr>
        </table>
</form>
  
      
   
    </div>
 
</div>
    

</body>
</html>