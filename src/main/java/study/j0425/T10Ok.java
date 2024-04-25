package study.j0425;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/j0425/T10Ok")public class T10Ok extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8"); //넘어올 때 인코딩 해서 넘어왔어야 했기 때문에(인코딩 되지 않은 상태기 때문에) 받으면서(response) 인코딩...? (브라우저에 출력)
		request.setCharacterEncoding("utf-8"); // 서버에 요청(request)해서 인코딩 후 콘솔 출력 (서버에 출력)
		
		// front에서 넘어온 값들을 변수에 담아서 처리한다.
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid"); // 받아오면서 삼항연산자로 null값 체크 먼저
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd"); // 받아오면서 삼항연산자로 null값 체크 먼저
		
		// DB에서 mid와 같은 자료가 있는지 검색 후 돌아온다.
		if(!mid.equals("admin") || !pwd.equals("1234")) {
			// jsp로 보내서 다시 로그인하라는 메세지를 띄우도록 한다
			response.sendRedirect(request.getContextPath()+"/study/0425/t10_Login.jsp?msgFlag=no"); // href로 보내는 것과 거의 같은 기능
			// ?변수=값 get 방식, guery스트링 방식
			return;
		}
		
		// 정상회원들 처리부분
		System.out.println("정상로그인 처리됨...");
		response.sendRedirect(request.getContextPath()+"/study/0425/t10_Main.jsp?msgFlag=ok&mid="+mid);
	}
}
