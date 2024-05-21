package member;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.SecurityUtil;

public class MemberJoinOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/member"); // 파일명이 아니고 경로, 마지막에 '/' 안 줘도 됨 
		int maxSize = 1024 * 1024 * 2;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		String mid = multipartRequest.getParameter("mid")==null ? "" : multipartRequest.getParameter("mid");
		String pwd = multipartRequest.getParameter("pwd")==null ? "" : multipartRequest.getParameter("pwd");
		String nickName = multipartRequest.getParameter("nickName")==null ? "" : multipartRequest.getParameter("nickName");
		String name = multipartRequest.getParameter("name")==null ? "" : multipartRequest.getParameter("name");
		String gender = multipartRequest.getParameter("gender")==null ? "" : multipartRequest.getParameter("gender");
		String birthday = multipartRequest.getParameter("birthday")==null ? "" : multipartRequest.getParameter("birthday");
		String tel = multipartRequest.getParameter("tel")==null ? "" : multipartRequest.getParameter("tel");
		String address = multipartRequest.getParameter("address")==null ? "" : multipartRequest.getParameter("address");
		String email = multipartRequest.getParameter("email")==null ? "" : multipartRequest.getParameter("email");
		String homePage = multipartRequest.getParameter("homePage")==null ? "" : multipartRequest.getParameter("homePage");
		String job = multipartRequest.getParameter("job")==null ? "" : multipartRequest.getParameter("job");
		String photo = multipartRequest.getFilesystemName("fName")==null ? "noimage.jpg" : multipartRequest.getFilesystemName("fName");
		String content = multipartRequest.getParameter("content")==null ? "" : multipartRequest.getParameter("content");
		String userInfor = multipartRequest.getParameter("userInfor")==null ? "" : multipartRequest.getParameter("userInfor");
		String[] hobbys = multipartRequest.getParameterValues("hobby");
		
		String hobby = "";
		if(hobbys.length != 0) {
			for(String h : hobbys) {
				hobby += h + "/";
			}
		}
		hobby = hobby.substring(0, hobby.lastIndexOf("/"));
		
		// DB에 저장시킬 자료 중 not null 데이터는 BackEnd 체크 시켜준다...(추후에)
		
		// 아이디 / 닉네임 중복체크...
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberIdCheck(mid);
		if(vo.getMid() != null) {
			request.setAttribute("message", "이미 사용중인 아이디입니다.");
			request.setAttribute("url", "/MemberJoin.mem");
			return;
		}
		vo = dao.getMemberNickCheck(nickName);
		if(vo.getNickName() != null) {
			request.setAttribute("message", "이미 사용중인 닉네임입니다.");
			request.setAttribute("url", "/MemberJoin.mem");
			return;
		}
		
		// 비밀번호 암호화(SHA-256) - salt키를 만든 후 암호화 시켜준다...(uuid코드 중 앞의 8자리와 같이 병행 처리 후 암호화)
		UUID uuid = UUID.randomUUID();
		String salt = uuid.toString().substring(0,8);
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt+pwd);
		
		pwd = salt + pwd; // DB에 따로 salt키 필드를 만들지 않고(만들면 보안에 취약) pwd에 합쳐서 저장
		
		// 모든 체크가 끝난 자료는 vo에 담아서 DB에 저장처리한다.
		vo = new MemberVO();
		vo.setMid(mid);
		vo.setPwd(pwd); // vo.setPwd(salt+pwd); // 솔트키를 앞에 놓고 저장 후 나중에 앞의 여덟자리만 잘라서 비교
		vo.setNickName(nickName);
		vo.setName(name);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		vo.setHomePage(homePage);
		vo.setJob(job);
		vo.setHobby(hobby);
		vo.setPhoto(photo);
		vo.setContent(content);
		vo.setUserInfor(userInfor);
		
		int res = dao.setMemberJoinOk(vo);
		
		if(res != 0) {
			request.setAttribute("message", "회원 가입이 완료되었습니다.\\n 다시 로그인 해 주세요.");
			request.setAttribute("url", "MemberLogin.mem");
		}
		else {
			request.setAttribute("message", "회원 가입 실패");
			request.setAttribute("url", "MemberJoin.mem");
		}
	}

}
