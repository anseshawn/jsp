package study2.pdstest;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyInterface;

public class FileDeleteCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fileName = request.getParameter("fileName")==null ? "" : request.getParameter("fileName");
		
		String realPath = request.getServletContext().getRealPath("/images/pdstest/");
		
		// 파일을 지울 땐 항상 내용물 없는 껍데기만 있는 파일 객체를 생성하여 지워야 함
		File file = new File(realPath+fileName); // 슬래시에 유의할 것
		
		String res = "0";
		
		if(file.exists()) {
			file.delete();
			res = "1";
		}
		
		response.getWriter().write(res);
	}

}
