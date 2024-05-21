package study2.pdstest;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import study2.StudyInterface;

public class FileUpload4OkCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String realPath = request.getServletContext().getRealPath("/images/pdstest");
		int maxSize = 1024 * 1024 * 10;
		String encoding = "utf-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding,new DefaultFileRenamePolicy());
		
		// 업로드 된 파일의 정보를 추출해본다.
		// (자료가 열거형으로 들어가있음)
		
		String fNames = multipartRequest.getParameter("fNames");
		
		Enumeration fileNames = multipartRequest.getFileNames();
		
		String file = "";
		String oFileName = "";
		String fsName = "";
		
		while(fileNames.hasMoreElements()) {
			file = (String)fileNames.nextElement();
			oFileName += multipartRequest.getOriginalFileName(file) + "/";
			fsName += multipartRequest.getFilesystemName(file)+"/";
			
		}
		oFileName = oFileName.substring(0, oFileName.lastIndexOf("/"));
		fsName = fsName.substring(0, fsName.lastIndexOf("/"));
		System.out.println("원본 파일명 : "+oFileName);
		System.out.println("서버에 저장된 파일명 : "+fsName);
		
		System.out.println("클라이언트에서 업로드된 파일명 : " + fNames);
		
		if(oFileName != null && !oFileName.equals("")) {
			request.setAttribute("message", "파일이 업로드 되었습니다.");
		}
		else {
			request.setAttribute("message", "파일 업로드 실패");			
		}
		request.setAttribute("url", "FileUpload4.st");
	}

}
