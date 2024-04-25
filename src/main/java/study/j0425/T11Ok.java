package study.j0425;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/j0425/T11Ok")public class T11Ok extends HttpServlet {
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
			response.sendRedirect(request.getContextPath()+"/study/0425/t11_Login.jsp?msgFlag=no"); // href로 보내는 것과 거의 같은 기능
			return;
		}
		
		// 정상회원들 처리부분
		System.out.println("정상로그인 처리됨...");
		// 가다가 어느 방향으로 갈지 살핀 후 간다. 경로가 꺾어진다고 볼 수 있음.
		//response.sendRedirect(request.getContextPath()+"/study/0425/t11_Main.jsp?msgFlag=ok&mid="+mid);
		
		// 시리얼라이즈. 직렬화 방법. 가고 싶은 주소로 적어준다.
		String viewPage = "/study/0425/t11_Main.jsp?msgFlag=ok&mid="+mid;
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response); // 앞에서 가져온 자료를 그대로 가지고 보낸다
		// 최종 메인 창의 주소가 이 파일에 머물러 있게 됨
		// 파일명만 멈춰있고 나머지 과정은 계속 진행 되고 있다(로그인 후 검사 후 메인창 연결까지...)
	}
}
