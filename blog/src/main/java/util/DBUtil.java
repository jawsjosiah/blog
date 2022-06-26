package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			// 마리아 DB 드라이버 로딩 
			System.out.println("드라이버 로딩 성공 // DBUtil.java");
			// 디버깅 코드 
			
			// 아마존 AWS 서버에 사용되는 DB 주소 
			conn = DriverManager.getConnection("jdbc:mariadb://:3306/blog","root","mariadb1234");
			
			// 로컬 PC에 사용되는 DB 주소 
			// conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/blog","root","mariadb1234");
			
			// DB에 연결 
			System.out.println(conn + "// conn(DBUtil.java)");
			// 디버깅 코드 
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return conn; 
	}
}
