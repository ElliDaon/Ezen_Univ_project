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
		
		if(location.equals("acceptlist.do")) {
			
			AdminDao add= new AdminDao();
			ArrayList<MemberVo> slist = add.studentAll();
			ArrayList<MemberVo> plist = add.professorAll();
			
			request.setAttribute("slist", slist);
			request.setAttribute("plist", plist);
			
			String path = "/admin/accept.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}else if(location.equals("acceptStudent.do")) {
			
			String sidx = request.getParameter("sidx");
			//System.out.println("sidx?"+sidx);
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.studentAccept(Integer.parseInt(sidx));
			
			//System.out.println("value?"+value);
			String str ="{\"value\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}
	}

}
