package pds;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminDAO;
import admin.review.ReviewVO;

public class PdsContentCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null ? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		String part = request.getParameter("part")==null ? "" : request.getParameter("part");
		
		PdsDAO dao = new PdsDAO();
		
		PdsVO vo = dao.getPdsIdxSearch(idx);
		
		// 해당 글의 리뷰 내용 가져오기
		AdminDAO aDao = new AdminDAO();
		ArrayList<ReviewVO> rVos = aDao.getReviewList(idx,"pds");
		
		// 별점 평균 구하기
		int reviewTot = 0;
		for(ReviewVO r : rVos) {
			reviewTot += r.getStar();
		}
		double reviewAvg = 0.0;
		if(rVos.size() != 0) reviewAvg = (double) reviewTot / rVos.size();
		
		request.setAttribute("vo", vo);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("part", part);
		request.setAttribute("rVos", rVos);
		request.setAttribute("reviewAvg", reviewAvg);
	}

}
