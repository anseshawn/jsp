package study2.pdstest;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(
	//location = "/경로명", (String)
	fileSizeThreshold = 1024 * 1024,			// 업로드 시 메모리에 저장되는 임시파일 크기 설정(int)
	maxFileSize = 1024 * 1024 * 5,				// 업로드시 1개 파일의 최대 용량은 5MByte(long타입)
	maxRequestSize = 1024 * 1024 * 5 * 10	// 한번에 request 시 전송할 파일의 최대크기(long타입)
)
@WebServlet("/FileUpload6Ok")
public class FileUpload6Ok extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/pdstest/");
		
		// request 객체 내부 getParts() 메소드를 사용하여 배열로 받는다.
		Collection<Part> fileParts = request.getParts();
		
		for(Part filePart : fileParts) {
			if(!filePart.getName().equals("fName")) continue;
			if(filePart.getSize() == 0) continue;
			
			String fileName = filePart.getSubmittedFileName();			
			InputStream fis = filePart.getInputStream();
			
			String uid = UUID.randomUUID().toString().substring(0,8);
			fileName = fileName.substring(0,fileName.lastIndexOf(".")) + "_" + uid + fileName.substring(fileName.lastIndexOf("."));
			
			FileOutputStream fos = new FileOutputStream(realPath+fileName);
			
			byte[] buffer = new byte[2048];
			int size = 0;
			// 자료가 -1이 아닌 동안에(있는 동안에)
			//while((size=fis.read(buffer,0,buffer.length)) != -1) {
			while((size=fis.read(buffer)) != -1) {
				fos.write(buffer,0,size); // 0부터 size까지 다 읽어서 넣는다
			}
			fos.close();
			fis.close();
		}
				
		request.setAttribute("message", "파일이 업로드 되었습니다.");
		request.setAttribute("url", "FileUpload6.st");
		
		String viewPage = "/include/message.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
