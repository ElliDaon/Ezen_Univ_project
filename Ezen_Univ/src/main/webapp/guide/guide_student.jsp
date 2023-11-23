<%@ page isErrorPage="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.FileInputStream" %>   
<%@ page import="java.io.BufferedOutputStream" %> 
<%@ page import="java.io.File" %> 
<%@ page import="java.io.IOException" %>  
<%@ page import="javax.servlet.ServletContext" %>        
 <%
 
FileInputStream fis = null;
BufferedOutputStream bos = null;

//아래 두줄의 초기화 코드를 넣지 않으면 'java.lang.IllegalStateException' 발생 
out.clear();
out = pageContext.pushBody();
try{
	//여기서 역슬래시 하나만 사용할 경우 에러 발생
    ServletContext context = pageContext.getServletContext();
    String realPath = context.getRealPath("/");

    // 파일 경로 지정
    String fileName = realPath + "guide/guide_student.pdf";
    File file = new File(fileName);
    
    // 보여주기
    response.setContentType("application/pdf");
    response.setHeader("Content-Description", "JSP Generated Data");
 
    fis = new FileInputStream(file);
    int size = fis.available();
    
    byte[] buf = new byte[size];
    int readCount = fis.read(buf);
 
    response.flushBuffer();
 
    bos = new BufferedOutputStream(response.getOutputStream());
    bos.write(buf, 0, size);
    bos.flush();
} catch(Exception e) {
    response.setContentType("text/html;charset=UTF-8");
    out.println("<script language='javascript'>");
    out.println("alert('파일 오픈 중 오류가 발생하였습니다.');");
    out.println("</script>");
    e.printStackTrace();
} finally{
    try{
        if(fis != null) fis.close();
        if(bos != null) bos.close();
    } catch(IOException e){
        e.printStackTrace();
    }    
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>