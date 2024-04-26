package study.j0425;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/j0425/T13Ok")
public class T13Ok extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String loginFlag = request.getParameter("loginFlag")==null ? "" : request.getParameter("loginFlag");
		
		if(loginFlag.equals("javascript")) {
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("location.href='"+request.getContextPath()+"/study/0425/t13Res.jsp?mid="+mid+"&pwd="+pwd+"&loginFlag="+loginFlag+"';");
			// get방식, querystring으로 넘기고있음(변수값 노출)
			// path variable : 슬래시(경로)를 이용하여 넘김(경로명 노출)
			out.println("</script>");
		}
		else if(loginFlag.equals("response")) {
			response.sendRedirect(request.getContextPath()+"/study/0425/t13Res.jsp?mid="+mid+"&pwd="+pwd+"&loginFlag="+loginFlag);
		}
		else {
			// String viewPage = "/study/0425/t13Res.jsp?mid="+mid+"&pwd="+pwd+"&loginFlag="+loginFlag; // 동일한 위치에 있다고 가정하여 앞에 context명을 적지 않는다
			request.setAttribute("mid", mid); // 받는 변수, 보내는 값
			request.setAttribute("pwd", pwd); // 받는 변수, 보내는 값
			request.setAttribute("loginFlag", loginFlag); // 받는 변수, 보내는 값
			// attribute로 보내면 ${} 로 표현한다
			
			String viewPage = "/study/0425/t13Res.jsp";
			// 리소스가 들어간다 jsp말고도 서블릿 등 가능...
			// query string - 기차에 매달려 가는 개념 / set attribute - 기차가 가는 길에 물건을 싣는 개념
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			
			// 링크가 이 파일에 멈춰있기 때문에 경로를 신경써줘야 함
		}
		
	}
}
