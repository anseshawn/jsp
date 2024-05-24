package schedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import admin.review.ReviewVO;
import common.GetConn;

public class ScheduleDAO {
	
//	GetConn getConn = GetConn.getInstance(); // 객체에 접근... 하려고 했으나 안됨...
	
	private Connection conn = GetConn.getConn(); // conn 을 가져올 수 있도록 메소드 부르기...
//	private Connection conn2 = GetConn.getConn(); // 싱글톤 비교해보기 위한 문장
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	private ScheduleVO vo = null;

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
	
	// 해당 날짜의 스케줄 내역 가져오기
	public ArrayList<ScheduleVO> getScheduleList(String mid, String ymd, int sw) {
		ArrayList<ScheduleVO> vos = new ArrayList<ScheduleVO>();
		try {
			if(sw == 0) {
				sql="select *,count(*) as partCnt from schedule where mid=? and"
						+ " date_format(sDate,'%Y-%m')=? group by sDate,part order by sDate,part;";				
			}
			else {
				//sql="select * from schedule where mid=? and substring(sDate,1,10)=? order by sDate";
				sql="select * from schedule where mid=? and date_format(sDate,'%Y-%m-%d')=? order by sDate, part";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, ymd);				
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new ScheduleVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setsDate(rs.getString("sDate"));
				vo.setPart(rs.getString("part"));
				vo.setContent(rs.getString("content"));
				
				if(sw == 0)	vo.setPartCnt(rs.getInt("partCnt"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 일정 등록하기
	public int setScheduleInputOk(ScheduleVO vo) {
		int res = 0;
		try {
			sql="insert into schedule values(default,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getsDate());
			pstmt.setString(3, vo.getPart());
			pstmt.setString(4, vo.getContent());
			
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 일정 삭제하기
	public int setScheduleDeleteOk(int idx) {
		int res = 0;
		try {
			sql = "delete from schedule where idx=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	
	public int setScheduleUpdateOk(ScheduleVO vo) {
		int res = 0;
		try {
			sql = "update schedule set part = ?, content = ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPart());
			pstmt.setString(2, vo.getContent());
			pstmt.setInt(3,  vo.getIdx());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}
	
	
}
