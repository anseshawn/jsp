package member;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.SecurityUtil;

public class MemberJoinOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String gender = request.getParameter("gender")==null ? "" : request.getParameter("gender");
		String birthday = request.getParameter("birthday")==null ? "" : request.getParameter("birthday");
		String tel = request.getParameter("tel")==null ? "" : request.getParameter("tel");
		String address = request.getParameter("address")==null ? "" : request.getParameter("address");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String homePage = request.getParameter("homePage")==null ? "" : request.getParameter("homePage");
		String job = request.getParameter("job")==null ? "" : request.getParameter("job");
		// String hobby = request.getParameter("hobby")==null ? "" : request.getParameter("hobby");
		String photo = request.getParameter("photo")==null ? "noimage.jpg" : request.getParameter("photo");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		String userInfor = request.getParameter("userInfor")==null ? "" : request.getParameter("userInfor");
		
		String[] hobbys = request.getParameterValues("hobby");
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
		UUID uid = UUID.randomUUID();
		String saltKey = uid.toString().substring(0,8);
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		
		// 모든 체크가 끝난 자료는 vo에 담아서 DB에 저장처리한다.
		vo = new MemberVO();
		vo.setMid(mid);
		vo.setPwd(saltKey+pwd); // vo.setPwd(salt+pwd); // 솔트키를 앞에 놓고 저장 후 나중에 앞의 여덟자리만 잘라서 비교
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
