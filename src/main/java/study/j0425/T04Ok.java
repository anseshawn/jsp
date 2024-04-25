package study.j0425;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/j0425/T04Ok") // 중간경로 적어주기
public class T04Ok extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8"); //넘어올 때 인코딩 해서 넘어왔어야 했기 때문에(인코딩 되지 않은 상태기 때문에) 받으면서(response) 인코딩...? (브라우저에 출력)
		request.setCharacterEncoding("utf-8"); // 서버에 요청(request)해서 인코딩 후 콘솔 출력 (서버에 출력)
		
		// front에서 넘어온 값들을 변수에 담아서 처리한다.
		String name = request.getParameter("name")==null ? "" : request.getParameter("name"); // 받아오면서 삼항연산자로 null값 체크 먼저
		int age = request.getParameter("age")==null || request.getParameter("age")=="" ? 0 : Integer.parseInt(request.getParameter("age"));
		
		
		System.out.println("성명 : "+name);
		System.out.println("나이 : "+age);
		
		PrintWriter out = response.getWriter();
		
		out.println("<p>성명 : "+name+"</p>");
		out.println("<p>나이 : "+age+"</p>");
		out.println("<p><a href='"+request.getContextPath()+"/study/0425/t04.jsp'>돌아가기</a></p>");
	}
}
