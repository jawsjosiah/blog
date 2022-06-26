package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Pdf;
import vo.Photo;

public class PdfDao {
	
	public String selectPdfName(int pdfNo) throws Exception {
		
		String pdfName = "";
		// select pdf_name pdfName from pdf where pdf_no = ? 
		
		/* Class.forName("org.mariadb.jdbc.Driver"); */
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "mariadb1234";
		
		String sql ="select pdf_name pdfName from pdf where pdf_no = ? ";
				
		/* conn = DriverManager.getConnection(dburl, dbuser, dbpw); */
		
		conn = DBUtil.getConnection();
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, pdfNo);
		
		rs = stmt.executeQuery();
		while(rs.next()) {
			
			pdfName = rs.getString("pdfName");
			
		}
		
		return pdfName;
	}
	
	public void insertPdf(Pdf pdf) throws Exception {
		// Class.forName("org.mariadb.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "mariadb1234";
		
		String sql = "insert into pdf(pdf_name, pdf_original_name, pdf_type, pdf_pw, writer, create_date, update_date) values (?,?,?,?,?,now(),now())";
	
		// conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		conn = DBUtil.getConnection();
		
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, pdf.getPdfName());
		// 이 부분 제대로 구현한것일까? 
		stmt.setString(2, pdf.getPdfOriginalName());
		stmt.setString(3, pdf.getPdfType());
		stmt.setString(4, pdf.getPdfPw());
		stmt.setString(5, pdf.getWriter());
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("입력 성공");
		} else {
			System.out.println("입력 실패");
		}
		stmt.close();
		conn.close();
	}
	
	public int deletePdf(int pdfNo, String pdfPw) throws Exception { // 입력 photoNo, photoPw
		int row = 0;
		
		// Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;

		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "mariadb1234";
		// conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		conn = DBUtil.getConnection();

		String sql = "DELETE FROM pdf WHERE pdf_no=? AND pdf_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, pdfNo);
		stmt.setString(2, pdfPw);
		System.out.println(stmt + " <-- sql deletepdf");
		row = stmt.executeUpdate();

		stmt.close();
		conn.close();
		
		return row;
		
	}
	
	// 이미지 목록 
		public ArrayList<Pdf> selectPdfListByPage(int beginRow, int rowPerPage) throws Exception {
			ArrayList<Pdf> list = new ArrayList<Pdf>();
			// photo 10행씩 반환되도록 구현 예정 
			
			// Class.forName("org.mariadb.jdbc.Driver");
			
			// 데이터베이스 자원 준비
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "mariadb1234";
			
			String sql = "select pdf_no pdfNo, pdf_name pdfName, writer, create_date createDate FROM pdf ORDER BY create_date DESC LIMIT ?, ?";
			// conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			
			conn = DBUtil.getConnection();
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			// 데이터베이스 로직 끝
			
			// 데이터 변환(가공)
			while (rs.next()) {
				Pdf p = new Pdf();
				p.setPdfNo(rs.getInt("pdfNo"));
				p.setPdfName(rs.getString("pdfName"));
				p.setWriter(rs.getString("writer"));
				p.setCreateDate(rs.getString("createDate"));
				list.add(p);
			}
			
			// 데이터베이스 자원들 반환
			rs.close();
			stmt.close();
			conn.close();
			
			return list;
		}
		
		// 이미지 하나 상세보기 
		public Pdf selectPdfOne(int pdfNo) throws Exception {
			Pdf pdf = null; 
			
			// Class.forName("org.mariadb.jdbc.Driver");
			
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;

			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "mariadb1234";
			// conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			
			conn = DBUtil.getConnection();
			
			String sql = "select pdf_no pdfNo, pdf_name pdfName FROM pdf WHERE pdf_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, pdfNo);
			System.out.println(stmt + " <-- sql selectPdfOne");
			
			rs = stmt.executeQuery();
			if (rs.next()) {
				pdf = new Pdf(); // 생성자메서드
				pdf.setPdfNo(rs.getInt("pdfNo"));
				pdf.setPdfName(rs.getString("pdfName"));
			}
			 rs.close();
			 stmt.close();
			 conn.close();
			
			return pdf;
		}
		
		// 전체 행의 수 
		public int selectPdfTotalRow() throws Exception {
			int total = 0;
			
			// Class.forName("org.mariadb.jdbc.Driver");
			// 데이터베이스 자원 준비
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;

			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "mariadb1234";
			
			String sql = "SELECT COUNT(*) cnt FROM pdf";
			// conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			
			conn = DBUtil.getConnection();
			
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if (rs.next()) {
				total = rs.getInt("cnt");
			}
			return total;
		}
		
		// 수정은 삭제 후 새로 입력 
}
