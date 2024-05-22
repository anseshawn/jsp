package pds;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PdsTotalDownCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		// DB에 저장된 파일의 정보(원본파일/서버에 저장된 파일)를 가져온다.
		PdsDAO dao = new PdsDAO();
		PdsVO vo = dao.getPdsIdxSearch(idx);
		
		// 원본파일명과 서버저장파일명을 각각 분리시킨다.
		String[] fNames = vo.getfName().split("/");
		String[] fSNames = vo.getfSName().split("/");
		
		// 파일을 압축하기 위해 필요한 객체들을 선언한다.
		FileInputStream fis = null;
		FileOutputStream fos = null;
			// 파일을 가져와서(input) 따로 모아놓은 곳에(output) zip파일을 쓴다(output)
		ZipOutputStream zos = null;
			// zos에 있는 것을 꺼내서 서블릿을 타고 나와 클라이언트로 가서 저장한다(output)
		ServletOutputStream sos = null;
		
		// 파일을 모아놓는 껍데기를 만들어야 함
		String realPath = request.getServletContext().getRealPath("/images/pds/");
		String zipPath = request.getServletContext().getRealPath("/images/pds/temp/"); // zip파일 경로 (파일명 중복 되지 않도록 temp폴더를 따로 만들어서 작업)
		String zipName = vo.getTitle() + ".zip";
		
		fos = new FileOutputStream(zipPath + zipName); // 출력될 압축파일의 이름 경로
		zos = new ZipOutputStream(fos);
		
		byte[] buffer = new byte[2048];
		int size = 0;
		
		// 각각의 파일을 압축처리 하기 위한 fis를 생성 후 zos에 처리한다.
		for(int i=0; i<fSNames.length; i++) {
			File file = new File(realPath + fSNames[i]);
			fis = new FileInputStream(file);
			zos.putNextEntry(new ZipEntry(fSNames[i]));
			
			while((size = fis.read(buffer)) != -1) {
				zos.write(buffer,0,size);
			}
			zos.flush();
			zos.closeEntry(); // 다음 순서로 들어올 파일을 위해 zip파일 자체를 닫는 것이 아니라 entry만 닫아줌 
			fis.close();
		}
		zos.close();
		// ----> 여기까지가 temp폴더에 압축파일 만들기
		
		// **파일명에 물음표 등 문자가 들어가면 전송이 안 되기 때문에 업로드 시 부터 파일명 관리해줘야 함**
		// 서버에서 압축작업이 완료되면, 압축파일을 클라이언트로 전송하고, 서버에 존재하는 압축파일은 삭제시킨다.
		// 클라이언트로 파일을 전송할 시에는 HTTP 프로토콜형식에 맞도록 헤더에 정보를 제공해줘야한다.
		
		// ----> temp폴더의 압축 파일을 읽어와서(input) 클라이언트 컴퓨터에 저장하기(output)
		
		String downLoadName = "";
		if(request.getHeader("user-agent").indexOf("MSIE") == -1) {
			downLoadName = new String(zipName.getBytes("UTF-8"),"8859_1"); //윈도우의 기본형식을 UTF-8로 변환
		}
		else downLoadName = new String(zipName.getBytes("EUC-KR"),"8859_1");
		
		// 헤더에 정보를 첨부...
		response.setHeader("Content-Disposition", "attachment;filename="+downLoadName);
		
		fis = new FileInputStream(zipPath+zipName);
		sos = response.getOutputStream(); // 받아주는 쪽의 껍데기 만들기
		
		while((size = fis.read(buffer,0,buffer.length)) != -1) {
			sos.write(buffer,0,size);
		}
		sos.flush(); // buffer에 남아있는 것까지 다 보내기
		sos.close();
		fis.close();
		
		// 클라이언트에 파일 전송을 마치면 서버에 존재하는 zip 파일을 삭제처리한다.
		new File(zipPath+zipName).delete();
		
		// 다운로드 수를 증가시킨다.
		dao.setPdsDownNumCheck(idx);
	}

}
