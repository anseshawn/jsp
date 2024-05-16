package admin.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminDAO;
import admin.AdminInterface;

public class SelectedMemberLevelChangeCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String items = request.getParameter("items")==null ? "" : request.getParameter("items");
		int level = request.getParameter("level")==null ? 999 : Integer.parseInt(request.getParameter("level"));
		
		AdminDAO dao = new AdminDAO();
		String[] item = items.split("/");
		int idx;
		int res=0;
		for(int i=0; i<item.length; i++) {
			idx = Integer.parseInt(item[i]);
			res += dao.setSelectedMemberLevelChange(idx,level);
		}
		
		// 혹시 중간에 오류나서 선택한 회원 수보다 적게 변경되었을 경우를 대비해서... 
		if(res < item.length) res = 0;
		else res = 1;
		
		response.getWriter().write(res+"");
	}

}
