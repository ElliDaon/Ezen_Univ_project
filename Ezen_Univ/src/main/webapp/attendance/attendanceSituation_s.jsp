<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "app.domain.*" %>
<%
//포워든 공유속성때문에 넘겨받을 수 있다
//ArrayList<AttendanceVo> list = null;
//list = (ArrayList<AttendanceVo>)request.getAttribute("list"); %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="../css/iframe.css">
    <link rel="stylesheet" href="../css/attendanceSituation.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	            <iframe src = "../leftmenu/attendance_s.jsp" width="100%" height="466"></iframe>
	        </div>
	    </div>
	    <div class="contents">
            <h3>출석현황조회</h3>
            <div class="first_line">
                년도 <input type="text" name="year" value="2023" disabled/> 학기 <input type="text" name="turm" value="1" disabled/>
            </div>
            <div class="list_table">
                <table>
                    <thead>
                        <tr>
                            <td style="width:10px">NO</td>
                            <td style="width:30px">이수구분</td>
                            <td style="width:50px">과목명</td>
                            <td style="width:10px">학점</td>
                            <td style="width:30px">교수</td>
                            <td style="width:30px">강의실</td>
                            <td style="width:40px">시간표</td>
                            <td style="width:30px">결석률/미달여부</td>
							<td style="width:30px">비고</td>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="av" items="${list}">
                        <tr>
                            <td>1</td>
                            <td>${av.c_sep}</td>
                            <td>${av.c_name}</td>
                            <td>${av.c_score}</td>
                            <td>${av.p_name}</td>
                            <td>${av.ct_room}</td>
                            <td>${av.c_times}</td>
                            <td></td>
                            <td></td>
                        </tr>
                       </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="contents_details">
	            <div class="details_first_line">
	            	출석 <input type="text" name="attendance" value="20" disabled/> 지각 <input type="text" name="late" value="5" disabled/>
	            	 조퇴 <input type="text" name="leave_early" value="3" disabled/> 결석 <input type="text" name="absent" value="3" disabled/>
	            </div>
	            <div class="mytable">
	                <table>
	                    <thead>
	                        <tr>
	                            <td style="width:30px">주차</td>
	                            <td style="width:200px">수업일 및 시간</td>
	                            <td style="width:100px">출결 현황</td>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <tr>
	                            <td>1</td>
	                            <td>03월 02일 10:00~10:50</td>
	                            <td>출석</td>
	                        </tr>
							<tr>
	                            <td></td>
	                            <td>03월 02일 11:00~11:50</td>
	                            <td>출석</td>
	                        </tr>
	                        <tr>
	                            <td>2</td>
	                            <td>03월 09일 10:00~10:50</td>
	                            <td>지각</td>
	                        </tr>
	                        	<tr>
	                            <td></td>
	                            <td>03월 09일 11:00~11:50</td>
	                            <td>지각</td>
	                        </tr>
	                        <tr>
	                            <td>3</td>
	                            <td>03월 16일 10:00~10:50</td>
	                            <td>결석</td>
	                        </tr>
							<tr>
	                            <td></td>
	                            <td>03월 16일 11:00~11:50</td>
	                            <td>결석</td>
	                        </tr>
	                        <tr>
	                            <td>4</td>
	                            <td>03월 23일 10:00~10:50</td>
	                            <td>출석</td>
	                        </tr>
	                        	<tr>
	                            <td></td>
	                            <td>03월 23일 11:00~11:50</td>
	                            <td>출석</td>
	                        </tr>
	                    </tbody>
	                </table>
	            </div>
            </div>
        </div>
	</div>

</body>
</html>