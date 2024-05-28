package common;

import javax.servlet.http.HttpServletRequest;

public class Pagination2 {
	/*
	public static int pageChange(HttpServletRequest request, int pag, int pageSize, int totRecCnt) {
		// 페이지 VO 해서 메소드 만들어오기
		
		// 페이징 처리 시작
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize)+1;
		if(pag > totPage) pag = 1;
		int startIndexNo = (pag-1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		// 페이징 처리 끝
		
		// 설정(지정)된 페이지의 모든 자료(변수)들을 viewPage로 넘겨줄 준비를 한다. 
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		
		return startIndexNo;
	} 
	*/
	
	public static void pageChange(HttpServletRequest request, int pag, int pageSize, int totRecCnt, int startIndexNo) {
		
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		if(pag > totPage) pag = 1;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totRecCnt", totRecCnt);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		
		/*
		if(!searchs.equals("")) {
			String search = "", searchString = "";
			search = searchs.split("/")[0];
			searchString = searchs.split("/")[1];
			request.setAttribute("search", search);
			request.setAttribute("searchString", searchString);
		}
		*/
	}
}
