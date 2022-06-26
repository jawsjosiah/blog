package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Board;
import vo.Guestbook;

public class BoardDao {
	public BoardDao() {
		
	}
	
	public void insertBoard(Board board) throws Exception {
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		// 마리아 드라이버를 로딩한다. 
		System.out.println("드라이버 로딩 성공");
		*/
		
		Connection conn = null;
		// 데이터베이스와 연결할 객체를 선언한다. 
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "mariadb1234";
		// 데이터베이스 정보를 저장한다. 
		
		/*
		 * conn = DriverManager.getConnection(dburl, dbuser, dbpw); // 데이터베이스와 연결한다.
		 * System.out.println(conn+" <-- conn");
		 */
		
		/*
			INSERT INTO board(
					category_name,
					board_title,
					board_content,
					board_pw,
					create_date,
					update_date
			) VALUES (
				?, ?, ?, ?, NOW(), NOW()		
			)
		*/
		conn = DBUtil.getConnection();
		String sql = "INSERT INTO board(category_name, board_title, board_content, board_pw, create_date, update_date) VALUES (?, ?, ?, ?, NOW(), NOW())";
		// 문자열 변수 sql에 board테이블에 값을 삽입하는 쿼리를 저장한다. 
		PreparedStatement stmt = conn.prepareStatement(sql);
		// 쿼리를 저장한다. 
		
		stmt.setString(1, board.getCategoryName());
		stmt.setString(2, board.getBoardTitle());
		stmt.setString(3, board.getBoardContent());
		stmt.setString(4, board.getBoardPw());
		// stmt에서 ? 표현식 값에 들어갈 자리와 들어갈 값들을 기술한다. 
		
		int row = stmt.executeUpdate(); 
		// 몇행을 입력했는지 return 
				
		if(row == 1) {
			System.out.println(row+"행 입력 성공");
		} else {
			System.out.println("입력 실패");
		} // 디버깅 
		
		conn.close();
		// DB와 연결을 종료한다.
	}
	
	public ArrayList<String> selectCategoryName() throws Exception {
		/*
		 * Class.forName("org.mariadb.jdbc.Driver"); // (0) 마리아 드라이버 로딩 과정이다.
		 * System.out.println("드라이버 로딩 성공"); // 디버깅 코드
		 */		
		Connection conn = null;
		// DB와 연결할 객체 선언 
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		// 연결할 데이버베이스의 IP주소를 문자열 변수에 저장
		String dbuser = "root";
		// 연결할 데이버베이스의 아이디를 문자열 변수에 저장
		String dbpw = "mariadb1234";
		// 연결할 데이버베이스의 패스워드를 문자열 변수에 저장 
		
		/*
		 * conn = DriverManager.getConnection(dburl, dbuser, dbpw); // (1) 접속 정보를 가지고서
		 * DB에 연결한다. System.out.println(conn + "<-- conn"); // 디버깅 코드
		 */	
		conn = DBUtil.getConnection();
		String sql = "select category_name categoryName FROM category ORDER BY category_name ASC";
		// catagory_name을 가져오는 쿼리문을 문자열 변수 sql에 저장한다. 
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		// (2) 변수 sql에 저장했던 쿼리를 stmt에 저장한다. 
		
		ResultSet rs = stmt.executeQuery();
		// (3) 쿼리를 실행 후 테이블 모양 변수에 저장한다. 
		
		ArrayList<String> list = new ArrayList<String>();
		// 동적인 배열 ArrayList를 선언한다. 
		
		while(rs.next()) {
		// 한줄씩 읽는다. 값이 있으면 true 아니면 false 
			list.add(rs.getString("categoryName"));
			// 선언한 동적 배열 list에 categoryName 컬럼의 값들을 가져온다. 
		}
		rs.close();
		stmt.close();
		conn.close();
		// 연결 종료 
		return list;
	}
	
	public int deleteBoard(int boardNo, String boardPw) throws Exception {
		Board board = null;
		
		/* Class.forName("org.mariadb.jdbc.Driver"); */
		
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "mariadb1234";
		/* conn = DriverManager.getConnection(dburl, dbuser, dbpw); */
		
		conn = DBUtil.getConnection();
		
		PreparedStatement stmt = conn.prepareStatement("delete from board where board_no=? and board_pw=?");
		stmt.setInt(1, boardNo);
		stmt.setString(2, boardPw);
		// 여기서 예외 발생했는지? board.boardNo 형태로 저장했었다.
		int row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row; 
		
		
		// 데이터베이스와 연결을 종료한다. 
	}
	
