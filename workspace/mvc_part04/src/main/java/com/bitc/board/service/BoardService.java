package com.bitc.board.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitc.board.mapper.AttachmentMapper;
import com.bitc.board.mapper.BoardMapper;
import com.bitc.board.vo.BoardVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardService {

	private final BoardMapper mapper;
	private final AttachmentMapper attachMapper;
	
	/**
	 * 원본글 등록 처리
	 * @param vo - 원본글 정보
	 * @throws Exception
	 */
	@Transactional
	public void regist(BoardVO vo) throws Exception{
		
		// 원본글 등록
		mapper.register(vo);
		// 등록된 원본글 번호로 origin 컬럼 번호 수정
		mapper.updateOrigin();
		// 첨부된 파일 이름 리스트
		List<String> files = vo.getFiles();
		if(files != null && !files.isEmpty()) {
			for(String fullName : files) {
				attachMapper.addAttach(fullName);
			}
		}
	}

	/**
	 * 전체 원본글 목록
	 * @throws Exception 
	 */
	public List<BoardVO> list() throws Exception {		
		List<BoardVO> list = mapper.list();
		for(BoardVO vo : list) {
			vo.setFiles(attachMapper.getAttach(vo.getBno()));
		}
		return list;
	}

	/**
	 * 
	 * @param bno - 상세보기 할 게시글 번호 
	 * @return BoardVO - 게시글 번호와 일치하는 게시글 정보
	 */
	public BoardVO readBoard(int bno) throws Exception{
		BoardVO vo = mapper.readBoard(bno);
		// 첨부파일 목록 추가
		List<String> fileList = attachMapper.getAttach(bno);
		vo.setFiles(fileList);
		return vo;
	}

	/**
	 * @param bno - bno가 일치하는 게시글의 조회수를 1 증가
	 * 기존 조회수에서 1증가
	 */
	public void updateViewCnt(int bno) throws Exception{
		mapper.updateViewCnt(bno);
		
	}

	/**
	 * 답변글 등록
	 * @param reply
	 */
	public void replyRegister(BoardVO reply) throws Exception{
		// origin이 같은 그룹의 원본글보다 아래쪽에 배치된 답변글을 한칸 아래 쪽으로 배치 되도록 seq 값 수정
		mapper.updateReply(reply);
		
		// 원본글 한칸 아래
		reply.setSeq(reply.getSeq()+1);
		// 원본글에서 답글의 공백을 출력
		reply.setDepth(reply.getDepth()+1);
		
		// 답변글 등록
		mapper.replyRegister(reply);
	}

	/**
	 * 게시글 수정
	 * @param board
	 */
	public void modify(BoardVO board) throws Exception{
		// title, content, writer
		mapper.modify(board);
		
		// 수정할 게시글 기존에 등록되어있던 첨부파일 정보 전체 삭제 
		attachMapper.deleteAttach(board.getBno());
		// 변경된 첨부파일 목록 등록 
		List<String> fileList = board.getFiles();
		if(fileList != null && !fileList.isEmpty()) {
			for(String fullName : fileList) {
				attachMapper.replaceAttach(board.getBno(), fullName);
			}
		}
		
	}

	/**
	 * 게시글 삭제
	 * @param bno
	 */
	public void remove(int bno) throws Exception {
		
		// 첨부파일 db 삭제
		attachMapper.deleteAttach(bno);
		
		// re_tbl_board 게시글 정보 삭제
		mapper.remove(bno);
	}
}