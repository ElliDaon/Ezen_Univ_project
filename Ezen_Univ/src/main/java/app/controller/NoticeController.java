package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.w3c.dom.CDATASection;

import app.dao.CourseDao;
import app.dao.NoticeDao;
import app.domain.CourseVo;
import app.domain.NoticeVo;
import app.domain.PageMaker;
import app.domain.SearchCriteria;

@WebServlet("/NoticeController")
public class NoticeController {

	private String location;
	public NoticeController(String location) {
		this.location = location;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(location.equals("noticeWrite.do")) {
			 
			 PrintWriter out = response.getWriter();
			 HttpSession session = request.getSession();
			 
			 if(session.getAttribute("pidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			 }
			 
			 int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			 NoticeDao nd = new NoticeDao();
			 
			 ArrayList<CourseVo> courselist = nd.courselist_p(pidx);
			 
			 request.setAttribute("courselist", courselist);
			 
			 String path ="/notice/noticeWrite.jsp";
			 
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
				
			
		}else if(location.equals("noticeWriteAction.do")) {
			

			HttpSession session = request.getSession();
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			
			String noticetype = request.getParameter("noticetype");
			int coursetype = Integer.parseInt(request.getParameter("coursetype"));
			String when = request.getParameter("when");
			String contents = request.getParameter("contents");
	
			
			//2. 받은값을 입력한다
			
			NoticeVo nv = new NoticeVo();
			nv.setN_category(noticetype);
			nv.setN_skipdate(when);
			nv.setN_contents(contents);
			nv.setCidx(coursetype);
			nv.setPidx(pidx);
	
			
			NoticeDao nd = new NoticeDao();
			int value = nd.noticeWrite(nv);
			
			//3. 처리가 끝났으면 새롭게 이동한다
			if (value ==0) { //입력 안되었으면 입력페이지
				
				String path = request.getContextPath()+"/notice/noticeWrite.do";
				response.sendRedirect(path);
			}else {	//입력되었으면 리스트 페이지로 이동		
				String path = request.getContextPath()+"/notice/noticeList_p.do";
				response.sendRedirect(path);
			}

		}else if (location.equals("noticeList_p.do")) {	
			
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("pidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			}
			
			String subject = request.getParameter("subject");
			if (subject ==null) subject="0";			
			String page = request.getParameter("page");
			if (page ==null) page ="1";
			
			String sub = request.getParameter("subject");
			request.setAttribute("sub", sub);
			
			SearchCriteria scri = new SearchCriteria();
			scri.setPage(Integer.parseInt(page));	

			int cidx = Integer.parseInt(subject);
			scri.setSubject(cidx);
			
			
			
			
			PageMaker pm = new PageMaker();
			pm.setScri(scri);
			
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();			
						
			NoticeDao nd = new NoticeDao();
			ArrayList<CourseVo> courselist = nd.courselist_p(pidx);
			
			ArrayList<NoticeVo> alist  = nd.getList_p(pidx,scri);
			
			
			int cnt = nd.noticeTotalCount_p(pidx,scri);
			pm.setTotalCount(cnt);
						
			request.setAttribute("pm", pm);
			request.setAttribute("alist", alist);
			request.setAttribute("courselist", courselist);
			
			String path ="/notice/noticeList_p.jsp";
			 //화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);	
		
		}else if (location.equals("noticeList_s.do")) {	
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("sidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			}
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();	
			
			String sub = request.getParameter("subject");
			request.setAttribute("sub", sub);
			
			String subject = request.getParameter("subject");
			if (subject ==null) subject="0";			
			String page = request.getParameter("page");
			if (page ==null) page ="1";
					
			
			SearchCriteria scri = new SearchCriteria();
			scri.setPage(Integer.parseInt(page));	

			int cidx = Integer.parseInt(subject);
			scri.setSubject(cidx);
			
			PageMaker pm = new PageMaker();
			pm.setScri(scri);
			
				
						
			NoticeDao nd = new NoticeDao();
			ArrayList<CourseVo> courselist = nd.courselist_s(sidx);
			
			ArrayList<NoticeVo> alist  = nd.getList_s(sidx,scri);
			
			int cnt = nd.noticeTotalCount_s(sidx,scri);
			pm.setTotalCount(cnt);
						
			request.setAttribute("pm", pm);
			request.setAttribute("alist", alist);
			request.setAttribute("courselist", courselist);
			
			String path ="/notice/noticeList_s.jsp";
			 //화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);	
		
		}
		
		else if(location.equals("noticeContents_p.do")) {
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("pidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			}
			
			String nidx = request.getParameter("nidx");
			int nidx_int = Integer.parseInt(nidx);
			
			NoticeDao nd = new NoticeDao();
			int exec = nd.noticeCntUpdate(nidx_int);
			NoticeVo nv = nd.noticeSelectOne(nidx_int);	
			
			request.setAttribute("nv", nv);
			
			String path ="/notice/noticeContents_p.jsp";
			 //화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			 
		}else if(location.equals("noticeContents_s.do")) {
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("sidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			}
			String nidx = request.getParameter("nidx");
			int nidx_int = Integer.parseInt(nidx);
			
			NoticeDao nd = new NoticeDao();
			int exec = nd.noticeCntUpdate(nidx_int);
			NoticeVo nv = nd.noticeSelectOne(nidx_int);			
			
			request.setAttribute("nv", nv);
			
			String path ="/notice/noticeContents_s.jsp";
			 //화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			 
		}
		else if(location.equals("noticeDelete.do")) {
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			String nidx  = request.getParameter("nidx");
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			int nidx_int = Integer.parseInt(nidx);
			NoticeDao nd = new NoticeDao();
			int value=0;
			
			NoticeVo nv = nd.noticeSelectOne(nidx_int);
			value = nd.noticeDelete(nidx_int);			
			request.setAttribute("nv", value);
			
			if(pidx != nv.getPidx()) {
				
				out.println("<script>alert('권한이 없습니다.');location.href='"+request.getContextPath()+"/main/main_p.jsp'</script>");	

				
			}
				else {
				
				//처리가 되면 1이 아니고 아니면 0나오는 변수값  value
				
				if (value !=0) {
									
					response.getWriter().println("<script>alert('글이 삭제되었습니다.'); window.location.href='" + request.getContextPath() + "/notice/noticeList_p.do';</script>");				
					
				}else {
					String path = request.getContextPath()+"/notice/noticeDelete.do?nidx="+nidx;
					response.sendRedirect(path);				
				}	
			}
			
		}else if(location.equals("noticeModify.do")) {
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("pidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				
			}
			
						
			String nidx = request.getParameter("nidx");
			int nidx_int = Integer.parseInt(nidx);
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			
			NoticeDao nd = new NoticeDao();
			NoticeVo nv = nd.noticeSelectOne(nidx_int);
			ArrayList<CourseVo> courselist = nd.courselist_p(pidx);
			
			request.setAttribute("nv", nv);	
			request.setAttribute("courselist", courselist);
			
			String path= "";
			if(pidx != nv.getPidx()) {
				out.println("<script>alert('권한이 없습니다.');location.href='"+request.getContextPath()+"/main/main_p.jsp'</script>");	
			}
			else {
			    path ="/notice/noticeModify.jsp";
			}
			
			//화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
			 RequestDispatcher rd = request.getRequestDispatcher(path);
						 			 
			 rd.forward(request, response);
			 
		}else if(location.equals("noticeModifyAction.do")) { 
			HttpSession session = request.getSession();
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			
			String nidx = request.getParameter("nidx");
			String noticetype = request.getParameter("noticetype");
			int coursetype = Integer.parseInt(request.getParameter("coursetype"));
			String when = request.getParameter("when");
			String contents = request.getParameter("contents");
	
			
			//2. 받은값을 입력한다
			NoticeVo nv = new NoticeVo();
						
			nv.setNidx(Integer.parseInt(nidx));
			nv.setN_category(noticetype);
			nv.setN_skipdate(when);
			nv.setN_contents(contents);
			nv.setCidx(coursetype);
			nv.setPidx(pidx);
			
			
			NoticeDao nd = new NoticeDao();
			int value = nd.noticeModify(nv);
			
			PrintWriter out = response.getWriter();
			//3. 처리가 끝났으면 새롭게 이동한다
			if (value ==0) { //입력 안되었으면 입력페이지
				out.println("<script>alert('수정 불가');location.href='"+request.getContextPath()+"/notice/noticeModify.do?nidx="+nidx+"'</script>");	
				
			}else {	//입력되었으면 리스트 페이지로 이동		
				String path = request.getContextPath()+"/notice/noticeContents_p.do?nidx="+nidx;
				response.sendRedirect(path);
			}		
		
		}
		
		
		
	}
}
