<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
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

.list{
    background-color: black;
    border-radius: 5px;
    color: whitesmoke;
    text-decoration: none;
}
.container{
    display: flex;
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
    <h1>�޺��� ��������</h1>
        <table class="noticewrite">
            <tr class="subject">
                <td>����</td>
                <td>
                <select name="noticetype">
                    <option value="skip">�ް�</option>
                    <option value="sup">����</option>
                </select>
                </td>
                <td>
                    <select name="coursetype">
                        <option value="cidx1">������α׷���</option>
                        <option value="cidx2">�繰���ͳ����</option>
                        <option value="cidx3">�ý��ۼ���Ʈ�����</option>
                    </select>
                </td>
                <td>
                    <input type="date" name="when">
                </td>
            </tr>
            <tr>
                <td>
                    <textarea class="text-area"></textarea>

                </td>
            </tr>
            <tr>
                <td class="list1">
                    <a class="list" href="noticeList_p.jsp">���</a>
                    <button type="submit" class="writebtn">�۾���</button> 
                </td>
            </tr> 
        </table>
    </div>
</div>
</body>
</html>