	public int updateBoard(Board board) throws Exception {
	// 예외 처리 이유는? 
	/*
	 * Class.forName("org.mariadb.jdbc.Driver"); // 마리아 DB 드라이버 로딩
	 * System.out.println("드라이브 로딩 완료"); // 디버깅 코드
	 */		
		Connection conn = null;
		// DB와 연결할 객체 선언 
		String dburl = "jdbc:mariadb://localhost:3306/blog"; 
		// 주소 저장
		String dbuser = "root"; 
		// 아이디 저장
		String dbpw = "mariadb1234"; 
		// 비번 저장
		/*
		 * conn = DriverManager.getConnection(dburl,dbuser,dbpw); // 마리아 DB와 연결
		 * System.out.println(conn+"<--conn"); // 디버깅
		 */		
		
		conn = DBUtil.getConnection();
		
		String boardOneSql = "update board set category_name=?,board_title=?,board_content=?,update_date=now() where board_no=? and board_pw=?";
		// 문자열 변수에 실행하려는 쿼리문 작성 
		PreparedStatement stmt = conn.prepareStatement(boardOneSql);
		// 쿼리문을 stmt 변수에 저장 
		stmt.setString(1, board.getCategoryName());
		stmt.setString(2, board.getBoardTitle());
		stmt.setString(3, board.getBoardContent());
		stmt.setInt(4, board.getBoardNo());
		stmt.setString(5, board.getBoardPw());
		// 수정할 학생 정보를 받아 쿼리 수정 
		System.out.println("쿼리 수정 완료");
		// 디버깅 코드 
		System.out.println("쿼리 저장 완료");
		// 디버깅 코드 
		
		int row = stmt.executeUpdate();
		// 업데이트 실행
		
		conn.close();
		// DB 연결 해제 
		
		return row;
	}
	
	public Board selectBoardOne(int boardNo) throws Exception {
		Board board = null;
		// vo 패키지 밑에 만든 Board 초기화 
		/* Class.forName("org.mariadb.jdbc.Driver"); */
		Connection conn = null;
		PreparedStatement stmt = null;
		
		// ResultSet rs = null;

		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "mariadb1234";
		/* conn = DriverManager.getConnection(dburl, dbuser, dbpw); */

		conn = DBUtil.getConnection();
		String boardOneSql = "select board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, board_pw boardPw, create_date createDate, update_date updateDate from board WHERE board_no = ?";
		// String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent FROM guestbook WHERE guestbook_no = ?";
		// board_no를 기준으로 board테이블의 전체 컬럼을 가져오는 쿼리문을 문자열 변수 boardOneSql에 저장한다. 
		stmt = conn.prepareStatement(boardOneSql);
		// 쿼리문 저장 
		stmt.setInt(1, boardNo);
		// 요청받아온 boardNo값 넣기
		System.out.println(stmt + " <-- sql selectGuestbookOne");
		
		ResultSet boardOneRs = stmt.executeQuery();
		// boardOneRs boardSql 쿼리로 들고온 값을 실행해서 테이블 형태인 ResultSet에 넣는다. 
		System.out.println(boardOneRs + "<--boardOneRs"); 
		// 디버깅
		if (boardOneRs.next()) {
		// true값일때만 커서 옮기면서
			board = new Board();  // 생성자메서드
			// board 객체 새롭게 생성 
			board.setBoardNo(boardOneRs.getInt("boardNo"));
			board.setCategoryName(boardOneRs.getString("categoryName"));
			board.setBoardTitle(boardOneRs.getString("boardTitle"));
			board.setBoardContent(boardOneRs.getString("boardContent"));
			board.setCreateDate(boardOneRs.getString("createDate"));
			board.setUpdateDate(boardOneRs.getString("updateDate"));
			// 받아온 값들을 board 객체에 저장한다. 
		}
		// rs.close();
		// stmt.close();
		// conn.close();
		return board;
	}
	
