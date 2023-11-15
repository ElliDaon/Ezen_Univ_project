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
<link href="./css/board.css" type="text/css" rel="stylesheet">
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<link rel="stylesheet" href="../css/noticelist_s.css">


<style>
*{
    margin: 0;
    padding: 0;  
}
body{
    text-align: center;
}


a:hover {
    color: red;
   
}

a{
	text-decoration: none; 
    color: inherit; 
}

.container {
    display: inline;
    flex-direction: column;
    align-items: center;
    margin-left: 100px;
    margin-top: 10px;
}



.header{
    background-color: bisque;
    height: 10%;
}
iframe{
    border: 0;
    margin: 0;
    display: block;
}
.sidebar{
    display: inline;
    width: 10%;
    height: 100%;
    background-color: #DEDFEA;
}
.myinfo{
    display: block;
    width: 100%;
}
.menubar{
    display: block;     
    width: 100%;
    height: 100%;
}
.wrapper{
    display: flex;
    width: 100%;
    justify-content: flex-start;
}
.pagination{
    text-align: center;
    margin-top: -50px;
}
.pagination a{
    color: black;
    text-decoration: none;
}

.pagination a:hover{
    color:red;
    text-decoration: underline;
}

.pagination span a:focus{
    color: red;
    font-weight: bold;
}

.noticelist tbody tr:hover{
    background-color: aliceblue;
}

.noticelist tbody tr{

    height: 50px;

}
.new {
   color: orange;
   font-weight: 2000;
}

.nidx, .viewcnt, .writeday{
    color: gainsboro;
}

.btn{
    background-color: black;
    border-radius: 5px;
    color: whitesmoke;
}


.writediv{
    width: 80px;
    height: 25px;
    background-color: black;
    border-radius: 5px;
    margin-top: 10px;     
    
}

.writediv a{
    text-align: center;
    color: whitesmoke;
    text-decoration: none;
}

.writediv:hover{
background-color: white;
border: 1px solid black;
}

.writediv a:hover{
    color: black;
}

.contents{
    color: black;
    text-decoration: none;
}

.contents:hover{
    text-decoration: underline;
}


</style>

</head>
<body>
    <div class="header">
        <iframe src = "../main/navigation_s.jsp" width = "100%" height="55" ></iframe>
    </div>
    <div class="wrapper">
        <div class="sidebar">
            <div class="myinfo">
                <iframe src = "../leftmenu/myinfo_s.jsp" width="100%" height="200"></iframe>
            </div>
            <div class="menubar">
                <iframe src = "../leftmenu/notice_s.jsp" width="100%" height="100%"></iframe>
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
            <a href="${pageContext.request.contextPath}/notice/noticeContents_s.do?nidx=${nv.nidx}">
                <c:if test="${nv.n_dday eq 'true'}">
               <span style="color: orange; font-weight: bold;">new</span>
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

            </td>
        </tr>
    </table>
    <br>

<table border=0 style="width:600px;text-align:center;">
<tr>
<td style="width:100px;text-align:right;">
<%// if (pm.isPrev()==true) { %>
<c:if test="${pm.prev == true}">
<a href="${pageContext.request.contextPath}/notice/noticeList_s.do?page=${pm.startPage-1}${parm}">
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

<a href="${pageContext.request.contextPath}/notice/noticeList_s.do?page=${i}${parm}">${i}</a> &nbsp;
<%		
//} 
%>
</c:forEach>
</td>
<td style="width:100px;text-align:left;">
<% //if(pm.isNext() ==true && pm.getEndPage()>0){ %>
<c:if test="${pm.next == true&&pm.endPage>0}">
<a href="${pageContext.request.contextPath}/notice/noticeList_s.do?page=${pm.endPage+1}">
▶
</a>
<%//} %>
</c:if>
</td>
</tr>
</table>
	
   
    <br>
    
<form name="frm" 
action="${pageContext.request.contextPath}/notice/noticeList_s.do"
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