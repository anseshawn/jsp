package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter("/*") // 경로를 의미, 전체 경로에서 필터를 통과하도록
public class FilterTest implements Filter {
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		System.out.println("1. 필터 수행 전입니다.");
		
		chain.doFilter(request, response);
		// 아무것도 거르지 않고 요청이 들어오는 대로 응답하겠다는 의미
		
		System.out.println("2. 필터 수행 후입니다.\n");
	}

}