	public Board selectBoardOne2(int boardNo) throws Exception {
		Board board = null;
		
		/*
		 * Class.forName("org.mariadb.jdbc.Driver"); // 마리아 DB 드라이버 로딩
		 * System.out.println("드라이버 로딩 성공(boardList.jsp)"); // 디버깅 코드
		 */		
		Connection conn = null;
		// DB와 연결하는 객체 선언 
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		// 연결하려는 DB의 IP 주소를 문자열 변수에 저장 
		String dbuser = "root";
		// 연결하려는 DB의 아이디를 문자열 변수에 저장 
		String dbpw = "mariadb1234";
		// 연결하려는 DB의 패스워드를 문자열 변수에 저장 
		/*
		 * conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB에 연결
		 * System.out.println(conn + " <-- conn(boardList.jsp)"); // 디버깅 코드
		 */		
		
		conn = DBUtil.getConnection();
		
		String boardOneSql = "select board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, board_pw boardPw, create_date createDate, update_date updateDate from board where board_no=? order by create_date desc limit 0,10";
		// 문자열 변수 boardSql에 board테이블 전체 컬럼중 pw제외하고 출력한다. 이 떄 board_no값을 비교해보고 가져온다.
		
		PreparedStatement boardStmt = conn.prepareStatement(boardOneSql);
		// (2) 쿼리를 저장한다. 
		System.out.println(boardStmt + " <-- boardStmt");
		// 디버깅 코드 
		
		boardStmt.setInt(1, boardNo);
		// boardStmt의 쿼리문중 board_no=?에 해당하는 값을 boardNo값으로 넣는다. 
				
		ResultSet boardOneRs = boardStmt.executeQuery();
		// (3) 쿼리를 실행한 결과를 테이블 형태의 변수에 저장한다. 
		
		// vo의 Board 객체를 새로 만들고 null로 초기화한다. 
		if(boardOneRs.next()) {
		// 쿼리 결과가 담긴 테이블 boardRs를 한줄씩 읽는다. 
			board  = new Board();
			// 새로운 board 객체 생성 
			board.setBoardNo(boardOneRs.getInt("boardNo"));
			board.setCategoryName(boardOneRs.getString("categoryName"));
			board.setBoardTitle(boardOneRs.getString("boardTitle"));
			board.setBoardContent(boardOneRs.getString("boardContent"));
			board.setCreateDate(boardOneRs.getString("createDate"));
			board.setUpdateDate(boardOneRs.getString("updateDate"));
			// 쿼리에서 받아온 값을  board에 담긴 변수들에 저장한다. 
		}
		
		conn.close();
		// 연결 종료 
		return board;
	}
	
	public ArrayList<HashMap<String, Object>> selectCategoryCount() throws Exception {
		/*
		 * Class.forName("org.mariadb.jdbc.Driver"); // 마리아 DB 드라이버 로딩
		 * System.out.println("드라이버 로딩 성공 <-- BoardDao.selectCategoryCount() "); // 디버깅
		 * 코드
		 */		
		Connection conn = null;
		// DB와 연결하는 객체 선언 
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		// 연결하려는 DB의 IP 주소를 문자열 변수에 저장 
		String dbuser = "root";
		// 연결하려는 DB의 아이디를 문자열 변수에 저장 
		String dbpw = "mariadb1234";
		// 연결하려는 DB의 패스워드를 문자열 변수에 저장 
		/*
		 * conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB에 연결
		 * System.out.println(conn + " <-- conn(boardList.jsp)"); // 디버깅 코드
		 */		
		conn = DBUtil.getConnection();
		/*
			SELECT category_name categoryName, COUNT(*) cnt
			FROM board
			GROUP BY category_name
		*/
		
		String categorySql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
		// 카테고리 이름과 총합을 board테이블에서 가져오는데 카테고리 이름으로 묶어서 가져온다. 
		PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
		// 쿼리를 실행하기 위해 쿼리를 적절한 타입에 저장한다. 
		ResultSet categoryRs = categoryStmt.executeQuery();
		// 쿼리를 실행한다. 실행한 결과는 테이블 형태의 변수에 저장한다. 
		
		// 쿼리 결과를 Category, Board VO로 저장할 수 없다. -> HashMap을 사용해서 저장하자!
		ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
		// ... 
		while(categoryRs.next()) {
		// 테이블 형태의 변수를 한줄씩 읽는다. 값이 있으면 반복문 게속 진행한다. 
			HashMap<String, Object> map = new HashMap<String, Object>();
			// ... 
			map.put("categoryName", categoryRs.getString("categoryName"));
			map.put("cnt", categoryRs.getInt("cnt"));
			categoryList.add(map);
		}
		
		conn.close();
		
		return categoryList;
	}
	
