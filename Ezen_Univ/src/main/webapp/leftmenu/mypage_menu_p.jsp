<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../css/mypage_menu_style.css">
    <script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <div class="menuarea">
        <ul>
            <li>
                <div class="topmenu_name">
                    마이페이지
                </div>
            </li>
            <li class="personalinfo">
                <i class="fa fa-user-circle" aria-hidden="true"></i>
                개인정보
                <ul>
                    <li><a href="../mypage/personalinfo_p.do" target="_parent">- 개인정보</a></li>
                    <li><a href="../mypage/modifyinfo_p.do" target="_parent">- 개인정보 수정</a></li>
                </ul>
            </li>
            <li class="personalinfo">
                <i class="fa fa-book" aria-hidden="true"></i>
                강의정보
                <ul>
                    <li><a href="../mypage/courseList_p.do" target="_parent">- 강의 현황</a></li>
                    <li><a href="../mypage/searchP_table_p.do" target="_parent">- 강의 현황</a></li>
                </ul>
            </li>
        </ul>
    </div>
</body>
</html>