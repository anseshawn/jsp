package guest;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GuestList")
public class GuestList extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestDAO dao = new GuestDAO();
		
		// 1. 현재 페이지 번호를 구해온다. (첫화면은 무조건 1페이지, 페이지처리가 없음) (다음 페이지부터 페이지 처리)
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		
		// 2. 한페이지의 분량을 구한다.
		int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		
		// 3. 총 레코드 건수를 구한다.(sql 명령어 중 count 함수 이용)
		int totRecCnt = dao.getTotRecCnt();
		
		// 4. 총 페이지 건수를 구한다.
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize)+1;
		if(pag > totPage) pag = 1;
		
		// 5. 현재페이지에서 출력할 '시작 인덱스 번호'를 구한다.
		int startIndexNo = (pag-1) * pageSize;
		
		// 6. 현재 화면에 표시될 시작 실제번호를 구한다.
		int curScrStartNo = totRecCnt - startIndexNo;
		
		// ---> vo로 묶으면 편하다
		
		// 블록페이징처리...(시작 블록을 0으로 설정)
		// 1. 블록의 크기 결정(여기선 3으로 결정...)
		int blockSize = 3;
		
		// 2. 현재 페이지가 속한 블록 번호를 구한다
		// (예: 총 레코드수가 38개인 경우, 1페이지 분량이 5개 라면 총 페이지 수는 8개이다. 이 때 0블록엔 1,2,3페이지 1블록엔 4,5,6페이지 2블록은 7,8 페이지
		int curBlock = (pag - 1) / blockSize;
		
		// 3. 마지막 블록을 구한다
		int lastBlock = (totPage - 1) / blockSize;
		
		// 한페이지에 표시할 건수 만(pageSize수만큼)을 DAO에서 가져온다.
		ArrayList<GuestVO> vos = dao.getGuestList(startIndexNo, pageSize);

		// 설정(지정)된 페이지의 모든 자료(변수)들을 viewPage로 넘겨줄 준비를 한다. 
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		
		request.setAttribute("vos", vos);
		
		String viewPage = "/guest/guestList.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
