package webMessage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.board.BoardContentCommand;
import admin.board.BoardListCommand;
import admin.complaint.BoardComplaintInputCommand;
import admin.complaint.ComplaintCheckCommand;
import admin.complaint.ComplaintListCommand;
import admin.member.MemberDeleteOkCommand;
import admin.member.MemberLevelChangeCommand;
import admin.member.MemberListCommand;
import admin.member.SelectedMemberLevelChangeCommand;
import admin.review.ReviewDeleteCommand;
import admin.review.ReviewInputOkCommand;
import admin.review.ReviewReplyInputOkCommand;

@WebServlet("*.wm")
public class WebMessageController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		WebMessageInterface command = null;
		String viewPage = "/WEB-INF/webMessage";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"),com.lastIndexOf("."));
		
		// 인증 처리
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		if(level > 4) {
			request.setAttribute("message", "로그인 후 사용해 주세요.");
			request.setAttribute("url", request.getContextPath()+"/MemberLogin.mem");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/WebMessage")) {
			command = new WebMessageCommand();
			command.execute(request, response);
			viewPage += "/webMessage.jsp";
		}
		else if(com.equals("/WmInputOk")) {
			command = new WmInputOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/WmDeleteCheck")) {
			command = new WmDeleteCheckCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/WmDeleteOne")) {
			command = new WmDeleteOneCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/WmDeleteAll")) {
			command = new WmDeleteAllCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/IdSearchCheck")) {
			command = new IdSearchCheckCommand();
			command.execute(request, response);
			viewPage += "/webMessage.jsp";
		}
		else if(com.equals("/WmRestore")) {
			command = new WmRestoreCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
