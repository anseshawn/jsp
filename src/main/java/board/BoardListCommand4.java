package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.Pagination;
//
//public class BoardListCommand4 implements BoardInterface {
//
//	@Override
//	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		BoardDAO dao = new BoardDAO();
//		
//		// 페이징 처리 시작
//		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
//		int pageSize = request.getParameter("pageSize")==null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
//		
//		Pagination2.pageChange(request,pag,pageSize,"board",""); // totRecCnt와 dao.getBoardList(startIndexNo)를 대변하기 위해 넘김a
//	}
//
//}