	public ArrayList<Board> selectBoardList(int rowPerPage, int beginRow, String categoryName) throws Exception {
		
		/*
		 * Class.forName("org.mariadb.jdbc.Driver");
		 * System.out.println("드라이버 로딩 성공 <-- BoardDao.selectBoardList() ");
		 */
		
		Connection conn = null;
		// DB와 연결하는 인스턴스 선언 
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		// 연결하려는 DB의 IP 주소를 문자열 변수에 저장 
		String dbuser = "root";
		// 연결하려는 DB의 아이디를 문자열 변수에 저장 
		String dbpw = "mariadb1234";
		// 연결하려는 DB의 패스워드를 문자열 변수에 저장 
		/*
		 * conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB에 연결
		 * System.out.println(conn + " <-- conn // BoardDao.selectBoardList() "); // 디버깅
		 * 코드
		 */		
		conn = DBUtil.getConnection();
		// boardList
		String boardSql = null;
		// 쿼리를 저장할 문자열 변수 선언 후 null로 초기화 
		PreparedStatement boardStmt = null;
		// 쿼리를 저장할 문자열 변수 선언 후 null로 초기화 
		if(categoryName.equals("")) { 
		// categoryName이 null값인 경우 
			boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
			// 생성일 컬럼을 기준으로 오름차순 정렬 
			boardStmt = conn.prepareStatement(boardSql);
			// 불러온 쿼리문 저장 
			boardStmt.setInt(1, beginRow);
			boardStmt.setInt(2, rowPerPage);
		} else {
		// categoryName이 null 아닌 경우 
			boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT ?, ?";
			// categoryName의 값에 해당하는 쿼리문 불러오기 
			boardStmt = conn.prepareStatement(boardSql);
			// 불러온 쿼리문 저장 
			boardStmt.setString(1, categoryName);
			// ?에 들어가는 값 대입 
			boardStmt.setInt(2, beginRow);
			boardStmt.setInt(3, rowPerPage);
		}
		ResultSet boardRs = boardStmt.executeQuery();
		// 실행한 쿼리를 테이블 형태 변수에 저장 
		ArrayList<Board> boardList = new ArrayList<Board>();
		// vo 동적 배열 생성 
		while(boardRs.next()) {
		// 한줄씩 읽는다 
			Board b = new Board();
			b.setBoardNo(boardRs.getInt("boardNo"));
			b.setCategoryName(boardRs.getString("categoryName"));
			b.setBoardTitle(boardRs.getString("boardTitle"));
			b.setCreateDate(boardRs.getString("createDate"));
			// 쿼리에서 읽어온 값을 vo 객체가 가진 변수에 저장 
			boardList.add(b);
		}
		conn.close();
		
		return boardList;
		
	}
	
	public int selectTotalRow() throws Exception {
		int totalRow = 0; 
		
		/*
		 * Class.forName("org.mariadb.jdbc.Driver"); // 마리아 DB 드라이버 로딩
		 * System.out.println("드라이버 로딩 성공 <-- BoardDao.selectTotalRow() "); // 디버깅 코드
		 */		
		Connection conn = null;
		// DB와 연결하는 객체 선언 
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		// 연결하려는 DB의 IP 주소를 문자열 변수에 저장 
		String dbuser = "root";
		// 연결하려는 DB의 아이디를 문자열 변수에 저장 
		String dbpw = "mariadb1234";
		// 연결하려는 DB의 패스워드를 문자열 변수에 저장 
		/*
		 * conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB에 연결
		 * System.out.println(conn + " <-- conn // BoardDao.selectTotalRow() "); // 디버깅
		 * 코드
		 */		
		
		conn = DBUtil.getConnection();
		
		String totalRowSql = "select count(*) cnt from board";
		PreparedStatement totalRowStmt = conn.prepareStatement(totalRowSql); 
		ResultSet totalRowRs = totalRowStmt.executeQuery();
		if(totalRowRs.next()) {
			totalRow = totalRowRs.getInt("cnt");
			System.out.println(totalRow+" <-- totalRow(1000)");
		}
		
		conn.close(); 
		
		return totalRow;
		
	}
}
