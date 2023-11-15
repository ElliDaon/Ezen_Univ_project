<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
<link rel="stylesheet" href="../css/iframe.css">
<style>

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
.link{
    background-color: black;
    border-radius: 5px;
    color: whitesmoke;
    text-decoration: none;
    padding: 3px;
    font-size: 0.85em;  
}
.container{
    display: flex;
} 
.text-box{
    width: 100%;
    border: 2px solid black;
    height: 500px;
}

.noticewrite{
    border-collapse: collapse;
    width: 80%;
}

.contents {
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
    text-align: center;
    margin: 5px;
}

.noticeinfo{
	text-align : right;	
}

</style>
</head>
<body>
    <div class="header">
        <iframe src = "../main/navigation_s.jsp" width = "100%" height="55" ></iframe>
    </div>
    <div class="container">
        <div class="sidebar">
            <div class="myinfo">
                <iframe src = "../leftmenu/myinfo_s.jsp" width="100%" height="200"></iframe>
            </div>
            <div class="menubar">
                <iframe src = "../leftmenu/notice_s.jsp" width="100%" height="100%"></iframe>
            </div>
        </div>
    <div class="contents">
        <h1>휴보강 공지사항</h1>
        <table class="noticewrite">
        <tr class="subject">
            <td>제목</td>
            <td>[${nv.n_category}][${nv.n_skipdate}][${nv.c_name}]
            </td>        
        </tr>
        <tr class="noticeinfo">
        	<td>
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
                <a class="link" href="noticeList_p.do">목록</a>
            

            </td>
        </tr> 
        </table>
    </div>
</div>
</body>
</html>