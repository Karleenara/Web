package com.kosa.myhome4;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HelloServlet
 */
@WebServlet("/hello")
public class HelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HelloServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// request - 클라이언트로부터 요청을 받아오는 객체
		// response = 서버에서 클라이언트에게 보내기 위한 객체
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		response.setCharacterEncoding("utf-8");
		// 한글 받아올때 안깨지게 받아올 수 있음
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<meta charset='utf-8'");
		out.println("<h1>Hello Servlet</h1>");
		out.println("안녕하세요");
		out.println("</html>");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
