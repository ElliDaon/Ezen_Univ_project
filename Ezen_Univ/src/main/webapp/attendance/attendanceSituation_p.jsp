<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "app.domain.*" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>출석 현황 조회</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="../css/iframe.css">
    <link rel="stylesheet" href="../css/attendanceSituation.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <style>
        /* 추가한 스타일 */
        .attendlist{
            display: none;
        }
        
        .countNo tbody>tr {
            counter-increment: aaa;
         }
        .countNo tbody>tr>td:first-child:before {
            content: counter(aaa) " ";
         }
    </style>
    
</head>
<body>
    <div class="header">
        <iframe src="../main/navigation_p.jsp" width="100%" height="55"></iframe>
    </div>
    <div class="container">
        <div class="sidebar">
            <div class="myinfo">
                <iframe src="../leftmenu/myinfo_p.jsp" width="100%" height="200"></iframe>
            </div>
            <div class="menubar">
                <iframe src="../leftmenu/attendance_p.jsp" width="100%" height="466"></iframe>
            </div>
        </div>
        <div class="contents">
            <h3>출석현황조회</h3>
            <div class="first_line">
                년도 <input type="text" name="year" value="${year}" disabled/> 학기 <input type="text" name="term" value="${semester}" disabled/>
            </div>
            <div class="list_table">
                <table class='countNo'>
                    <thead>
                        <tr>
                            <td style="width:10px">NO</td>
                            <td style="width:30px">이수구분</td>
                            <td style="width:50px">과목명</td>
                            <td style="width:30px">세부전공</td>
                            <td style="width:10px">수강학년</td>
                            <td style="width:30px">강의실</td>
                            <td style="width:30px">시간표</td>
                            <td style="width:30px">수강인원</td>
                            <td style="width:10px">출석률</td>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="av" items="${list}">
                        <tr>
                            <td></td>
                            <td>${av.c_sep}</td>
                            <td><button type="button" id="c_name" value="${av.cidx}" onclick="search_detail(${av.cidx})">${av.c_name}</button></td>
                            <td>${av.c_major}</td>
                            <td>${av.c_grade}</td>
                            <td>${av.ct_room}</td>
                            <td>${av.c_times}</td>
                            <td>${av.s_cnt}</td>
                            <td>%</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <br>
            <div class="attendance-input hidden">
                <input class="date" type="date" id="attendanceDate">
                <select id="timeSlot">
                    <option value="1">1교시</option>
                    <option value="2">2교시</option>
                    <option value="3">3교시</option>
                    <option value="4">4교시</option>
                    <option value="5">5교시</option>
                    <option value="6">6교시</option>
                    <option value="7">7교시</option>
                    <option value="8">8교시</option>
                    <option value="9">9교시</option>
                </select>
                <button id="showAttendanceList">출석 목록 보기</button>
            </div>
            <div id="selectedSubject"></div> <!-- 선택한 과목명을 표시할 요소 추가 -->
            
            
            <iframe class="attendlist" src="attendancetable.jsp" style="width: 100%; height: 45%;"></iframe>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $('.subject-link').click(function () {
                $('.attendance-input').toggleClass('hidden');
                const subjectName = $(this).text();
                $('#selectedSubject').text(`선택한 과목: ${subjectName}`);
            });
    
            $('#showAttendanceList').click(function () {
                // 사용자가 선택한 날짜와 교시를 가져옴
                const date = $('#attendanceDate').val();
                const timeSlot = $('#timeSlot').val();
    
                // 내부 iframe의 src를 업데이트하여 선택한 정보를 전달
                const iframe = document.querySelector('.attendlist');
                iframe.src = `attendancetable.jsp?date=${date}&timeSlot=${timeSlot}`;
    
                // iframe를 표시
                iframe.style.display = 'block';
            });
        });
    </script>
</body>
</html>