package study.j0424;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@SuppressWarnings("serial")
@WebServlet({"/T8"})
// 어노테이션이 없는 경우 web.xml 에서 서블릿 클래스를 만들어줘야 함 (xml 사용)
public class Test8 extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 요청객체: Request 응답객체: Response
		response.setContentType("text/html; charset=utf-8"); // 웹에서 쓰는 문서 방식과 문자형식
		
//		response.getWriter().append("1.Served at: ").append(request.getContextPath());
		System.out.println("이곳은 Get 메소드 입니다.");
		
		// 웹에 html 형식으로 보낼수 있게 하는 객체
		PrintWriter out = response.getWriter();
		out.println("<p><a href='/javaclass/study/0424/test8.jsp'>돌아가기</a></p>");
		// innerHTML과 똑같은 역할
		
//		response.getWriter().append("<p><a href='/javaclass/test8.jsp'>돌아가기</a></p>");
		// 위처럼 사용하면 생기는 문제: html 변환이 되지 않음, 서버에 들어갔다 나오면서 한글이 깨짐
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("2.Served at: ").append(request.getContextPath());
		System.out.println("이곳은 Post 메소드 입니다.");
		doGet(request, response);
	}

}
