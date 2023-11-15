<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
 if (session.getAttribute("pidx") ==null){
	 out.println("<script>alert('로그인하셔야 합니다.');</script>");	 
 }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<script>
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
h1{
        font-family: 'Black Han Sans', sans-serif;
        font-weight: 100;
        font-size: 40px;
        
}


.subject {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
}
.writebtn{
    background: #42444e;
width: 70px;
height: 38px;
text-align: center;
color: white;
border-radius: 5px;
font-size:17px;
font-weight: bold;

}
.list1{
    display: flex;
    justify-content: space-between;
   
}

.material-symbols-outlined{


background: #42444e;
width: 40px;
height: 38px;
text-align: center;
color: white;
border-radius: 5px;
font-size:35px;
padding-top : 3px;
     
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
    background-color: black;
    border-radius: 5px;
    color: whitesmoke;
    text-decoration: none;
    
}
    
.text-area{
    width: 100%;
    border: 3px solid  #42444e;;
    height: 500px;
    margin-bottom: 10px;
}

.noticewrite{
    border-collapse: collapse;
  ;
}

.contents{
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-left: -70px;        
}

.subject{
    display: flex;
   
    border-top: 3px solid  #42444e;
}

.subject td{ 
    margin: 5px;
}
.btnlist{


    margin-top: 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
   
}

</style>

</head>
<body>
    <div class="header">
        <iframe src = "../main/navigation_p.jsp" width = "100%" height="55" ></iframe>
    </div>
    <div class="container">
        <div class="sidebar">
            <div class="myinfo">
                <iframe src = "../leftmenu/myinfo_p.jsp" width="100%" height="200"></iframe>
            </div>
            <div class="menubar">
                <iframe src = "../leftmenu/notice_p.jsp" width="100%" height="100%"></iframe>
            </div>
        </div> 
    <div class="contents">
        <h1>휴보강 공지등록</h1>
        
        <form name="frm">
        <table class="noticeWrite">
        <tr class="subject">
            <td><strong>제목</td>
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
                <textarea name="contents" class="text-area"></textarea>
            </td>
        </tr>
        <tr>
           
            <td class="list1">
    			<a class="list" href="noticeList_p.do" onclick="return confirm('글은 저장되지 않습니다. 정말 나가시겠습니까?')">
      				  <span class="material-symbols-outlined">list_alt</span>
   				</a>
                    <input type="button" class="writebtn" value="등록" onclick="check();" ></input> 
            </td>
            

        </tr>

        </table>


        </form>
       
        
        </div>
    </div>
</body>
</html>