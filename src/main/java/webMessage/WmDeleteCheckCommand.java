package webMessage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WmDeleteCheckCommand implements WebMessageInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int mFlag = request.getParameter("mFlag")==null ? 0 : Integer.parseInt(request.getParameter("mFlag"));
		
		WebMessageDAO dao = new WebMessageDAO();
		
		int res = dao.wmDeleteCheck(idx, mFlag);
		
		if(res == 1) {
			request.setAttribute("message", "메세지가 휴지통으로 이동합니다.");
		}
		else {
			request.setAttribute("message", "메세지 삭제 실패~");
		}
		request.setAttribute("url", "WebMessage.wm?mFlag="+mFlag);
	}

}
