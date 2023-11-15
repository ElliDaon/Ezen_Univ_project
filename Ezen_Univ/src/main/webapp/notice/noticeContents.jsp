<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
<link rel="stylesheet" href="../css/iframe.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<style>

h1{
    font-family: 'Black Han Sans', sans-serif;
    font-weight: 100;
    font-size: 40px;
    margin-bottom: 10px;
    margin-top : 10px;
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
    border: 3px solid #42444e;
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
    display: flex;
    background: #42444e;
    color : white;
    height: 36px ;
    width: 100%;
    font-size: 18px;
    font-weight: bold;
    padding : 5px;
}

.subject td{
    text-align: center;
    margin: 5px;
}

.noticeinfo{
	text-align : right;	
   
    height: 40px;
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

.modify{
    background: #42444e;

    width: 40px;
    height: 38px;
    font-size: 15;
    text-align: center;
    vertical-align: middle;
    color: white;
    border-radius: 5px;
    font-weight: bold; 
}
.delete{
    background: #42444e;

    width: 40px;
    height: 38px;
    font-size: 15;
    text-align: center;
    vertical-align: middle;
    color: white;
    border-radius: 5px;
    font-weight: bold;
     
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
        <h1>휴보강 공지사항</h1>
        <table class="noticewrite">
        <tr class="subject">
            <td>제목 &nbsp; :</td>
            <td>&nbsp;&nbsp;&nbsp; [${nv.n_category}][${nv.n_skipdate}][${nv.c_name}]
            </td>        
        </tr>
        <tr class="noticeinfo">
        	<td>
        	<strong>조회수</strong> : ${nv.n_count} &nbsp;&nbsp;  <strong>작성일자</strong> : ${nv.n_writeday} &nbsp;&nbsp; <strong>작성자</strong> : ${nv.p_name}
       		</td>
       		
        </tr>
        <tr>
            <td class="text-box">
                ${nv.n_contents}
            </td>
        </tr>
        <tr>
            <td class="list">
                <a class="link" href="noticeList_p.do"><span class="material-symbols-outlined">
                    list_alt
                    </span></a>
            
                <div>
                <button type="button" class="modify" onclick="location.href='<%=request.getContextPath()%>/notice/noticeModify.do?nidx=${nv.nidx}'">수정</button>
                <button type="button" class="delete" onclick="if (confirm('정말 삭제하시겠습니까?')) window.location.href='<%=request.getContextPath()%>/notice/noticeDelete.do?nidx=${nv.nidx}'">삭제</button>
                </div>
            </td>
        </tr> 
        </table>
    </div>
</div>

</body>
</html>