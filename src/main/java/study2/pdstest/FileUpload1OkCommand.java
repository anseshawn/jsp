package study2.pdstest;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import study2.StudyInterface;

/*
	자바 파일 업로드시... (COS라이브러리 대신 어노테이션 쓰는 방법 - 컨트롤러에서 아래 어노테이션 안에 환경설정 처리한다.)
	@MultipartConfig(
			location = "/images/pdstest",
			maxFileSize = 1024 * 1024 * 10,
			maxRequestSize = 1024 * 1024 * 10 * 10
	)
*/

public class FileUpload1OkCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// String fName = request.getParameter("fName")==null ? "" : request.getParameter("fName");
		//System.out.println("fName : "+fName);
		
		/*
			COS 라이브러리에서 제공해주는 객체 : MultipartRequest() / DefaultFileRenamePolicy() : (파일명 중복될 경우 자동으로 정수를 부여해줌)
			사용법 : MultipartRequest(저장소명(request),'서버에 저장될 파일의 경로','서버에 저장될 파일의 최대용량','코드변환방식(UTF-8)',기타옵션(파일명 중복 방지처리)) -xml혹은 어노테이션에 필수로 적어야하는 네가지+기타옵션
			
			저장되는 서버 웹사이트의 절대경로 : /webapp - getRealPath("/")
			
			ServletContext application = request.getServletContext(); // 어플리케이션의 경로
			application.getRealPath("/"); 	// --> /webapp을 의미한다.
		*/
		
//		ServletContext application = request.getServletContext();
//		application.getRealPath("/");
		
		String realPath = request.getServletContext().getRealPath("/images/pdstest");
		int maxSize = 1024 * 1024 * 10; // 서버에 저장시킬 파일의 최대용량(1회 저장용량) : 10MByte로 제한 중...
		String encoding = "UTF-8";
		
		// 파일 업로드 처리...(객체 생성시 파일이 자동으로 업로드 된다.)
		// request에서 multipartRequest로 일임했기 때문에 request.로 정보를 불러올 시 껍데기만 있게 됨
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		// 업로드 된 파일의 정보를 추출해본다.
		String originalFileName = multipartRequest.getOriginalFileName("fName"); // 업로드 시키는 파일의 이름 가져옴
		String filesystemName = multipartRequest.getFilesystemName("fName"); // 서버에 저장되는 파일명
		
		// ----> 항상 체크할 사항 세가지
		System.out.println("원본 파일명 : "+originalFileName);
		System.out.println("서버에 저장된 파일명 : "+filesystemName);
		System.out.println("서버에 저장된 파일 경로 : "+realPath);
		
		
		// 업로드한 사람 닉네임 받아서 찍어보기
		// String nickName = request.getParameter("nickName"); // 값이 없기 때문에 찍히지 않음
		String nickName = multipartRequest.getParameter("nickName");
		System.out.println("nickName : "+nickName);
		
		// BackEnd 파일체크
		if(originalFileName != null && !originalFileName.equals("")) {
			request.setAttribute("message", "파일 전송완료!!");
		}
		else {			
			request.setAttribute("message", "파일 전송실패!!");
		}
		
		request.setAttribute("url", "FileUpload1.st");			
		
	}

}
