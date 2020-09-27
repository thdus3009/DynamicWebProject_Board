package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {
	private Connection conn;
	//private PreparedStatement pstmt;
	//db접근 마찰을 방지 하기위해 메서드 안쪽에 삽입한다.
	private ResultSet rs;
	
	public BoardDAO() {
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
	
	//현재 시간 가져오는 함수
	public String getDate() {
		String SQL="select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {//결과가 있는경우
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String SQL="select num from board order by num desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {//결과가 있는경우
				return rs.getInt(1)+1;
			}
			return 1; //첫번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //db 오류
	}
	
	public int write(String title, String id, String content) {
		String SQL = "insert into board values (?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, title);
			pstmt.setString(3, id);
			pstmt.setString(4, getDate());
			pstmt.setString(5, content);
			pstmt.setInt(6, 1);			
			
			return pstmt.executeUpdate(); //insert문에는 update를 사용한다.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<BoardVO> getList(int pageNumber){//페이지리스트 (pageNumber에 따라 출력되는 인덱스내용&갯수가 달라진다.)
		String SQL="select * from board where num<? and available=1 order by num desc limit 10";
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1) *10);
			
			//글이 5개일때 다음글(getNext)이 6번째라면, 6-(현재페이지(1)-1)*5 = 6, 즉 num<6이므로 1,2,3,4,5 (총5개)출력
			//글이 5개일때 다음글(getNext)이 7번째라면,7-(현재페이지(2)-1)*5 = 2, 즉 num<2 이므로 1개 출력 
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardVO boardVO = new BoardVO();
				boardVO.setNum(rs.getInt(1));
				boardVO.setTitle(rs.getString(2));
				boardVO.setId(rs.getString(3));
				boardVO.setDate(rs.getString(4));
				boardVO.setContent(rs.getString(5));
				boardVO.setAvailable(rs.getInt(6));
				list.add(boardVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) { //다음 페이지
		String SQL="select * from board where num<? and available=1";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1) *10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public BoardVO getBoardVO(int num) {
		String SQL="select * from board where num=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				BoardVO boardVO = new BoardVO();
				boardVO.setNum(rs.getInt(1));
				boardVO.setTitle(rs.getString(2));
				boardVO.setId(rs.getString(3));
				boardVO.setDate(rs.getString(4));
				boardVO.setContent(rs.getString(5));
				boardVO.setAvailable(rs.getInt(6));
				return boardVO;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
