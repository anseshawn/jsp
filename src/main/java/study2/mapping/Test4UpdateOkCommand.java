package study2.mapping;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Test4UpdateOkCommand implements Test4Interface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이곳은 Test4UpdateOkCommand 입니다.");
		
		String message = "자료가 수정되었습니다.";
		request.setAttribute("message", message);
		request.setAttribute("url", "test4.do4");
	}

}
