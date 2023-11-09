package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import app.dao.AdminDao;
import app.domain.MemberVo;


@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String location;
	public AdminController(String location) {
		this.location = location;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(location.equals("accept.do")) {
			
			AdminDao add= new AdminDao();
			ArrayList<MemberVo> slist = add.studentAll();
			ArrayList<MemberVo> plist = add.professorAll();
			
			request.setAttribute("slist", slist);
			request.setAttribute("plist", plist);
			
			String path = "/admin/accept.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}else if(location.equals("acceptStudentOk.do")) {
			
			String sidx = request.getParameter("sidx");
			//System.out.println("sidx?"+sidx);
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.studentAccept(Integer.parseInt(sidx));
			
			//System.out.println("value?"+value);
			String str ="{\"value\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}else if(location.equals("acceptProfessorOk.do")) {
			
			String pidx = request.getParameter("pidx");
			
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.professorAccept(Integer.parseInt(pidx));
			
			
			String str ="{\"value\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}else if(location.equals("acceptStudentNo.do")) {
			
			String sidx = request.getParameter("sidx");
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.studentDeny(Integer.parseInt(sidx));
			
			//System.out.println("value?"+value);
			String str ="{\"value\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}else if(location.equals("acceptProfessorNo.do")) {
			
			String pidx = request.getParameter("pidx");
			
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.professorDeny(Integer.parseInt(pidx));
			
			
			String str ="{\"value\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}else if(location.equals("acceptStudentAllOk.do")) {
			
			String[] selectedOptions = request.getParameterValues("student");
			int[] intSelectedOptions = new int[selectedOptions.length];

			for (int i = 0; i < selectedOptions.length; i++) {
				intSelectedOptions[i] = Integer.parseInt(selectedOptions[i]);
			}
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.studentCheckedAccept(intSelectedOptions);
			
			if (value !=0) { 
				String path = request.getContextPath()+"/admin/accept.do";
				response.sendRedirect(path);
			}else {			
				String path = request.getContextPath()+"/admin/accept.do";
				response.sendRedirect(path);
			}
			
		}else if(location.equals("acceptStudentAllNo.do")) {
			
			String[] selectedOptions = request.getParameterValues("student");
			int[] intSelectedOptions = new int[selectedOptions.length];

			for (int i = 0; i < selectedOptions.length; i++) {
				intSelectedOptions[i] = Integer.parseInt(selectedOptions[i]);
			}
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.studentCheckedADeny(intSelectedOptions);
			
			if (value !=0) { 
				String path = request.getContextPath()+"/admin/accept.do";
				response.sendRedirect(path);
			}else {			
				String path = request.getContextPath()+"/admin/accept.do";
				response.sendRedirect(path);
			}
			
		}
		
		
	}

}
