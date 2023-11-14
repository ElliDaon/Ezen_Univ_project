<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- %
 if (session.getAttribute("pidx") ==null){
	 out.println("<script>alert('로그인하셔야 합니다.');location.href='"+request.getContextPath()+"/member/memberLogin.do'</script>");	 
 }

%-->    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	//처리하기위해 이동하는 주소
	fm.action ="<%=request.getContextPath()%>/notice/noticeWriteAction.do";  
	fm.method = "post";  //이동하는 방식  get 노출시킴 post 감추어서 전달
	fm.submit(); //전송시킴
	return;
}

</script>

<link rel="stylesheet" href="../css/iframe.css">
<style>
.subject {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
}
.writebtn{
    background-color: black;
    border-radius: 5px;
    color: whitesmoke;
    text-decoration: none; 
}
.list1{
    display: flex;
    justify-content: space-between;
    align-items: center;
 
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
    border: 2px solid black;
    height: 500px;
}

.noticewrite{
    border-collapse: collapse;
    width: 80%;
}

.contents{
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-left: -70px;        
}

.subject{
    display: flex;
    border-bottom: 3px solid black;
    border-top: 3px solid black;
}

.subject td{ 
    margin: 5px;
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
            <td>제목</td>
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
                <a class="list" href="noticeList_p.jsp">목록</a>
            
                <input type="submit" class="writebtn" value="글쓰기" onclick="check();" ></input> 
            </td>
        </tr> 
        </table>
        </form>
       
        
        </div>
    </div>
</body>
</html>