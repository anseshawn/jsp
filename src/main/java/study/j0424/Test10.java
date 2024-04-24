package study.j0424;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/T10")
public class Test10 extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8"); // 대소문자상관없음
		
		// WebServer에서 ?뒤에 보낸건 웹서버로 감
		// WAS에서 WebServer에 다시 리퀘스트해서 가져옴
		// 이를 변수에 담아서 사용
		// 웹에서 들어오는 값은 모두 문자기 때문에 숫자로 쓰려면 타입변환
		int su = Integer.parseInt(request.getParameter("su"));
		int tot = 0;
		for(int i=1; i<=su; i++) {
			tot += i;
		}
		System.out.println("tot : "+tot);
		
		PrintWriter out = response.getWriter();
		out.println("이곳은 서블릿에서 보냅니다.");
		out.println("<p><input type='button' value='돌아가기' onclick='location.href=\"/javaclass/study/0424/test10Ok.jsp?tot="+tot+"\"'/></p>");
		// 계산된 결과를 test10Ok로 보내기
		
	}
}
