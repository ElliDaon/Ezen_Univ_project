<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
function sendmail(){
var fm = document.rowlogin_form;

fm.action = "<%=request.getContextPath()%>/member/send_emailAction.do";
fm.method = "post"; 
fm.submit();
return;
}
</script>
<body>
<div class="col-lg-6">
  <div class="login_form_inner">
    <h3>인증코드 발급하기</h3>
    <form name="rowlogin_form" > 
      <div class="col-md-12 form-group">
        <input type="text" class="form-control" id="m_id" name="m_id" placeholder="아이디를 입력하세요"
               onfocus="this.placeholder = ''" onblur="this.placeholder = 'Username'">
      </div>
      <div class="col-md-12 form-group">
        <input type="email" class="form-control" id="m_email" name="m_email" placeholder="이메일을 입력하세요"
               onfocus="this.placeholder = ''" onblur="this.placeholder = 'Username'">
      </div>
      <div class="col-md-12 form-group">
        <button type="button" value="임시 비밀번호 발급받기" class="primary-btn" onclick="sendmail()">전송하기</button>
      </div>
    </form>
  </div>
</div>
</body>
</html>