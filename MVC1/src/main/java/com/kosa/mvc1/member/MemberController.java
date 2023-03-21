package com.kosa.mvc1.member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class MemberController
 */
@WebServlet("/member.do")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MemberController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String cmd = request.getParameter("cmd");
		if (cmd == null || cmd.equals(""))
			cmd = "member_write";

		if (cmd.equals("idcheck")) {
			doIdCheck(request, response);
		} else if (cmd.equals("member_write")) {
			doWrite(request, response);
		} else if (cmd.equals("member_save")) {
			doSave(request, response);
		} else if (cmd.equals("logon")) {
			// jsp로 이동만
			doLogon(request, response);
		} else if (cmd.equals("logon_proc")) {
			// 실제 로그온 담담 - 세션에 저장하는 역할
			doLogonProc(request, response);
		} else if (cmd.equals("logout")) {
			doLogout(request, response);
		} else if (cmd.equals("findid")) {
			doFindid(request, response);
		} else if (cmd.equals("findid_proc")) {
			doFindidProc(request, response);
		} else if (cmd.equals("findpassword")) {
			doFindpassword(request, response);
		} else if (cmd.equals("findpassword_proc")) {
			doFindpasswordProc(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	// http://localhost:9000/MVC1/MemberController?cmd=idcheck&user_id=test

	protected void doIdCheck(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String user_id = request.getParameter("user_id");
		MemberDao dao = new MemberDao();
		response.setContentType("application/x-json, charset=utf-8");

		if (dao.isDuplicate(user_id)) // 이미 사용하는 사람이 있다
			response.getWriter().print("{\"result\":\"fail\"}");
		else
			response.getWriter().print("{\"result\":\"success\"}");

	}

	protected void doWrite(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/member/member_write.jsp");
		rd.forward(request, response);
	}

	@SuppressWarnings("unused")
	protected void doSave(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MemberDto dto = new MemberDto();
		MemberDao dao = new MemberDao();

		// request 객체로부터 파라미터 값들 받는다
		String user_id = request.getParameter("user_id");
		String user_name = request.getParameter("user_name");
		String user_password = request.getParameter("password");
		String user_email = request.getParameter("email");
		String user_phone = request.getParameter("phone");

		dto.setUser_id(user_id);
		dto.setUser_name(user_name);
		dto.setPassword(user_password);
		dto.setEmail(user_email);
		dto.setPhone(user_phone);

		// DB에 저장, 저장 성공시 true, 실패시 false
		boolean result = dao.insert(dto);

		response.setContentType("application/x-json, charset=utf-8");
		if (result)
			response.getWriter().print("{\"result\":\"success\"}");
		else
			response.getWriter().print("{\"result\":\"fail\"}");
	}

	void doLogon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// /member/logon.jsp 로 페이지만 이동
		String url = "/member/logon.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}

	@SuppressWarnings("unchecked")
	void doLogonProc(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String user_id = request.getParameter("user_id");
		String password = request.getParameter("password");
		MemberDao dao = new MemberDao();
		MemberDto dto = dao.logon(user_id, password);
		JSONObject obj = new JSONObject();
		if (dto.getUser_id().equals("")) {
			// 로그온 실패
			obj.put("result", "fail");
		} else {
			// 로그온 성공이므로 세션에 로그온 정보 저장해야 함
			// 서블릿에서 세션객체는 request 객체를 통해 얻어야 함
			HttpSession session = request.getSession();
			session.setAttribute("user_id", dto.getUser_id());
			session.setAttribute("user_name", dto.getUser_name());
			session.setAttribute("email", dto.getEmail());
			obj.put("result", "success");
		}

		response.setContentType("application/x-json, charset=utf-8");
		response.getWriter().print(obj.toJSONString());
	}

	@SuppressWarnings("unchecked")
	void doLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		JSONObject obj = new JSONObject();
		HttpSession session = request.getSession();
		session.invalidate(); // 세션 지우기
		obj.put("result", "success");
		response.setContentType("application/x-json, charset=utf-8");
		response.getWriter().print(obj.toJSONString());
	}

	void doFindid(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// /member/logon.jsp 로 페이지만 이동
		String url = "/member/findid.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}

	@SuppressWarnings("unchecked")
	void doFindidProc(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String user_name = request.getParameter("user_name");
		String email = request.getParameter("email");
		MemberDao dao = new MemberDao();
		MemberDto dto = dao.findid(user_name, email);
		JSONObject obj = new JSONObject();

		if (dto.getUser_name().equals("")) {
			obj.put("result", "fail");
		} else {
			obj.put("user_id", dto.getUser_id());
			obj.put("result", "success");
		}

		response.setContentType("application/x-json, charset=utf-8");
		response.getWriter().print(obj.toJSONString());
	}

	void doFindpassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// /member/logon.jsp 로 페이지만 이동
		String url = "/member/findpassword.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}

	@SuppressWarnings("unchecked")
	void doFindpasswordProc(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String user_id = request.getParameter("user_id");
		String email = request.getParameter("email");
		MemberDao dao = new MemberDao();
		MemberDto dto = dao.findpassword(user_id, email);
		JSONObject obj = new JSONObject();

		if (dto.getUser_id().equals("")) {
			obj.put("result", "fail");
		} else {
			obj.put("password", dto.getPassword());
			obj.put("result", "success");
		}
		response.setContentType("application/x-json, charset=utf-8");
		response.getWriter().print(obj.toJSONString());
	}

}
