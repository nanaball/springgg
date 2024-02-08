package com.bitc.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bitc.board.util.Criteria;
import com.bitc.board.vo.BoardVO;

import lombok.RequiredArgsConstructor;

@Repository("bd")
@RequiredArgsConstructor
public class BoardMyBatisDAOImpl implements BoardDAO {

	private final SqlSession session;
	
	@Override
	public int create(BoardVO vo) throws Exception {

		int result = session.insert("boardMapper.createBoard", vo);
		System.out.println("BoardDAO create result : " + result);
		
		return result;
	}

	@Override
	public BoardVO read(int bno) throws Exception {
		
		BoardVO board = session.selectOne("boardMapper.read", bno);
		System.out.println("BoardDAO read result : " + board);
		
		return board;
	}

	@Override
	public int update(BoardVO vo) throws Exception {
		
		int result = session.update("boardMapper.updateBoard", vo);
		
		return result;
	}

	@Override
	public int delete(int bno) throws Exception {
		
		int result = session.delete("boardMapper.deleteBoard", bno);
		return result;
	}

	@Override
	public void updateCnt(int bno) throws Exception {
		
		session.update("boardMapper.updateCnt", bno);
		
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		
		List<BoardVO> list = session.selectList("boardMapper.boardList");
		return list;
	}

	@Override
	public int totalCount() throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
