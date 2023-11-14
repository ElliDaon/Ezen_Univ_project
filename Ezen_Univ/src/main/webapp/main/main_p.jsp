<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="../css/main.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
	    <script>
        // 페이지가 로드된 후 실행되는 JavaScript 코드
        $(document).ready(function() {
            // iFrame에서 가져올 페이지의 URL
            var externalPageURL = "/Ezen_Univ/notice/noticeList_p.do";

            // Ajax 요청을 통해 외부 페이지의 내용 가져오기
            $.ajax({
                url: externalPageURL,
                type: 'GET',
                success: function(response) {
                    // 가져온 페이지에서 필요한 부분 선택
                    var containerContent = $(response).find('.noticelist').html();

                    // 현재 페이지의 특정 위치에 내용 추가
                    $('.externalContent').html(containerContent);
                },
                error: function(xhr, status, error) {
                    console.error('Error fetching external content:', error);
                }
            });
        });
    </script>
   
    <style>
    .notice{
    	width : 660px;
    	height : 200px;
    	overflow : scroll; 
    	margin : 50px;
    	
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
                <iframe src = "../leftmenu/myinfo_p.jsp" width="100%" height="100%"></iframe>
            </div>
        </div>
        <div class="contents">
            <div class="first-line">
                	
                <div class="notice">

                 
                    <div class="externalContent"></div>
					
                </div>
                <div class="banner" style="padding-top: 50px;">
                    <a href="https://www.cubeitac.com/" target="_blank"><img src="../images/banner.png" width="90%" height="150px"></a>
                </div>
            </div>
            <div class="p-table">
                <table class="table" id="mytable" style="font-size:12px; padding: 5px;">
                    <thead>
                        <tr>
                            <td style="width:5%; font-weight: bold; font-size: 15px;">교시</td>
                            <td style="width:15%; font-weight: bold; font-size: 15px;">월</td>
                            <td style="width:15%; font-weight: bold; font-size: 15px;">화</td>
                            <td style="width:15%; font-weight: bold; font-size: 15px;">수</td>
                            <td style="width:15%; font-weight: bold; font-size: 15px;">목</td>
                            <td style="width:15%; font-weight: bold; font-size: 15px;">금</td>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="tv" items="${tablelist}">
                        <tr>
                            <td>${tv.pe_period}</td>
                            <td>${tv.mon}</td>
                            <td>${tv.two}</td>
                            <td>${tv.wed}</td>
                            <td>${tv.thu}</td>
                            <td>${tv.fri}</td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script src="../js/main.js"></script>
</body>
</html>