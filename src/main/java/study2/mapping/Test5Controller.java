package study2.mapping;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.do5")
public class Test5Controller extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Test5Interface command = null;
		String viewPage = "/WEB-INF/study2/mapping/";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		
		if(com.equals("test5")) {
			viewPage += "test5.jsp";
		}
		else if(com.equals("t5Input")) {
			viewPage += "test5Input.jsp";
		}
		else if(com.equals("t5InputOk")) {
			command = new Test5InputCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("t5Update")) {
			viewPage += "test5Update.jsp";
		}
		else if(com.equals("t5UpdateOk")) {
			command = new Test5UpdateCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("t5Delete")) {
			viewPage += "test5Delete.jsp";
		}
		else if(com.equals("t5DeleteOk")) {
			command = new Test5DeleteCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("t5List")) {
			command = new Test5ListCommand();
			command.execute(request, response);
			viewPage += "test5List.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
