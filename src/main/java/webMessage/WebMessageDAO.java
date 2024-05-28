package webMessage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.GetConn;
import member.MemberVO;

public class WebMessageDAO {
	
	private Connection conn = GetConn.getConn(); // conn 을 가져올 수 있도록 메소드 부르기...
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	private WebMessageVO vo = null;

	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {}
		}
	}
	
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {}
			finally {
				pstmtClose();
			}
		}
	}

	// 메세지 전체 리스트 보기
	public ArrayList<WebMessageVO> getMessageList(String mid, int mSw, int startIndexNo, int pageSize) {
		ArrayList<WebMessageVO> vos = new ArrayList<WebMessageVO>();
		try {
			if(mSw == 1) { // 받은메세지(처음에는 전체메세지(새메세지+읽은메세지))
				sql = "select *,timestampdiff(hour,sendDate,now()) as hour_diff from webMessage"
						+ " where receiveId=? and (receiveSw='n' or receiveSw='r') order by idx desc";				
			}
			else if(mSw == 2) { // 신규 메세지
				sql = "select *,timestampdiff(hour,sendDate,now()) as hour_diff from webMessage"
						+ " where receiveId=? and receiveSw='n' order by idx desc";				
			}
			else if(mSw == 3) { // 보낸 메세지
				sql = "select *,timestampdiff(hour,sendDate,now()) as hour_diff from webMessage"
						+ " where sendId=? and sendSw='s' order by idx desc";				
			}
			else if(mSw == 4) { // 수신확인
				sql = "select *,timestampdiff(hour,sendDate,now()) as hour_diff from webMessage"
						+ " where sendId=? and receiveSw='n' order by idx desc";				
			}
			else if(mSw == 5) { // 휴지통
				sql = "select *,timestampdiff(hour,sendDate,now()) as hour_diff from webMessage"
						+ " where (receiveId=? and receiveSw='g') or (sendId=? and sendSw='g') order by idx desc";				
			}
			else { // mSw가 0번 혹은 6번일때
				return vos;				
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			if(mSw == 5) pstmt.setString(2, mid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new WebMessageVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setSendId(rs.getString("sendId"));
				vo.setSendSw(rs.getString("sendSw"));
				vo.setSendDate(rs.getString("sendDate"));
				vo.setReceiveId(rs.getString("receiveId"));
				vo.setReceiveSw(rs.getString("receiveSw"));
				vo.setReceiveDate(rs.getString("receiveDate"));
				
				vo.setHour_diff(rs.getInt("hour_diff"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL오류: "+e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 메세지 작성
	public int setWmInputOk(WebMessageVO vo) {
		int res = 0;
		try {
			sql="insert into webMessage values(default,?,?,?,default,default,?,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getSendId());
			pstmt.setString(4, vo.getReceiveId());
			
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL오류: "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 메세지 내용 보기
	public WebMessageVO getWebMessageContent(int idx, int mFlag) {
		vo = new WebMessageVO();
		try {
			if(mFlag == 11) { // 받은메세지에서 신규메세지 클릭하면 n을 r로 변경하기
				sql="update webMessage set receiveSw='r',receiveDate=now() where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.executeUpdate();
				pstmtClose();
			}
			sql = "select * from webMessage where idx=?";				
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			rs.next();
			vo.setIdx(rs.getInt("idx"));
			vo.setTitle(rs.getString("title"));
			vo.setContent(rs.getString("content"));
			vo.setSendId(rs.getString("sendId"));
			vo.setSendSw(rs.getString("sendSw"));
			vo.setSendDate(rs.getString("sendDate"));
			vo.setReceiveId(rs.getString("receiveId"));
			vo.setReceiveSw(rs.getString("receiveSw"));
			vo.setReceiveDate(rs.getString("receiveDate"));
		} catch (SQLException e) {
			System.out.println("SQL오류: "+e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	// 메세지 삭제하기
	public int wmDeleteCheck(int idx, int mSw) {
		int res = 0;
		try {
			if(mSw == 11 || mSw ==12) {	// mSw(=mFlag)값이 11은 받은편지함에서 휴지통으로 보낸경우, mSw는 새편지함에서 휴지통으로 넣은경우.
			  sql = "update webMessage set receiveSw='g' where idx = ?";
			}
			else if(mSw == 13) {	// mSw(=mFlag)값이 13은 보낸편지함에서 휴지통으로 보낸경우
				sql = "update webMessage set sendSw='g' where idx = ?";
			}
			else {	// mSw(=mFlag)값이 133이 올때는 휴지통거치지않고 삭제처리(x)
				sql = "update webMessage set sendSw='x' where idx = ?";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 휴지통에 들어있는 모든 자료들 삭제(update)처리한다. 이때 receiveSw와 sendSw가 모두 'x'이면 실제 자료를 삭제(delete)처리한다.
	public int wmDeleteAll(String mid) {
		int res = 0;
		try {
			// 받은 메세지에서의 휴지통 처리시에 수행할 sql문
			sql = "update webMessage set receiveSw='x' where receiveId=? and receiveSw='g'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
			pstmt.close();
			
			// 보낸 메세지에서의 휴지통 처리시에 수행할 sql문
			sql = "update webMessage set sendSw='x' where sendId=? and sendSw='g'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
			pstmt.close();
			
			sql = "delete from webMessage where sendSw='x' and receiveSw='x'";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL오류: "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 조건에 맞는 메세지 건수 구하기
	public int getWmTotRecCnt(String mid, int mSw) {
		int totRecCnt = 0;
		try {
			sql = "";
			if(mSw == 1) 	// 받은메세지(새메세지 + 읽은메세지)
				sql = "select count(*) from webMessage where receiveId=? and (receiveSw='n' or receiveSw='r')";
			else if(mSw == 2) 	// 새메세지(새메세지)
				sql = "select count(*) from webMessage where receiveId=? and receiveSw='n'";
			else if(mSw == 3) 	// 보낸메세지
				sql = "select count(*) from webMessage where sendId=? and sendSw='s'";
			else if(mSw == 4) 	// 수신확인
				sql = "select count(*) from webMessage where sendId=? and receiveSw='n'";
			else if(mSw == 5) 	// 휴지통
				sql = "select count(*) from webMessage where (receiveId=? and receiveSw='g') or (sendId=? and sendSw='g')";
			else return totRecCnt;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			if(mSw == 5) pstmt.setString(2, mid);
			
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("SQL오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return totRecCnt;
	}

	// 회원 부분 검색하기
	public ArrayList<MemberVO> getIdSearchCheck(String mid) {
		ArrayList<MemberVO> vos = new ArrayList<MemberVO>();
		try {
			sql = "select idx,mid,nickName from member where mid like ? order by mid";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+mid+"%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberVO vo = new MemberVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 고유번호(idx)로 메세지 내역 가져오기
	public WebMessageVO getWebMessageIxdSearch(int idx) {
		WebMessageVO vo = new WebMessageVO();
		try {
			sql = "select * from webMessage where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			rs.next();
			
			vo.setIdx(rs.getInt("idx"));
			vo.setTitle(rs.getString("title"));
			vo.setContent(rs.getString("content"));
			vo.setSendId(rs.getString("sendId"));
			vo.setSendSw(rs.getString("sendSw"));
			vo.setSendDate(rs.getString("sendDate"));
			vo.setReceiveId(rs.getString("receiveId"));
			vo.setReceiveSw(rs.getString("receiveSw"));
			vo.setReceiveDate(rs.getString("receiveDate"));
		} catch (SQLException e) {
			System.out.println("SQL오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	// 메세지 복원시키기
	public void setWmRestore(int idx, String sw) {
		try {
			if(sw.equals("s")) sql = "update webMessage set sendSw = 's' where idx = ?";
			else sql = "update webMessage set receiveSw = 'r' where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}
}
