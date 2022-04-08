package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.Guestbook;
import vo.Photo;

public class PhotoDao {
	
	// 이미지 이름을 반환하는 메서드 
	public String selectPhotoName(int photoNo) throws Exception {
		
		String photoName = "";
		// select photo_name from photo where photo_no = ? 
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		
		String sql = "select photo_name photoName from photo where photo_no = ? ";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		
		rs = stmt.executeQuery();
		while(rs.next()) {
			
			photoName = rs.getString("photoName");
			
		}
		
		return photoName; 
	}
	
	public void insertPhoto(Photo photo) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		
		String sql = "insert into photo(photo_name, photo_original_name, photo_type, photo_pw, writer, create_date, update_date) values (?,?,?,?,?,now(),now())";
	
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, photo.photoName);
		// 이 부분 제대로 구현한것일까? 
		stmt.setString(2, photo.photoOriginalName);
		stmt.setString(3, photo.photoType);
		stmt.setString(4, photo.photoPw);
		stmt.setString(5, photo.writer);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("입력 성공");
		} else {
			System.out.println("입력 실패");
		}
		stmt.close();
		conn.close();
	}
	
	public int deletePhoto(int photoNo, String photoPw) throws Exception { // 입력 photoNo, photoPw
		int row = 0;
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;

		String dburl = "jdbc:mariadb://localhost:3307/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);

		String sql = "DELETE FROM photo WHERE photo_no=? AND photo_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		stmt.setString(2, photoPw);
		System.out.println(stmt + " <-- sql deletePhoto");
		row = stmt.executeUpdate();

		stmt.close();
		conn.close();
		
		return row;
		
	}
	
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Photo> list = new ArrayList<Photo>();
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3307/blog","root","java1234");
		String sql = "SELECT photo_no photoNo, photo_name photoName FROM photo ORDER BY create_date DESC LIMIT ?,?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Photo p = new Photo();
			p.photoNo = rs.getInt("photoNo");
			p.photoName = rs.getString("photoName");
			list.add(p);
		}
		return list;
	}
    // 다른메서드

	
	// 이미지 하나 상세보기 
	public Photo selectPhotoOne(int photoNo) throws Exception {
		Photo photo = null; 
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String dburl = "jdbc:mariadb://localhost:3307/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "select photo_no photoNo, photo_name photoName FROM photo WHERE photo_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		System.out.println(stmt + " <-- sql selectPhotoOne");
		
		rs = stmt.executeQuery();
		if (rs.next()) {
			photo = new Photo(); // 생성자메서드
			photo.photoNo = rs.getInt("photoNo");
			photo.photoName = rs.getString("photoName");
		}
		 rs.close();
		 stmt.close();
		 conn.close();
		
		return photo;
	}
	
	// 전체 행의 수 
	public int selectPhotoTotalRow() throws Exception {
		int total = 0;
		
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String dburl = "jdbc:mariadb://localhost:3307/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		
		String sql = "SELECT COUNT(*) cnt FROM photo";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if (rs.next()) {
			total = rs.getInt("cnt");
		}
		return total;
	}
	
	// 수정은 삭제 후 새로 입력 
}
