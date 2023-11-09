<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
        <h1>�޺��� ����</h1>
        <table class="noticelist" border=1 style="width:800px;" >	
            <thead>
                <tr>
                    <th style="width: 100px;">�۹�ȣ</th>
                    <th>����</th>
                    <th>�ۼ���</th>
                    <th>��ȸ��</th>
                </tr>
            </thead>
            <tbody style="border: 0;" >	
                <tr>
                    <th class="nidx">10</th>
                    <th class="title"><span class="new">new</span><a class="contents" href="noticeContents.jsp">[�ް�][2023-11-06][������α׷��� ��� �� �ǽ�]</a></th>
                    <th class="writeday">2023-11-04</th>
                    <th class="viewcnt">15</th>   
                </tr>
                <tr>
                    <th class="nidx">9</th>
                    <th class="title"><span class="new">new</span><a class="contents" href="noticeContents.jsp">[����][2023-11-05][������α׷��� ��� �� �ǽ�]</a></th>
                    <th class="writeday">2023-11-04</th>
            <th class="viewcnt">15</th>   
            </tr>
            <tr>
                <th class="nidx">8</th>
                <th class="title"><a class="contents" href="noticeContents.jsp">[�ް�][2023-11-11][�ý��� ����Ʈ���� ����]</a></th>
                <th class="writeday">2023-11-01</th>
                <th class="viewcnt">13</th>   
            </tr>
            <tr>
                <th class="nidx">7</th>
                <th class="title"><a class="contents" href="noticeContents.jsp">[����][2023-11-01][�ý��� ����Ʈ���� ����]</a></th>
                <th class="writeday">2023-11-01</th>
                <th class="viewcnt">13</th>   
            </tr>
            <tr>
                <th class="nidx">6</th>
                <th class="title"><a class="contents" href="noticeContents.jspl">[�ް�][2023-11-13][�ý��� ����Ʈ���� ����]</a></th>
                <th class="writeday">2023-10-27</th>
                <th class="viewcnt">12</th>   
            </tr>
            <tr>
                <th class="nidx">5</th>
                <th class="title"><a class="contents" href="noticeContents.jsp">[�ް�][2023-11-08][�ý��� ����Ʈ���� ����]</a></th>
                <th class="writeday">2023-10-27</th>
                <th class="viewcnt">12</th>   
            </tr>
            <tr>
                <th class="nidx">4</th>
                <th class="title"><a class="contents" href="noticeContents.jsp">[�ް�][2023-11-04][�ý��� ����Ʈ���� ����]</a></th>
                <th class="writeday">2023-10-27</th>
                <th class="viewcnt">12</th>   
            </tr>
            <tr>
                <th class="nidx">3</th>
                <th class="title"><a class="contents" href="noticeContents.jsp">[�ް�][2023-11-04][�ý��� ����Ʈ���� ����]</a></th>
                <th class="writeday">2023-10-27</th>
                <th class="viewcnt">12</th>   
            </tr>
            <tr>
                <th class="nidx">2</th>
                <th class="title"><a class="contents" href="noticeContents.jsp">[�ް�][2023-11-07][�ý��� ����Ʈ���� ����]</a></th>
                <th class="writeday">2023-10-27</th>
                <th class="viewcnt">12</th>   
            </tr>
            <tr>
                <th class="nidx">1</th>
                <th class="title"><a class="contents" href="noticeContents.jsp">[�ް�][2023-11-06][�ý��� ����Ʈ���� ����]</a></th>
                <th class="writeday">2023-10-27</th>
                <th class="viewcnt">12</th>   
            </tr>
        </tbody>
    </table>

    <table>
        <tr>
            <td style="width:700px"></td>
            <td>
                <div class="writediv"> 
                    <a class="noticeWrite" href="noticeWrite.do">
                        �۾���
                    </a>
                </div>
            </td>
        </tr>
    </table>
    <br>

    <div class="pagination">
        <a href="#" class="first" title="ù�������� �̵�">&lt;&lt;</a>
        <a href="#" class="btnMove next" title="���� �������� �̵�">&lt;</a>
        
        <span>
            <a href="#" id="page1" title="1 �������� �̵�">1</a>
            <a href="#" id="page2" title="2 �������� �̵�">2</a>
            <a href="#" id="page3" title="3 �������� �̵�">3</a>
            <a href="#" id="page4" title="4 �������� �̵�">4</a>
            <a href="#" id="page5" title="5 �������� �̵�">5</a>
            <a href="#" id="page6" title="6 �������� �̵�">6</a>
            <a href="#" id="page7" title="7 �������� �̵�">7</a>
            <a href="#" id="page8" title="8 �������� �̵�">8</a>
            <a href="#" id="page9" title="9 �������� �̵�">9</a>
            <a href="#" id="page10" title="10 �������� �̵�">10</a>
        </span>

       
        <a href="#" class="btnMove next" title="���� �������� �̵�">&gt;</a>
        <a href="#" class="btnMove last" title="���������� �̵�">&gt;&gt;</a>    
    </div> 
    <br>
    
    <form class="search-form" method="post">
        <table border=0>
            <tr>
                <td style="width:500px"></td>
                <td>
                    <select name="searchType">
                        <option value="subject">����</option>
                        <option value="writer">�ۼ���</option>
                    </select>
                </td>
                <td><input type="text" class="keyword" placeholder="�˻�� �Է����ּ���." size=20></td>
                <td><input type="submit" class="btn" value="�˻�"></td>
            </tr>
        </table>
    </form>
            
            
    </div>
</div>
    

</body>
</html>