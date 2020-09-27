package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public MemberDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/user01?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String id, String pw) {
		String SQL = "select pw from member where id = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery(); //select문일때는 executeQuery문 insert일때는 executeUpdate
			if(rs.next()) {
				if(rs.getString(1).equals(pw)) { //setString(1,id)을 넣었을 때의 결과값(pw)
					return 1;
				}
				else {
					return 0; //비밀번호 불일치
				}
			}
			return -1; //아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //db오류
	}
	
	public int join(MemberVO memberVO) {
		String SQL = "insert into member values (?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, memberVO.getId());
			pstmt.setString(2, memberVO.getPw());
			pstmt.setString(3, memberVO.getName());
			pstmt.setString(4, memberVO.getEmail());
			pstmt.setString(5, memberVO.getPhone());
			pstmt.setString(6, memberVO.getSex());
			return pstmt.executeUpdate(); 
			//insert문 같은경우 성공이면 반드시 1이상의 숫자가 발생된다.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}
