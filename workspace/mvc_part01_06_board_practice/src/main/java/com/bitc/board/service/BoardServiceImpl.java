package com.bitc.board.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bitc.board.dao.BoardDAO;
import com.bitc.board.util.Criteria;
import com.bitc.board.util.PageMaker;
import com.bitc.board.vo.BoardVO;

import lombok.RequiredArgsConstructor;

@Repository("bd")
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	@Qualifier("bd")
	BoardDAO bd;
	

	@Override
	public String regist(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateCnt(int bno) throws Exception {
		bd.updateCnt(bno);
		return bd.updateCnt(bno);
	}

	@Override
	public BoardVO read(int bno) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String modify(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String remove(int bno) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PageMaker getPageMaker(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
