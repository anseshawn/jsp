package study.j0430;

import java.io.IOException;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/0430/LifeCycle2Ok")
public class LifeCycle2Ok extends HttpServlet {
	
	@Override
	public void init() throws ServletException { // 처음 시작할 때만 작용
		System.out.println("이곳은 init 메소드 입니다.");
	}
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이곳은 service 메소드 입니다.");
		
		doPost(request, response);
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이곳은 doGet 메소드 입니다.");
		response.sendRedirect(request.getContextPath()+"/study/0430_web_xml/lifeCycle/lifeCycle1.jsp");
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이곳은 doPost 메소드 입니다.");		
		doGet(request, response);
	}
	
	@Override
	public void destroy() { // 종료되거나 갱신될 때만 작용
		System.out.println("이곳은 destroy 메소드 입니다.");
	}
	// init은 한번 작동하면 destroy가 오지 않는 이상은 다시 뜨지 않음
	
	@PostConstruct
	public void initPostConstructor() { // 사용자 메소드에 어노테이션을 붙여서 사용
		System.out.println("이곳은 사용자 메소드: @PostConstruct 어노테이션 사용 시 가장 먼저 수행한다.");
	}
	
	@PreDestroy
	public void destroyPreDestroy() { // 사용자 메소드에 어노테이션을 붙여서 사용
		System.out.println("이곳은 사용자 메소드: @PreDestroy 어노테이션 사용 시 가장 마지막에(갱신하거나 자원 반납시에) 수행한다...");
	}
}
