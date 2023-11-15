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
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">


<style>


    *{
        margin: 0;
        padding: 0;  
    }
    body{
        text-align: center;
    }
    h1{
        font-family: 'Black Han Sans', sans-serif;
        font-weight: 100;
        font-size: 40px;
        margin-bottom: 20px;
    }
    
    
    .pagination .act{
            font-weight: bold;
            color: #42444e;
            border-radius: 5px;
            border: 2px solid #42444e;
            padding: 5px 7px;
        }
    
    
    .pagination a {
            
            display: block;
            font-size: 15px;
            text-decoration: none;
            padding: 5px 7px;
            color: #42444e;
            display: inline-block;
        }
    
    .pagination a:hover {background-color: #ddd;}
    
    a:hover {
        
        text-decoration: underline;
       
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
    .noticelist{
      border-collapse: separate;
      border-spacing: 0;
      }
    
    .noticelist th{
        padding: 6px 15px;
        background: #42444e;
         color: #fff;
          text-align: center;
    }
    
    
    .noticelist tbody tr:hover{
        background-color: aliceblue;
    }
    
    .noticelist tbody tr{
    
        height: 50px;
        padding: 6px 15px;
    
    }
    .new {
       color: orange;
       font-weight: 2000;
    }
    
    .nidx, .viewcnt, .writeday{
        color: gainsboro;
    }
    
    .btn{
        background-color: #42444e;
        border-radius: 5px;
        color: whitesmoke;
    }
    
    
    .writediv{
        width: 80px;
        height: 30px;
        background-color: #42444e;
        border-radius: 5px;
        margin-top: 20px;     
        align-items: right;
        text-align: center;
        font-weight: bold;
        padding-top: 7px;    
    }
    
    .writediv a{
        text-align: center;
        color: whitesmoke;
        text-decoration: none;
    }
    
    
    .contents{
        color: black;
        text-decoration: none;
    }
    
    .contents:hover{
        text-decoration: underline;
    }
    
    .sub{
        
        padding : 8px;
        font-size : 14px;
    }
    
    .searchsubject{
        font-size : 14px;
        height : 30px;
        border : 2px solid black;
    }
    
    .material-symbols-outlined{
        font-size: 30ox;
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
        <a href="${pageContext.request.contextPath}/notice/noticeList_s.do?page=${pm.endPage+1}">
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
method="post">
<table border=0>
    <tr>
        <td style="width:500px"></td>
        <td class="sub">
            <select class="searchsubject" name="subject">
            <c:forEach var="cv" items="${courselist}">
                <option value="${cv.cidx}">${cv.c_name}</option>
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
    

</body>
</html>