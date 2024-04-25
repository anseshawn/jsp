package study.j0425;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/j0425/T06Ok") // 중간경로 적어주기
public class T06Ok extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8"); //넘어올 때 인코딩 해서 넘어왔어야 했기 때문에(인코딩 되지 않은 상태기 때문에) 받으면서(response) 인코딩...? (브라우저에 출력)
		request.setCharacterEncoding("utf-8"); // 서버에 요청(request)해서 인코딩 후 콘솔 출력 (서버에 출력)
		
		// front에서 넘어온 값들을 변수에 담아서 처리한다.
		String name = request.getParameter("name")==null ? "" : request.getParameter("name"); // 받아오면서 삼항연산자로 null값 체크 먼저
		int age = request.getParameter("age")==null || request.getParameter("age")=="" ? 0 : Integer.parseInt(request.getParameter("age"));
		String gender = request.getParameter("gender");
		String[] hobbys = request.getParameterValues("hobby");
		String job = request.getParameter("job");
		String[] mountains = request.getParameterValues("mountain");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		content = content.replace("\n", "<br/>"); // 엔터 포함하여 브라우저에 출력하기
		String fileName = request.getParameter("fileName");
		
		System.out.println("성명 : "+name);
		System.out.println("나이 : "+age);
		System.out.println("성별 : "+gender);
		
		String hobby = "";
		if(hobbys != null) {
			for(String h : hobbys) {
				hobby += h+"/";
			}
			hobby = hobby.substring(0, hobby.length()-1);			
		}
		System.out.print("취미 : "+hobby);
		System.out.println("직업 : "+job);
		
		String mountain = "";
		if(mountains != null) {
			for(String m : mountains) {
				mountain += m+"/";
			}
			mountain = mountain.substring(0, mountain.length()-1);			
		}
		System.out.println("가본 산 : "+mountain);
		System.out.println("자기소개 : "+content);
		System.out.println("파일명 : "+fileName);
		
		PrintWriter out = response.getWriter();
		
		out.println("<p>성명 : "+name+"</p>");
		out.println("<p>나이 : "+age+"</p>");
		out.println("<p>성별 : "+gender+"</p>");
		out.println("<p>취미 : "+hobby+"</p>");
		out.println("<p>직업 : "+job+"</p>");
		out.println("<p>가본 산 : "+mountain+"</p>");
		out.println("<p>자기소개 : "+content+"</p>");
		out.println("<p><a href='"+request.getContextPath()+"/study/0425/t06_form.jsp'>돌아가기</a></p>");
	}
}
