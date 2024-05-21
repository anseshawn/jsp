package study2.pdstest;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
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
@WebServlet("/FileUpload5Ok")
public class FileUpload5Ok extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/pdstest/");
		
		// request 객체 내부 getPart() 메소드를 사용하여 업로드 되는 1개 파일의 정보를 받는다.
		Part filePart = request.getPart("fName");	// form태그의 file 속성의 name 명을 적는다.
		String fileName = filePart.getSubmittedFileName();		// 클라이언트에서 전송한 파일이름(서버에 저장되는 파일명 x)
		// 클라이언트에서 서버로 파일을 input
		InputStream fis = filePart.getInputStream();					// 파일 입력 스트림 생성 (자바는 입력,출력이 무조건 있어야 한다)
		
		// 파일명 중복방지를 위한 처리 (atom.jpg -> atom_5wqe3s4j.jpg)
		String uid = UUID.randomUUID().toString().substring(0,8);
		fileName = fileName.substring(0,fileName.lastIndexOf(".")) + "_" + uid + fileName.substring(fileName.lastIndexOf("."));
		
		// 클라이언트에서 오는 파일을 가져와서 내 파일 시스템을 생성하여 그곳에 가공하여 저장
		FileOutputStream fos = new FileOutputStream(realPath+fileName); // 파일 출력 스트림 생성
		// (서버 내에서 이동할 때는 하나하나 생성해줘야 함)
		
		// 전송되는 파일을 2048Byte(2k) 단위로 버퍼에 읽어서 서버 파일 시스템에 저장한다. (서버에 부하가 걸리지 않을 정도로 줘야 한다)
		byte[] buffer = new byte[2048];
		int size = 0;
		// 자료가 -1이 아닌 동안에(있는 동안에)
		while((size=fis.read(buffer)) != -1) {
			fos.write(buffer,0,size); // 0부터 size까지 다 읽어서 넣는다
		}
		fos.close();
		fis.close();
		
		request.setAttribute("message", "파일이 업로드 되었습니다.");
		request.setAttribute("url", "FileUpload5.st");
		
		String viewPage = "/include/message.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
