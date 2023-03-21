package com.kosa.mvc1.guestbook;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GuestbookController
 * 
 *   
 */
@WebServlet("/guestbook.do")
public class GuestbookController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String cmd=request.getParameter("cmd");
		GuestbookDao dao = new GuestbookDao();//모델단
		//서블릿이 Controller 역할을 하고 있다 
		
		if(cmd==null || cmd.equals(""))
			cmd="list"; //아무값도 없을때 기본값 부여
		if(cmd.equals("list"))
		{
			doList(request, response);
		}
		else if(cmd.equals("view"))
		{
			doView(request, response);
		}
		else if(cmd.equals("write")) //페이지이동
		{
			doWrite(request, response);
		}
		else if(cmd.equals("save")) //디비 저장하기 
		{
			doSave(request, response);
		}
		else if(cmd.equals("modify")) //수정하기 
		{
			doModify(request, response);
		}
		else if(cmd.equals("update")) //수정하기 
		{
			doUpdate(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	void doList(HttpServletRequest request, 
			          HttpServletResponse response) throws ServletException, IOException
	{
		GuestbookDao dao = new GuestbookDao();
		//request객체에 데이터를 저장해서 보낸다. 
		//setAttribute("객체참조명", 객체정보);
		//jsp 에서는 getAttribute("객체참조명");형태로 값을 읽는다 
		//getAttribute는 Object 타입으로 다운캐스팅해서 전달한다 
		//사용전에 upcasting 으로 받아야 한다
		//setParameter 라는 함수는 없다. 값 넣으려면  setAttribute 만
		//가능하다. 사용법 - Hashmap처럼 키와 값 쌍의 형태로 저장한다 
		
		//강제 다운캐스팅 상황 Object ->List<GuestbookDto> 
		//List<GuestbookDto> list = 
		//		(List<GuestbookDto>)request.getAttribute("list");
		
		//jsp 로 토스하기 
		//RequestDispatcher - 다른페이지로 이동할때 사용한다 
		GuestbookDto dto = new GuestbookDto();
		String pg = request.getParameter("pg");
		String searchOpt = request.getParameter("searchOpt");
		String searchKey = request.getParameter("searchKey");
		
		// pg 값을 전달받지 못한 경우에 0으로 하기
		if(pg==null || pg.equals(""))
			pg="0";
		if(searchOpt == null)
			searchOpt = "";
		if(searchKey== null)
			searchKey = "";
		dto.setPg(Integer.parseInt(pg));
		dto.setSearchOpt(searchOpt);
		dto.setSearchDeyword(searchKey);
		
		request.setAttribute("totalCnt", dao.getTotalCnt(dto));
		request.setAttribute("list", dao.getList(dto));
		
		String url="/guestbook/guestbook_list.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
		//forward함수를 사용해서 페이지를 이동시 기존의 request와 response
		//객체가 가지고 있는 값을 가지고 이동한다. 
	}

	void doView(HttpServletRequest request, 
	          HttpServletResponse response) throws ServletException, IOException
	{
		GuestbookDao dao = new GuestbookDao();
		String seq = request.getParameter("seq");
		
		request.setAttribute("dto", dao.getView(seq));
		
		//jsp로 이동하기 
		String url="/guestbook/guestbook_view.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}
	
	void doWrite(HttpServletRequest request, 
	          HttpServletResponse response) throws ServletException, IOException
	{
		
		//jsp로 이동하기 
		String url="/guestbook/guestbook_write.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}
	
	void doSave(HttpServletRequest request, 
	          HttpServletResponse response) throws ServletException, IOException
	{
		GuestbookDao dao = new GuestbookDao();
		//데이터를 가져와서 
		String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String contents = request.getParameter("contents");
		
		GuestbookDto dto = new GuestbookDto();
		dto.setTitle(title);
		dto.setWriter(writer);
		dto.setContents(contents);
		
		dao.insert(dto); //만들러 가야함 
		String url= request.getContextPath()
				           +"/guestbook.do?cmd=list";
		//forwarding 을 사용하지 못한다. 디비에서 데이터 읽어와서 
		//jsp 로 넘기는 이중작업을 해야 한다. 그리고 request객체에
		//전달받은 데이터를 날려버려야 한다.그래야 한번말 저장한다  
		response.sendRedirect(url);//등록하고 마지막은 절대 forward
		//가 아니고   sendRedirect를 써야 한다 
	}
	
	void doModify(HttpServletRequest request, 
	          HttpServletResponse response) throws ServletException, IOException
	{
		GuestbookDao dao = new GuestbookDao();
		String seq = request.getParameter("seq");
		
		request.setAttribute("dto", dao.getView(seq));
		
		//jsp로 이동하기 
		String url="/guestbook/guestbook_write.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}

	void doUpdate(HttpServletRequest request, 
	          HttpServletResponse response) throws ServletException, IOException
	{
		GuestbookDao dao = new GuestbookDao();
		//데이터를 가져와서 
		String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String contents = request.getParameter("contents");
		String seq = request.getParameter("seq");
			
		GuestbookDto dto = new GuestbookDto();
		dto.setTitle(title);
		dto.setWriter(writer);
		dto.setContents(contents);
		dto.setSeq(seq);
			
		dao.update(dto); //만들러 가야함 
		String url= request.getContextPath()
				           +"/guestbook.do?cmd=list";
		//forwarding 을 사용하지 못한다. 디비에서 데이터 읽어와서 
		//jsp 로 넘기는 이중작업을 해야 한다. 그리고 request객체에
		//전달받은 데이터를 날려버려야 한다.그래야 한번말 저장한다  
		response.sendRedirect(url);//등록하고 마지막은 절대 forward
		//가 아니고   sendRedirect를 써야 한다 
	}
}












