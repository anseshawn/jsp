package study2.transaction;

import java.io.FileNotFoundException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TransactionDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	String sql = "";
	
	public TransactionDAO() {
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/javaclass";
		String user = "root";
		String password = "1234";
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패 "+e.getMessage());
		} catch (SQLException e) {
			System.out.println("DB연동 실패 " +e.getMessage());
		}
	}
	
	public void connClose() {
		try {
			if(conn != null) {
				conn.close();
			}
		} catch (SQLException e) {}
	}
	
	public void pstmtClose() {
		try {
			if(pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {}
	}
	
	public void rsClose() {
		try {
			if(rs != null) {
				rs.close();
				pstmt.close();
			}
		} catch (SQLException e) {}
	}

	// bankBook테이블의 정보 가져오기 (ajax)처리중
	public ArrayList<BankBookVO> getBankBookList(String mid) {
		ArrayList<BankBookVO> vos = new ArrayList<>();
		try {
			sql = "select * from bankBook where mid=? order by idx desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BankBookVO vo = new BankBookVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setBalance(rs.getInt("balance"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	//mid를 bankBook테이블에서 검색하여 해당 항목의 idx를 구해온다.
	public BankBookVO getBankBookMidSearch(String mid) {
		BankBookVO vo = new BankBookVO();
		try {
			sql = "select * from bankBook where mid = ? order by idx desc limit 1";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(mid);
				vo.setBalance(rs.getInt("balance"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	// BankBookHistory에 사용내역 저장하기
	public void setBankBookHistoryInput(BankBookVO vo) {
		try {
			// 트랜잭션 설정 : false를 인자값으로 설정하여 수동커밋으로 지정한다.
			conn.setAutoCommit(false);
			
			sql = "insert into bankBookHistory values (default, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getIdx());
			pstmt.setString(2, vo.getContent());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
			try {
				// 커넥션 객체가 진행중인 상태에서 예외처리를 만나면 롤백시킨다.
				if(conn != null) conn.rollback(); // 예외오류 발생시는 기존에 작업된 sql문이 모두 rollback처리된다.
			} catch (Exception e2) {}
		} finally {
			pstmtClose();
		}
	}

	// 실제 잔고에 적용하기
	public void setBankBookInput(BankBookVO vo, String err) {
		try {
			sql = "insert into bankBook values (default, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setInt(2, vo.getBalance());
			pstmt.executeUpdate();
			
			if(err != null && !err.equals("")) {
				try {
					throw new Exception("진행 오류 발생!!");
				} catch (Exception e) {
					if(conn != null) conn.rollback();
				}
			}
			
			// 한 작업 단위의 트랜잭션이 정상적으로 종료된 후에 트랜잭션을 커밋시킨다. 
			// 트랜잭션 커밋
			conn.commit();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
			try {
				// 커넥션 객체가 진행중인 상태에서 예외처리를 만나면 롤백시킨다.
				if(conn != null) conn.rollback(); // 예외오류 발생시는 기존에 작업된 sql문이 모두 rollback처리된다.
			} catch (Exception e2) {}
		} finally {
			pstmtClose();
		}
	}
	
}
