<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="../css/iframe.css">
    <link rel="stylesheet" href="../css/attmanage.css">
    <style>
        .container{
            display: flex;
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
        .contents{
            padding: 10px;
        }
        .std-list #btn{
            background: rgb(207, 247, 207);
            width: 50px;
            height: 25px;
        }
        .std-list #btn2{
            background: rgb(255, 187, 187);
            width: 50px;
            height: 25px;
        }
        .std-list table{
            width: 80%;
        }
    </style>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script type="text/javascript">
    
    $(document).ready(function(){
  	
		$('#professorAllList').hide(); //초기값
    		$("#view").on("click",function(){
	    	// 교수클릭시
	    	if($("input[name='MemberList']:checked").val() == 'professorAll'){
	    		$('#studentAllList').hide();
	    		$('#professorAllList').show();
	    	}// 학생클릭시
	    	else if($("input[name='MemberList']:checked").val() == 'studentAll'){
	    		$('#professorAllList').hide();
	    		$('#studentAllList').show();
	    	}
	    });
    });
    
     function acceptStudentOk(sidx){
    	
    	$.ajax({
    		type : "post",
    		url : "${pageContext.request.contextPath}/admin/acceptStudent.do?sidx="+sidx,
    		data:{"sidx":sidx},
    		dataType : "json",
    		cache : false,
    		success : function(data){
    			alert("통신성공");
    			document.location.href = document.location.href;		
    			
    		},
    		error : function(){
    			alert("통신오류 실패");			
    		}		
    	});	
    	
    	return;
    }
     
     function acceptProfessorOk(pidx){
     	
     	$.ajax({
     		type : "post",
     		url : "${pageContext.request.contextPath}/admin/acceptProfessor.do?pidx="+pidx,
     		data:{"pidx":pidx},
     		dataType : "json",
     		cache : false,
     		success : function(data){
     			alert("통신성공");
     			document.location.href = document.location.href;		
     			
     		},
     		error : function(){
     			alert("통신오류 실패");			
     		}		
     	});	
     	
     	return;
     }
    
    
    </script>
</head>
<body>

    <div class="header">
        <iframe src = "../main/navigation_a.jsp" width = "100%" height="55" ></iframe>
    </div>
    <div class="container">
        <div class="sidebar">
            <div class="myinfo">
                <iframe src = "../leftmenu/myinfo_a.jsp" width="100%" height="20%"></iframe>
            </div>
            <div class="menubar">
                <iframe src = "../leftmenu/accept_a.jsp" width="100%" height="100%"></iframe>
            </div>
        </div>
        <div class="contents">
            <div class="accept-list">
            <h3>회원가입 승인</h3>
                <div>
                    <tr>
                        <td>
                            <input type="radio" name="MemberList" value="studentAll" checked>학생
                            <input type="radio" name="MemberList" value="professorAll" >교수
                            <input type="button" name="bbtn" value="선택보기" id="view">
                        </td>
                        
                        <td>
                            <button>일괄승인</button>
                            <button>일괄거부</button>
                        </td>
                    </tr>

                </div>
       
                <!-- 학생리스트 -->
                <div id ="studentAllList" class="std-list">
                    <table>
                        <thead>
                            <tr>
                                <td style="width: 50px;">
                                    <input type="checkbox" name="student" value="selectAll" onclick="selectAtt(this)"/>
                                </td>
                                <td style="width: 50px;">순번</td>
                                <td style="width: 50px;">구분</td>
                                <td style="width: 100px;">이름</td>
                                <td style="width: 150px;">생년월일</td>
                                <td style="width: 150px;">이메일</td>
                                <td style="width: 200px;">전공</td>
                                <td colspan="2" width: 50px;>처리</td>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="mv" items="${slist}">
                            <tr>
                                <td>
                                    <input type="checkbox" name="student" value="${mv.sidx}">
                                </td>
                                <td>${mv.sidx}</td>
                                <td>학생</td>
                                <td>${mv.s_name}</td>
                                <td>${mv.s_birth}</td>
                                <td>${mv.s_email}</td>
                                <td>${mv.s_major}</td>
                                <td style="padding-right:10px">
                                    <button type="button" id="btn" onclick='acceptStudentOk(${mv.sidx})'>승인</button>
                                    <button type="button" id="btn2" onclick="acceptNo()">거부</button>
                                    
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- 교수리스트 -->
                
                <div id ="professorAllList" class="std-list">
                    <table>
                        <thead>
                            <tr>
                                <td style="width: 50px;">
                                    <input type="checkbox" name="professor" value="selectAll" onclick="selectAtt(this)"/>
                                </td>
                                <td style="width: 50px;">순번</td>
                                <td style="width: 50px;">구분</td>
                                <td style="width: 100px;">이름</td>
                                <td style="width: 150px;">생년월일</td>
                                <td style="width: 150px;">이메일</td>
                                <td style="width: 200px;">전공</td>
                                <td colspan="2" width: 50px;>처리</td>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="mv" items="${plist}">
                            <tr>
                                <td>
                                    <input type="checkbox" name="professor" value="${mv.pidx}">
                                </td>
                                <td>${mv.pidx}</td>
                                <td>교수</td>
                                <td>${mv.p_name}</td>
                                <td>${mv.p_birth}</td>
                                <td>${mv.p_email}</td>
                                <td>${mv.p_major}</td>
                                <td style="padding-right:10px">
                                    <button type="button" id="btn" onclick='acceptProfessorOk(${mv.pidx})'>승인</button>
                                    <button type="button" id="btn2" onclick="">거부</button>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script src="../js/acceptManage.js"></script>
</body>
</html>