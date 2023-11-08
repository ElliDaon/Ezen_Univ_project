<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
		  professorInfo();
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
    function professorInfo(){
    	

    	var str = "";
    	
    	var p_no =${sessionScope.p_no};
    	var p_name = "${sessionScope.p_name}"
    	var p_major = "${sessionScope.p_major}";
    	
    	str = "<strong>[교수]</strong><br>"
    		 + p_name + "("+ p_no +")<br>"
    		 + "[" + p_major + "]";
    	
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