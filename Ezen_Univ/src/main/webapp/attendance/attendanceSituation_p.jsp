<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>출석 현황 조회</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="../css/iframe.css">
    <link rel="stylesheet" href="../css/attendanceSituation.css">
    <style>
        /* 추가한 스타일 */


        .attendlist{
            display: none;
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
                년도 <input type="text" name="year" value="2023" disabled/> 학기 <input type="text" name="turm" value="1" disabled/>
            </div>
            <div class="list_table">
                <table>
                    <thead>
                        <tr>
                            <td style="width:10px">NO</td>
                            <td style="width:50px">과목명</td>
                            <td style="width:30px">강의실</td>
                            <td style="width:30px">시간표</td>
                            <td style="width:30px">이수구분</td>
                            <td style="width:30px">수강인원</td>
                            <td style="width:10px">출석률</td>
                        </tr>
                        
                    </thead>
                    <tbody>

                        <tr>
                            <td>1</td>
                            <td class="subject-cell"><a href="javascript:void(0);" class="subject-link">생활영어 1</a></td>
                            <td>문화관505</td>
                            <td>월3 월4</td>
                            <td>교양필수</td>
                            <td>20</td>
                            <td>78%</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td class="subject-cell"><a href="javascript:void(0);" class="subject-link">대인관계능력</a></td>
                            <td>문화관502</td>
                            <td>화1 화2</td>
                            <td>교양필수</td>
                            <td>20</td>
                            <td>80%</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>보건교육학</td>
                            <td>문화관504</td>
                            <td>월5 월6</td>
                            <td>교양선택</td>
                            <td>20</td>
                            <td>85%</td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>치아형태학</td>
                            <td>보건관203</td>
                            <td>목2 목3 목4</td>
                            <td>전공필수</td>
                            <td>24</td>
                            <td>92%</td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td>치위생학개론</td>
                            <td>보건관203</td>
                            <td>화1 화2</td>
                            <td>전공필수</td>
                            <td>30</td>
                            <td>96%</td>
                        </tr>
                    </tbody>
                </table>
            </div>
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