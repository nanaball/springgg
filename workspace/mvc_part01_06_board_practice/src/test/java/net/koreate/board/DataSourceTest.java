package net.koreate.board;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bitc.board.vo.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(

	locations = {"classpath:spring/root-context.xml"}
	
)

public class DataSourceTest {

	@Autowired
	DataSource ds;
	
	@Autowired
	SqlSessionFactory sql;
	

	// db 연결
	@Test
	public void connectionPoolTest() throws Exception{
		Connection conn = ds.getConnection();
		System.out.println("test connection : " + conn);
		conn.close();
	}
	
	// 
	
	
}
