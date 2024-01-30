package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtil {
	
	// export -> jar -> web-inf -> lib 추가 
	
	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/develop_jsp",
				"developer",
				"12345"
			);
			System.out.println("Driver Class가 존재합ㄴㅣ다"+"///////////////");
			System.out.println("DB 연결 완료 : ");
			System.out.println(conn+"//////////////////////");
		} catch (ClassNotFoundException e) {
			System.out.println("Driver class를 찾을 수 없음");
		} catch (SQLException e) {
			System.out.println("연결 요청 정보 오류 : " + e.toString());
		}
		return conn;
	}
	
	// 자원 해제				외부에 있는 모든 데이터
	public static void close(AutoCloseable... closer) {
		for(AutoCloseable c : closer) {
			if(c != null) {
				try {
					c.close();
				} catch (Exception e) {}
			} 
		} 
	} 
}