package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

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
			value =add.studentCheckedDeny(intSelectedOptions);
			
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
			value =add.professorCheckedDeny(intSelectedOptions);
			
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
			ArrayList<CourseVo> list = add.courseListPrint(year_int,term_int);
			
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
	
		}else if(location.equals("registerView.do")) {		// 강의등록 조회시 교수번호,교수이름
			String c_major = request.getParameter("c_major");
			//System.out.println("c_major?"+c_major);
			
			AdminDao add= new AdminDao();
			ArrayList<MemberVo> list=add.courseRegisterCheck(c_major);
			
			//System.out.println("list?"+list);
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
			//System.out.println("str?"+str);
			PrintWriter out = response.getWriter();
			out.println("["+str+"]");

		}else if(location.equals("courseRegisterAction.do")) {		// 강의 등록
			
			String c_name = request.getParameter("c_name");
			String c_major = request.getParameter("c_major");
			String c_sep = request.getParameter("c_sep");
			String p_no = request.getParameter("p_no");
			String c_grade = request.getParameter("c_grade");
			String p_name = request.getParameter("p_name");
			String c_score = request.getParameter("c_score");
			String c_totaltime = request.getParameter("c_totaltime");
			String tableData = request.getParameter("tableData");	
			
			JSONParser parser = new JSONParser();
			// tableData를 JSON 배열로 파싱
			JSONArray jsonArray = null;
			try {
				jsonArray = (JSONArray) parser.parse(tableData);
			} catch (org.json.simple.parser.ParseException e) {
				
				e.printStackTrace();
			}
			
			ArrayList<CourseTimeVo> ctv = new ArrayList<>();
			// JSONArray를 순회하며 객체 가져오기
			for (Object obj : jsonArray) {
			    JSONObject jsonObject = (JSONObject) obj;

			    // 가져온 객체에서 필요한 값을 얻기
			    String ct_room = (String) jsonObject.get("room");
			    String ct_week = (String) jsonObject.get("day");
			    int pe_period = Integer.parseInt((String) jsonObject.get("period"));
			    int ct_semester = Integer.parseInt((String) jsonObject.get("semester"));
			    int ct_year = Integer.parseInt((String) jsonObject.get("year"));
			    
			    // CourseTimeVo 객체 생성
			    CourseTimeVo courseTimeVo = new CourseTimeVo();
			    courseTimeVo.setCt_room(ct_room);
			    courseTimeVo.setCt_week(ct_week);
			    courseTimeVo.setPe_period(pe_period);
			    courseTimeVo.setCt_semester(ct_semester);
			    courseTimeVo.setCt_year(ct_year);
			    
			    // 리스트에 추가
			    ctv.add(courseTimeVo);
			    
			}
			int value = 0;
			AdminDao add = new AdminDao();
			value = add.courseRegister(c_name,c_major,c_sep,p_no,c_grade,p_name,c_score,c_totaltime,ctv);
			
			if (value !=0) { 
				String path = request.getContextPath()+"/admin/courseRegister.do";
				response.sendRedirect(path);
			}else {			
				String path = request.getContextPath()+"/admin/accept.do";
				response.sendRedirect(path);
			}
	
		}else if(location.equals("courseEnroll.do")) {	// 수강등록 페이지 이동
			String path = "/admin/courseEnroll.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("courseMatchStudent.do")) {	// 수강등록 학생리스트
			String cidx = request.getParameter("courseId");
			
			int value = 0;
			AdminDao add= new AdminDao();
			ArrayList<MemberVo> list = add.courseMatchStudentList(Integer.parseInt(cidx));
			//System.out.println("cidx?"+cidx);
			int listCnt = list.size();	
			int sidx = 0;
			String s_name ="";
			int s_no = 0;
			int s_grade =0;
			String s_major ="";
			String str = "";
			
			for(int i=0; i< listCnt; i++){
				sidx = list.get(i).getSidx();
				s_name = list.get(i).getS_name();
				s_no = list.get(i).getS_no();
				s_grade = list.get(i).getS_grade();
				s_major = list.get(i).getS_major();
				String comma = "";
				if(i == listCnt-1) { 
					comma = "";
					
				}else {
					comma = ",";
				}
				str = str +"{\"sidx\":\""+sidx+"\",\"s_name\":\""+s_name+"\",\"s_no\":\""+s_no+"\",\"s_grade\":\""+s_grade+"\",\r\n"
						+ "\"s_major\":\""+s_major+"\"}"+comma;
			}
			//System.out.println(str);
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}else if(location.equals("checkedEnrollAction.do")) {
			String selectedStudent = request.getParameter("selectedStudent");
			String cidx = request.getParameter("cidx");
					
		    JSONParser parser = new JSONParser();
		    JSONArray jsonArray = null;
		    
	        // selectedStudent를 JSON 배열로 파싱
	    	try {
				jsonArray = (JSONArray) parser.parse(selectedStudent);
			} catch (org.json.simple.parser.ParseException e) {
				
				e.printStackTrace();
			}
	    	
	    	ArrayList<MemberVo> mv = new ArrayList<>();
	        // JSON 배열을 순회하며 각 값을 처리
	        for (Object obj : jsonArray) {
	            String sidxString = (String) obj;
	            int sidx = Integer.parseInt(sidxString);
	            
	            // MemberVo 객체 생성
	            MemberVo memberVo = new MemberVo();
	            memberVo.setSidx(sidx);
	            
	            mv.add(memberVo);
	        }
	        int value = 0;
	        AdminDao add = new AdminDao();
	        value = add.checkedEnroll(mv,Integer.parseInt(cidx));
	        
			String str ="{\"value\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
			
		}else if(location.equals("EnrollAction.do")) {
			String sidx = request.getParameter("sidx");
			String cidx = request.getParameter("cidx");
			//System.out.println("sidx?"+sidx);
			//System.out.println("cidx?"+cidx);
			
			int value =0;
			AdminDao add = new AdminDao();
			value=add.studentEnroll(Integer.parseInt(sidx),Integer.parseInt(cidx));
			
			String str ="{\"value\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
			
		}
	
	}

}
