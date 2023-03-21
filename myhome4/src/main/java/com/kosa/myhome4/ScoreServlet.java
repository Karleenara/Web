package com.kosa.myhome4;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ScoreServlet
 */
@WebServlet("/Score")
public class ScoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		System.out.println("*********");
		
		String sName = request.getParameter("username");
		String sKor = request.getParameter("kor");
		String sEng = request.getParameter("eng");
		String sMath = request.getParameter("math");
		
		int nKor = Integer.parseInt(CommonUtill.nullToVal(sKor, "0"));
		int nEng = Integer.parseInt(CommonUtill.nullToVal(sEng, "0"));
		int nMath = Integer.parseInt(CommonUtill.nullToVal(sMath, "0"));

		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		
		PrintWriter out = response.getWriter();
		
		out.println("<html>");
		out.println("<meta charset='utf-8'>");
		out.println("<h1>"+String.format("%s의 총점은 %d, 평균은 %.2f",sName, nKor+nEng+nMath, (float)(nKor+nEng+nMath)/3));
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
