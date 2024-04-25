package study.j0425;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/j0425/T12Ok")
public class T12Ok extends HttpServlet {
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
		
		String hobby = "";
		if(hobbys != null) {
			for(String h : hobbys) {
				hobby += h+"/";
			}
			hobby = hobby.substring(0, hobby.length()-1);			
		}
		
		String mountain = "";
		if(mountains != null) {
			for(String m : mountains) {
				mountain += m+"/";
			}
			mountain = mountain.substring(0, mountain.length()-1);			
		}
		
		System.out.println("성명 : "+name);
		System.out.println("나이 : "+age);
		System.out.println("성별 : "+gender);
		System.out.println("취미 : "+hobby);
		System.out.println("직업 : "+job);
		System.out.println("가본 산 : "+mountain);
		System.out.println("자기소개 : "+content);
		System.out.println("파일명 : "+fileName);
		
		T12VO vo = new T12VO();
		vo.setName(name);
		vo.setAge(age);
		vo.setGender(gender);
		vo.setHobby(hobby);
		vo.setJob(job);
		vo.setMountain(mountain);
		vo.setContent(content);
		vo.setFileName(fileName);
		
		// query string으로 넘기는 방식(get 방식)
		// 코드 등 값 때문에 에러가 나는 경우가 발생함
		// response.sendRedirect(request.getContextPath()+"/study/0425/t12_Main.jsp?name="+name+"&age="+age+"&gender="+gender+"&hobby="+hobby+"&job="+job+"&mountain="+mountain);
		
		// vo로 넘기기
		//response.sendRedirect(request.getContextPath()+"/study/0425/t12_Main.jsp?vo="+vo);
		
		
		// 직렬화방법
		// 앞으로 계속 가고 있는 request 객체에 vo를 실어줘야함 (가는 동안 짐 싣는 개념)
		request.setAttribute("vo", vo); // (넘겨줄 변수, 받을)
		
		String viewPage = "/study/0425/t12_Main.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
