package study2.transaction;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyDAO;
import study2.StudyInterface;

public class TransactionBankBookCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		StudyDAO dao = new StudyDAO();
		
		ArrayList<BankBookVO> vos = dao.getBankBookList(mid);
		
		request.setAttribute("vos", vos);
		// ajax로 처리했지만 response.getWriter 사용 하지 않고 append로 demo에 테이블 뿌리는 중...
	}

}
