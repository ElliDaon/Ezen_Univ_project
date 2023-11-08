<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        body{
            background: #DEDFEA;
        }
        a{
            text-decoration: none;
            color: blue;
        }
        a:hover{
            color:azure;
        }
    </style>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
    $(document).ready(function(){
		  studentInfo();
    });
    /* $.studentInfo = function(){
    	$.ajax({
    		type : "get",
    		url : "${pageContext.request.contextPath}/member/studentState.do",
    		dataType : "json",
    		cache : false,
    		success : function(data){
    			alert("data");
    			studentInfo(data);
    		},
    		error : function(){
    			alert("실패");
    		}
    		
    	});
    } */
    function studentInfo(){
    	

    	var str = "";
    	
    	var s_no =${sessionScope.s_no};
    	var s_name = "${sessionScope.s_name}"
    	var s_major = "${sessionScope.s_major}";
    	
    	str = "<strong>[학생]</strong><br>"
    		 + s_name + "("+ s_no +")<br>"
    		 + "[" + s_major + "]";
    	
    	$("#myinfo").html(str);
    	return;
    }
</script>
</head>
<body>
    <div id="myinfo" class="myinfo" style="margin-top:30px">
        
    </div>
        <a href="<%=request.getContextPath()%>/member/memberLogout.do" target="_parent">logout</a>
</body>
</html>