package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoardContentCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null ? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		
		BoardDAO dao = new BoardDAO();
		
		// 게시글 조회수 1씩 증가시키기(중복방지)
		HttpSession session = request.getSession();
		ArrayList<String> contentReadNum = (ArrayList<String>)session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "board" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			dao.setBoardReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		BoardVO vo = dao.getBoardContent(idx);
		request.setAttribute("vo", vo);
		
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		
		// 이전글 / 다음글 처리
		// idx와 title이라는 변수는 본문이 사용하고 있기 때문에 본문에 변화를 줘야 함
		BoardVO preVo = dao.getPreNextSearch(idx,"preVo");
		BoardVO nextVo = dao.getPreNextSearch(idx,"nextVo");
		request.setAttribute("preVo", preVo);
		request.setAttribute("nextVo", nextVo);
	}

}
