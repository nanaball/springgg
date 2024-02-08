package net.koreate.board;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bitc.board.dao.BoardDAO;
import com.bitc.board.vo.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(

	locations = {"classpath:spring/root-context.xml"}
)

public class BoardDAOTest {
	
	@Autowired
	@Qualifier("bd")
	BoardDAO bd;

	// 게시글 등록 
	// @Test
	public void createBoard(){
		
		BoardVO board = new BoardVO();
		board.setTitle("첫");
		board.setContent("게시물");
		board.setWriter("얏호");
		
		try {
			int result = bd.create(board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("createBoard result : " + board);	
	}
	
	// 게시글 번호로 글 보기 
	 @Test
	public void readBoard() throws Exception {
		BoardVO board = bd.read(4);
		System.out.println("readBoard : " + board);
	}
	
	// 게시글 수정하기
	@Test
	public void updateBoard() throws Exception {
		BoardVO board = new BoardVO();
		board.setBno(4);
		board.setTitle("추가");
		board.setContent("글쓰기ㅣㅣ");
		board.setWriter("확인");
		
		int result = bd.update(board);
		System.out.println("update result : " + result);
	}
	
	// 게시글 삭제하기
	// @Test
	public void deleteBoard() throws Exception {
		
		int result = bd.delete(3);		
		System.out.println("delete test : " + result);
	}
	
	// 게시글 목록 보기
	@Test
	public void readBoardList() throws Exception {
		List<BoardVO> boardList = bd.listAll();
		System.out.println("boardList test : " + boardList);
	}
	
	// 게시글 조회수 
	@Test
	public void updatecount() {
		
//		int result = bd.updateCnt(1);;
//		System.out.println("updateCount test : " + result);
	
		
	}
	
}
