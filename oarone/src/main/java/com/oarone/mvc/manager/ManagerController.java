package com.oarone.mvc.manager;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.oarone.mvc.manager.ManagerDao;
import com.oarone.mvc.manager.ManagerDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class ManagerController
 */
@WebServlet("/manager.do")
public class ManagerController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	MultipartRequest multi = null;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 	request.setCharacterEncoding("utf-8");
    	response.setCharacterEncoding("utf-8");
    	
    	ServletContext ctx = request.getServletContext();
    	String savePath =  ctx.getRealPath("/upload/product");
    	//상대적 경로 -> 실제경로
    	int sizeLimit = 1024*1204*20;
    	// DefaultFileRenamePolicy - 파일명이 중복될때 어떻게 처리할지 선택. 파일명 마음대로 바꿈
    	System.out.println(request.getMethod());
    	System.out.println(request.getContentType());
    	String method = request.getMethod();
    	String contentType = request.getContentType();
    	String cmd = "";
    	
    	if(contentType == null || !contentType.startsWith("multipart")) {
    		cmd = request.getParameter("cmd");

    		if(cmd==null || cmd.equals(""))
    			cmd="list";
    	}else {
    		multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
    		cmd = multi.getParameter("cmd");
    	}
    	
		System.out.println("****"+cmd);
	
		if(cmd.equals("list"))
		{
			doList(request, response);
		}
		else if(cmd.equals("write"))
		{
			doWrite(request, response);
		}
		else if(cmd.equals("save2")) {
			doSave2(request, response);
		}
    	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	void doList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 ManagerDto dto = new ManagerDto();
		 ManagerDao dao = new ManagerDao();
		 
		 request.setAttribute("list", dao.getList(dto));
		
		 RequestDispatcher rd = 
				   request.getRequestDispatcher("/manager/manager_list.jsp");
		 rd.forward(request, response);
	}
	
	void doWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 RequestDispatcher rd = 
			request.getRequestDispatcher("/manager/manager_write.jsp");
		 rd.forward(request, response);
	}
	
	void doSave2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(request.getParameter("pr_name"));
		System.out.println(request.getParameter("price"));
		
		//파일 업로드해야 한다 
		String pr_name = multi.getParameter("pr_name");
		String price = multi.getParameter("price");
		
		//tag의 name 속성
		String filename = multi.getFilesystemName("image");
		String originalFilename = multi.getOriginalFileName("image");
		
		System.out.println(filename);
		System.out.println(originalFilename);
		
		ManagerDto dto = new ManagerDto();
		dto.setPr_name(pr_name);
		dto.setPrice(price);
		dto.setImages(filename);
		
		ManagerDao dao =new ManagerDao();
		dao.insert(dto);
			
		JSONObject obj = new JSONObject();//JSON으로 전송하기 위한 
		//전용 객체를 생성한다 
		
		obj.put("result", "success");

		response.setContentType("application/x-json, charset=utf-8");
		response.getWriter().print(obj.toJSONString());
	}
	
	

}
