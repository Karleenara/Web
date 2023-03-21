package com.kosa.myhome4;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddServlet
 */
@WebServlet("/add")
public class AddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());

		String sX = request.getParameter("x");
		String sY = request.getParameter("y");
		String operator = CommonUtill.nullToVal(request.getParameter("operator"),"1");

		int nX = Integer.parseInt(sX);
		int nY = Integer.parseInt(sY);
		int nZ = nX+nY;
		if(operator.equals("1")) {
			nZ = nX+nY;
			operator = "+";
		}
		else if(operator.equals("2")) {
			nZ = nX-nY;
			operator = "-";			
		}
		else if(operator.equals("3")) {
			nZ = nX*nY;
			operator = "*";			
		}
		else {
			nZ = nX/nY;
			operator = "/";			
		}

		PrintWriter out = response.getWriter();
		out.println("<h1>"+String.format("%d %s %d = %d", nX, operator, nY, nZ)+"<h1>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
