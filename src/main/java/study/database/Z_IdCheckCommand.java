package study.database;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Z_IdCheckCommand implements Z_IdCheckInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		LoginDAO dao = new LoginDAO();
		LoginVO vo = new LoginVO();
		
		vo = dao.getLoginIdSearch(mid);
		
		int res = 0;
		if(!mid.equals(vo.getMid()))	res = 1;
		else res = 0;
		
		response.getWriter().write(res+"");
	}

}
