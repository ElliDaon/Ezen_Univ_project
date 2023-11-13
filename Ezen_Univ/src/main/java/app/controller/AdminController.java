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
import app.domain.CourseTimeVo;
import app.domain.CourseVo;
import app.domain.MemberVo;


@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String location;
	public AdminController(String location) {
		this.location = location;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if(location.equals("accept.do")) {	// 가입승인 리스트
			
			AdminDao add= new AdminDao();
			ArrayList<MemberVo> slist = add.studentAll();
			ArrayList<MemberVo> plist = add.professorAll();
			
			request.setAttribute("slist", slist);
			request.setAttribute("plist", plist);
			
			String path = "/admin/accept.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("acceptStudentOk.do")) {	// 학생 1명에 대한 승인
			
			String sidx = request.getParameter("sidx");
			//System.out.println("sidx?"+sidx);
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.studentAccept(Integer.parseInt(sidx));
			
			//System.out.println("value?"+value);
			String str ="{\"value\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}else if(location.equals("acceptProfessorOk.do")) {	// 교수 1명에 대한 승인
			
			String pidx = request.getParameter("pidx");
			
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.professorAccept(Integer.parseInt(pidx));
			
			
			String str ="{\"value\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}else if(location.equals("acceptStudentNo.do")) {	// 학생 1명에 대한 거부
			
			String sidx = request.getParameter("sidx");
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.studentDeny(Integer.parseInt(sidx));
			
			//System.out.println("value?"+value);
			String str ="{\"value\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}else if(location.equals("acceptProfessorNo.do")) {	// 교수 1명에 대한 거부
			
			String pidx = request.getParameter("pidx");
			
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.professorDeny(Integer.parseInt(pidx));
			
			
			String str ="{\"value\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}else if(location.equals("acceptStudentAllOk.do")) {	// 체크된 학생들에 대한 승인
			
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
			
		}else if(location.equals("acceptStudentAllNo.do")) {	// 체크된 학생들에 대한 거부
			
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
			
		}else if(location.equals("acceptProfessorAllOk.do")) {	// 체크된 교수들에 대한 승인
			
			String[] selectedOptions = request.getParameterValues("professor");
			int[] intSelectedOptions = new int[selectedOptions.length];

			for (int i = 0; i < selectedOptions.length; i++) {
				intSelectedOptions[i] = Integer.parseInt(selectedOptions[i]);
			}
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.professorCheckedAccept(intSelectedOptions);
			
			if (value !=0) { 
				String path = request.getContextPath()+"/admin/accept.do";
				response.sendRedirect(path);
			}else {			
				String path = request.getContextPath()+"/admin/accept.do";
				response.sendRedirect(path);
			}
			
		}else if(location.equals("acceptProfessorAllNo.do")) {	// 체크된 교수들에 대한 거부
			
			String[] selectedOptions = request.getParameterValues("professor");
			int[] intSelectedOptions = new int[selectedOptions.length];

			for (int i = 0; i < selectedOptions.length; i++) {
				intSelectedOptions[i] = Integer.parseInt(selectedOptions[i]);
			}
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.professorCheckedADeny(intSelectedOptions);
			
			if (value !=0) { 
				String path = request.getContextPath()+"/admin/accept.do";
				response.sendRedirect(path);
			}else {			
				String path = request.getContextPath()+"/admin/accept.do";
				response.sendRedirect(path);
			}
			
		}else if(location.equals("courseRegister.do")) {	// 강의등록 페이지 이동
			String path = "/admin/courseRegister.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("courseRegisterList.do")) {	// 강의등록 현황
			String year = request.getParameter("year");
			String term = request.getParameter("term");

			int year_int = Integer.parseInt(year);
			int term_int = Integer.parseInt(term);
			
			AdminDao add= new AdminDao();
			ArrayList<CourseVo> list = add.courseRegisterList(year_int,term_int);
			
			int listCnt = list.size();	
			int cidx = 0;
			String c_name ="";
			int p_no = 0;
			String p_name ="";
			String c_major ="";
			int c_grade =0;
			String c_sep ="";	
			int c_score =0;
			String ct_room ="";
			String c_times ="";
			String str = "";
			
			for(int i=0; i< listCnt; i++){
				cidx = list.get(i).getCidx();
				c_name = list.get(i).getC_name();
				p_no = list.get(i).getP_no();
				p_name = list.get(i).getP_name();
				c_major = list.get(i).getC_major();
				c_grade = list.get(i).getC_grade();
				c_sep = list.get(i).getC_sep();
				c_score = list.get(i).getC_score();
				ct_room = list.get(i).getCt_room();
				c_times = list.get(i).getC_times();
				String comma = "";
				if(i == listCnt-1) { 
					comma = "";
					
				}else {
					comma = ",";
				}
				str = str +"{\"cidx\":\""+cidx+"\",\"c_name\":\""+c_name+"\",\"p_no\":\""+p_no+"\",\"p_name\":\""+p_name+"\",\"c_major\":\""+c_major+"\",\r\n"
						+ "\"c_grade\":\""+c_grade+"\",\"c_sep\":\""+c_sep+"\",\"c_score\":\""+c_score+"\",\"ct_room\":\""+ct_room+"\",\"c_times\":\""+c_times+"\"}"+comma;
			}
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}else if(location.equals("courseDelete.do")) {		// 등록된 강의 삭제
			String cidx = request.getParameter("cidx");
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.courseDelete(Integer.parseInt(cidx));
			
			String str ="{\"value\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
	
		}else if(location.equals("registerView.do")) {		// 등록된 강의 삭제
			String c_major = request.getParameter("c_major");
			System.out.println("c_major?"+c_major);
			
			AdminDao add= new AdminDao();
			ArrayList<MemberVo> list=add.registerView(c_major);
			
			System.out.println("list?"+list);
			int listCnt = list.size();
			int p_no = 0;
			String p_name ="";
			String str = "";
			
			for(int i=0; i< listCnt; i++){
				p_no = list.get(i).getP_no();
				p_name = list.get(i).getP_name();
				String comma = "";
				if(i == listCnt-1) { 
					comma = "";
					
				}else {
					comma = ",";
				}
				str = str +"{\"p_no\":\""+p_no+"\",\"p_name\":\""+p_name+"\"}"+comma;
			}
			System.out.println("str?"+str);
			PrintWriter out = response.getWriter();
			out.println("["+str+"]");

		}
		
		
		
	}

}
