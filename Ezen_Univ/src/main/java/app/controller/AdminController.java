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
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import app.dao.AdminDao;
import app.dao.MemberDao;
import app.domain.AdminVo;
import app.domain.CourseTimeVo;
import app.domain.CourseVo;
import app.domain.MemberVo;
import app.domain.WeektbVo;


@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String location;
	public AdminController(String location) {
		this.location = location;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if(location.equals("adminLogin.do")) {	//로그인
			
			String ad_id = request.getParameter("adminId");
			String ad_pwd = request.getParameter("adminPwd");
			
			
			AdminDao add = new AdminDao();
			int adidx = 0;
			adidx = add.adminLoginCheck(ad_id, ad_pwd);
			if (adidx!=0){ 
				
				HttpSession session = request.getSession();
				AdminVo av = new AdminVo();
				
				av = add.adminAdidxSearch(ad_id);
				session.setAttribute("adidx", av.getAdidx());

				response.sendRedirect(request.getContextPath()+"/admin/accept.do");
				
			}else{//아이디 비번 불일치
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script language='javascript' type='text/javascript'> alert('로그인 실패'); </script>");
				out.println("<script>location.href='../index.jsp';</script>");
				//response.sendRedirect("./main/main_s.do");
			}
			
		}else if(location.equals("adminLogout.do")) {	//로그아웃
			HttpSession session = request.getSession();
			
			session.invalidate(); //초기화
			
			response.sendRedirect(request.getContextPath()+"/index.jsp");
			
		}else if(location.equals("accept.do")) {	// 가입승인 리스트
			
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
			AdminDao add= new AdminDao();
			ArrayList<MemberVo> slist = add.studentAll();
			ArrayList<MemberVo> plist = add.professorAll();
			
			request.setAttribute("slist", slist);
			request.setAttribute("plist", plist);
			
			String path = "/admin/accept.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("acceptStudentOk.do")) {	// 학생 1명에 대한 승인
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
			String sidx = request.getParameter("sidx");
			//System.out.println("sidx?"+sidx);
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.studentAccept(Integer.parseInt(sidx));
			
			//System.out.println("value?"+value);
			String str ="{\"value\":\""+value+"\"}";
			out.println(str);
			
		}else if(location.equals("acceptProfessorOk.do")) {	// 교수 1명에 대한 승인
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
			String pidx = request.getParameter("pidx");
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.professorAccept(Integer.parseInt(pidx));
			
			
			String str ="{\"value\":\""+value+"\"}";
			out.println(str);
			
		}else if(location.equals("acceptStudentNo.do")) {	// 학생 1명에 대한 거부
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
			String sidx = request.getParameter("sidx");
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.studentDeny(Integer.parseInt(sidx));
			
			//System.out.println("value?"+value);
			String str ="{\"value\":\""+value+"\"}";
			out.println(str);
			
		}else if(location.equals("acceptProfessorNo.do")) {	// 교수 1명에 대한 거부
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
			String pidx = request.getParameter("pidx");
			
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.professorDeny(Integer.parseInt(pidx));
			
			
			String str ="{\"value\":\""+value+"\"}";
			out.println(str);
			
		}else if(location.equals("acceptStudentAllOk.do")) {	// 체크된 학생들에 대한 승인
			
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
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
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
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
			
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
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
			
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
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
			
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			String path = "/admin/courseRegister.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("courseRegisterList.do")) {	// 강의등록 현황
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
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
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
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
			out.println("["+str+"]");

		}else if(location.equals("professorVerification.do")) {	// 강의등록 조회된 교수번호, 교수이름 교차검증
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
			
			String p_no = request.getParameter("p_no");
			String p_name = request.getParameter("p_name");
			
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.professorVerification(Integer.parseInt(p_no),p_name);
			
			String str ="{\"value\":\""+value+"\"}";
			out.println(str);
			
		}else if(location.equals("courseTimeVerification.do")) {	// 시간표 등록시 교차검증
			
			String ct_room = request.getParameter("courseroomValue");
			String ct_week = request.getParameter("weekValue");
			String pe_period = request.getParameter("periodValue");
			String ct_semester = request.getParameter("semesterValue");
			String ct_year = request.getParameter("yearValue");
			String c_major = request.getParameter("c_major");
			String c_grade = request.getParameter("c_grade");
			
			
			int value = 0;
			AdminDao add= new AdminDao();
			value =add.courseTimeVerification(ct_room,ct_week,Integer.parseInt(pe_period),Integer.parseInt(ct_semester),Integer.parseInt(ct_year),c_major,Integer.parseInt(c_grade));
			
			//System.out.println("value?"+value);
			
			String str ="{\"cnt\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}else if(location.equals("courseRegisterAction.do")) {		// 강의 등록
			
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
			String c_name = request.getParameter("c_name");
			String c_major = request.getParameter("c_major");
			String c_sep = request.getParameter("c_sep");
			String p_no = request.getParameter("p_no");
			String c_grade = request.getParameter("c_grade");
			String p_name = request.getParameter("p_name");
			String c_score = request.getParameter("c_score");
			String c_totaltime = request.getParameter("c_totaltime");
			String tableData = request.getParameter("tableData");
			
			//System.out.println("tableData?"+tableData);
			
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
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
			String path = "/admin/courseEnroll.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("courseMatchStudent.do")) {	// 수강등록 학생리스트
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
			String cidx = request.getParameter("cidx");
			String c_major = request.getParameter("c_major");
			String c_grade = request.getParameter("c_grade");
			
			//System.out.println("cidx?"+cidx);
			//System.out.println("c_major?"+c_major);
			//System.out.println("c_grade?"+c_grade);
			
			AdminDao add= new AdminDao();
			ArrayList<MemberVo> list = add.courseMatchStudentList(Integer.parseInt(cidx),c_major,Integer.parseInt(c_grade));
			
			//System.out.println("list?"+list);
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
			out.println(str);
			
		}else if(location.equals("checkedEnrollAction.do")) { // 체크된 학생들 수강등록
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
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
			out.println(str);
			
			
		}else if(location.equals("EnrollAction.do")) {	// 학생 1명의 수강등록
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			
			String cidx = request.getParameter("cidx");
			String sidx = request.getParameter("sidx");
			
			int value =0;
			AdminDao add = new AdminDao();
			value=add.studentEnroll(Integer.parseInt(cidx),Integer.parseInt(sidx));
			

			String str ="{\"value\":\""+value+"\"}";
			out.println(str);
			
			
		}else if(location.equals("openDate.do")) {	// 개강날짜 페이지
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}	
			String path = "/admin/openDate.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("openDateList.do")) {	// 현 학기에 등록된 개강날짜 리스트
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("adidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
				out.flush();
			}
			String year = request.getParameter("year");
			String term = request.getParameter("term");
			
			int year_int = Integer.parseInt(year);
			int term_int = Integer.parseInt(term);
			
			AdminDao add= new AdminDao();
			ArrayList<WeektbVo> list = add.opendateList(year_int,term_int);
			
			int listCnt = list.size();	
			int w_week = 0;
			String w_start =null;
			String w_end =null;
			String str = "";
			
			for(int i=0; i< listCnt; i++){
				w_week= list.get(i).getW_week();
				w_start= list.get(i).getW_start();
				w_end= list.get(i).getW_end();
				
				String comma = "";
				
				if(i == listCnt-1) { 
					comma = "";
					
				}else {
					comma = ",";
				}
				str = str +"{\"w_week\":\""+w_week+"\",\"w_start\":\""+w_start+"\",\"w_end\":\""+w_end+"\"}"+comma;
			}
			out.println(str);
			

		}else if(location.equals("openDateRegisterCheck.do")) {	// 개강날짜 중복체크
			
			String year = request.getParameter("dateInfoYear");
			String semester = request.getParameter("dateInfoSemester");
			
			int year_int =Integer.parseInt(year);
			int semester_int =Integer.parseInt(semester);
			
			int value = 0;
			AdminDao add= new AdminDao();
			value = add.openDateRegisterCheck(year_int,semester_int);

			String str ="{\"cnt\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
			
		}else if(location.equals("openDateRegisterAction.do")) {	// 등록되지 않은 개강날짜 등록
		  
			String startdate = request.getParameter("dateInput");
			String year = request.getParameter("dateInfoYear");
			String semester = request.getParameter("dateInfoSemester");
			 
			int startyear =Integer.parseInt(year);
			int tm =Integer.parseInt(semester);
			
			//System.out.println("startdate?"+startdate);
			//System.out.println("startyear?"+startyear);
			//System.out.println("tm?"+tm);
			  
			int value = 0;
			AdminDao add= new AdminDao();
			value = add.openDateRegister(startdate,startyear,tm);
			
			PrintWriter out = response.getWriter();
			//3. 처리가 끝났으면 새롭게 이동한다
			if (value ==0) { //입력 안되었으면 입력페이지
				out.println("<script>alert('입력하는 동안 오류가 났습니다.');location.href='"+request.getContextPath()+"/admin/accept.do'</script>");
				
			}else {	//입력되었으면 리스트 페이지로 이동		
				out.println("<script>alert('개강날짜가 입력되었습니다.');location.href='"+request.getContextPath()+"/admin/openDate.do'</script>");
			}	

		}else if(location.equals("openDateUpdateAction.do")) {	// 등록되어 있는 개강날짜 업데이트 등록
			  
				String startdate = request.getParameter("dateInput");
				String year = request.getParameter("dateInfoYear");
				String semester = request.getParameter("dateInfoSemester");
				  
				int syear =Integer.parseInt(year);
				int stm =Integer.parseInt(semester);
				
				//System.out.println("startdate?"+startdate);
				//System.out.println("syear?"+syear);
				//System.out.println("stm?"+stm);
				    
				int value = 0;
				AdminDao add= new AdminDao();
				value = add.openDateUpdate(startdate,syear,stm);

				PrintWriter out = response.getWriter();
				//3. 처리가 끝났으면 새롭게 이동한다
				if (value ==0) { //입력 안되었으면 입력페이지
					out.println("<script>alert('입력하는 동안 오류가 났습니다.');location.href='"+request.getContextPath()+"/admin/accept.do'</script>");
					
				}else {	//입력되었으면 리스트 페이지로 이동		
					out.println("<script>alert('개강날짜가 입력되었습니다.');location.href='"+request.getContextPath()+"/admin/openDate.do'</script>");
				}	
	
		
		}
			 
	
	}
}