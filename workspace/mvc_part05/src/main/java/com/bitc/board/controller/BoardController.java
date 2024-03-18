package com.bitc.board.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.board.service.BoardService;
import com.bitc.board.vo.BoardVO;
import com.bitc.common.util.SearchCriteria;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("board/*")
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService bs;
	
	/**
	 * TODO board search BoardController check
	 * @since 2024-03-13
	 * @param 검색 기능 추가를 위해 SearchCriteria 객체 매개변수 추가
	 */
	@GetMapping("listReply")
	public String listReply(
				// ModelAttribute를 추가하지 않으면 
				// SearchCriteria가 Model에 자동으로 등록되긴하나
				// key name 이 searchCriteria로 등록됨. - 사용하고자 하는 이름으로 등록
				@ModelAttribute(name = "cri") SearchCriteria cri,
				Model model) throws Exception {
		// 2024-03-13 전체 게시글 검색 제거
		// List<BoardVO> list = bs.list();
		// model.addAttribute("qnaList",list);
		
		// 2024-03-13 페이징 처리된 검색 게시글 목록과 페이징 블럭 정보를 
		// map형태로 model에 한번에 추가
		Map<String, Object> listMap = bs.listCriteria(cri);
		model.addAllAttributes(listMap);
		return "board/listReply";
	}
	
	// 게시글 등록 화면 요청
	@GetMapping("register")
	public String register() {
		return "board/register";
	}
	
	// 게시글 등록 처리 요청
	@PostMapping("register")
	public String register(BoardVO board) throws Exception{
		bs.regist(board);
		return "redirect:/board/listReply";
	}
	
	// 게시글 상세보기 페이지 요청
	// /board/readPage - 조회수만 증가
	@GetMapping("readPage")
	public String readPage(int bno, RedirectAttributes rttr) throws Exception{
		// 조회수 증가
		bs.updateViewCnt(bno);
		// redirect된 페이지에 get 방식의 QueryString parameter 지정
		rttr.addAttribute("bno", bno);
		return "redirect:/board/read";
		// return "redirect:/board/read?bno="+bno;
	}
	
	// /board/read - 출력할 view페이지와 출력할 게시글 정보
	@GetMapping("read")
	public String read(int bno,Model model)throws Exception{
		// view 페이지에서 상세보기로 출력할 게시글 정보
		BoardVO board = bs.readBoard(bno);
		model.addAttribute("board",board);
		return "board/readPage";
	}
	
	// /board/replyRegister
	// 답변글 작성 페이지 요청
	@GetMapping("replyRegister")
	public String replyRegister(int bno, Model model) throws Exception{
		// bno : 답변을 달려는 원본 게시글 번호
		BoardVO origin = bs.readBoard(bno);
		model.addAttribute("origin",origin);
		return "board/replyRegister";
	}
	
	// 답변글 등록 요청 처리
	// board/replyRegister - POST
	@PostMapping("replyRegister")
	public String replyRegister(BoardVO reply)throws Exception{
		// 답변글 등록
		bs.replyRegister(reply);
		// 답변글 등록 완료 시 게시글 목록 페이지로 이동
		return "redirect:/board/listReply";
	}
	
	
	// 게시글 수정 페이지 요청
	// board/modify
	@GetMapping("modify")
	public String modify(int bno, Model model) throws Exception{
		model.addAttribute("board",bs.readBoard(bno));
		return "board/modifyPage";
	}
	
	// 게시글 수정 등록 요청 처리
	// board/modify - POST
	@PostMapping("modify")
	public String modify(BoardVO board,RedirectAttributes rttr)throws Exception{
		// 게시글 수정 처리
		bs.modify(board);
		// 수정된 게시글 번호로 상세보기 페이지 이동
		rttr.addAttribute("bno",board.getBno());
		return "redirect:/board/read";
	}
	
	// 게시글 삭제 요청
	// board/remove
	@PostMapping("remove")
	public String remove(int bno)throws Exception{
		// 게시글 삭제 처리
		bs.remove(bno);
		return "redirect:/board/listReply";
	}

}
















