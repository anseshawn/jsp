package study.database;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/study/database/Z_IdCheck")
public class Z_IdCheckController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Z_IdCheckInterface command = null;
		String viewPage = "/study/database/join.jsp";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/")+1);
		
		if(com.equals("IdCheck")) {
			command = new Z_IdCheckCommand();
			command.execute(request, response);
			return;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
