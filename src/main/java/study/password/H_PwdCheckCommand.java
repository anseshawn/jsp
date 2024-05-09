package study.password;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class H_PwdCheckCommand implements H_PwdInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String str = "";
		
		if(idx == 1) {
			str = "<h5>숫자 비밀번호</h5><br/>";
			
			int key = 0x1234ABCD;
			int encPwd, decPwd;
			encPwd = Integer.parseInt(pwd) ^ key;
			
			str += "1.기존 비밀번호 : "+pwd+"<br/>";
			str += "2.인코딩 된 비밀번호 : "+"1234ABCD"+encPwd+"<br/>";
			
			decPwd = encPwd ^ key;
			str += "3.디코딩 된 비밀번호 : "+decPwd+"<br/><br/>";
			
			response.getWriter().write(str);			
		}
		else if(idx == 2) {
			str = "<h5>문자 비밀번호</h5><br/>";
			
			long intPwd;
			String strPwd = "";
			
			for(int i=0; i<pwd.length(); i++) {
				intPwd = (long)pwd.charAt(i);
				strPwd += intPwd;
			}
			str += "1.아스키코드 문자로 변환 된 비밀번호 : "+strPwd+"<br/>";
			
			intPwd = Long.parseLong(strPwd);
			long key = 0x1234ABCD;
			long encPwd;
			
			encPwd = intPwd ^ key;
			strPwd = String.valueOf(encPwd);
			
			str += "2.인코딩 된 비밀번호 : "+strPwd+"<br/>";
			
			long decPwd;
			intPwd = Long.parseLong(strPwd);
			decPwd = intPwd ^ key;
			str += "3.디코딩 된 비밀번호 : "+decPwd+"<br/>";
			
			strPwd = String.valueOf(decPwd);
			String result = "";
			char ch;
			
			for(int i=0; i<strPwd.length(); i+=2) {
				ch = (char)Integer.parseInt(strPwd.substring(i,i+2));
				result += ch;
			}
			
			str += "4.최종 변환 된 비밀번호 : "+result+"<br/><br/>";
			
			response.getWriter().write(str);
		}
	}

}
