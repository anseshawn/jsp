package study.j0425;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/j0425/T05Ok") // 중간경로 적어주기
public class T05Ok extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8"); //넘어올 때 인코딩 해서 넘어왔어야 했기 때문에(인코딩 되지 않은 상태기 때문에) 받으면서(response) 인코딩...? (브라우저에 출력)
		request.setCharacterEncoding("utf-8"); // 서버에 요청(request)해서 인코딩 후 콘솔 출력 (서버에 출력)
		
		// front에서 넘어온 값들을 변수에 담아서 처리한다.
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid"); // 받아오면서 삼항연산자로 null값 체크 먼저
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd"); // 받아오면서 삼항연산자로 null값 체크 먼저
		
		String loginOk = "";
		if(mid.equals("admin") && pwd.equals("1234")) loginOk = "OK";
		else loginOk = "NO";
				
		PrintWriter out = response.getWriter();
		
		if(loginOk.equals("OK")) {
			out.println("<script>");
			out.println("alert('"+mid+"님 로그인 되었습니다.');");
			out.println("location.href='"+request.getContextPath()+"/study/0425/t05Main.jsp?mid="+mid+"';");
			out.println("</script>");			
		}
		else {
			out.println("<script>");
			out.println("alert('로그인 실패');");
			out.println("location.href='"+request.getContextPath()+"/study/0425/t05_Login.jsp';");
			out.println("</script>");						
		}
	}
}
