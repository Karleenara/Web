package com.kosa.myhome4;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PayServlet
 */
@WebServlet("/Pay")
public class PayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String sName = request.getParameter("username");
		String sTime = request.getParameter("time");
		String sTimepay = request.getParameter("timepay");
		
		int nTime = Integer.parseInt(CommonUtill.nullToVal(sTime, "0"));
		int nTimepay = Integer.parseInt(CommonUtill.nullToVal(sTimepay, "0"));
		
		float nPlus=0;
		if(nTime>=20)
			nPlus = (float) ((nTime - 20)*nTimepay*0.5);

		
		int total = (int) (nTime*nTimepay + nPlus);
	
		
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		
		PrintWriter out = response.getWriter();
		
		
		
		out.println("<html>");
		out.println("<meta charset='utf-8'>");
		out.println("<h1>"+String.format("%s의 근무시간은 %d였고 기본급은 %d이고 수당은 %.0f입니다",sName, nTime, nTime*nTimepay, nPlus));
		out.println("<h1>"+String.format("합산은 %d입니다", total));
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
