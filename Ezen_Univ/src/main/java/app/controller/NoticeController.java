package app.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import app.dao.NoticeDao;
import app.domain.CourseVo;
import app.domain.NoticeVo;

@WebServlet("/NoticeController")
public class NoticeController {

	private String location;
	public NoticeController(String location) {
		this.location = location;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(location.equals("noticeWrite.do")) {
			
			 
			 HttpSession session = request.getSession();
			 int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			 
			 NoticeDao nd = new NoticeDao();
			 
			 ArrayList<CourseVo> courselist = nd.courselist(pidx);
			 
			 request.setAttribute("courselist", courselist);
			 
			 String path ="/notice/noticeWrite.jsp";
			 
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
				
			
		}else if(location.equals("noticeWriteAction.do")) {
			

			
			//String nidx = request.getParameter("nidx");
			
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
			//nv.setNidx(Integer.parseInt(nidx));
			
			NoticeDao nd = new NoticeDao();
			int value = nd.noticeWrite(nv);
			
			//3. 처리가 끝났으면 새롭게 이동한다
			if (value ==0) { //입력 안되었으면 입력페이지
				String path = request.getContextPath()+"/notice/noticeWrite.do";
				response.sendRedirect(path);
			}else {	//입력되었으면 리스트 페이지로 이동		
				String path = request.getContextPath()+"/notice/noticeList.do";
				response.sendRedirect(path);
			}

		}
	}
}
