package study.database;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/study/database/LoginOrder")
public class LoginOrder extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String option = request.getParameter("option")==null ? "" : (String)request.getParameter("option");
		
		LoginDAO dao = new LoginDAO();
		
		ArrayList<LoginVO> vos = dao.getOrderedList(option, 0, 0);
		request.setAttribute("orderOption", option); // 콤보상자에 selected를 위해서 orderOption값을 넣어준다
		request.setAttribute("vos", vos);
		
		String viewPage = "/study/database/loginMain.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
