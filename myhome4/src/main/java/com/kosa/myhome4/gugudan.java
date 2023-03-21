package com.kosa.myhome4;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class gugudan
 */
@WebServlet("/gugudan")
public class gugudan extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public gugudan() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
		
		//String dan = request.getParameter("dan");
//		if (dan == null || dan.equals(""))
//				dan"2";
		
		String dan = CommonUtill.nullToVal(request.getParameter("dan"), "2");
		
		int ddan = Integer.parseInt(dan);
		PrintWriter out = response.getWriter();
		for(int i=1; i<10; i++){
			out.println("<h1>" + String.format("%d * %d = %d", ddan, i, ddan*i) + "<br/></h1>");
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
