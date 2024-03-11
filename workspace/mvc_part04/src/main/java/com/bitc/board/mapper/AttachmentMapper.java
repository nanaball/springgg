package com.bitc.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface AttachmentMapper {

	/**
	 * 첨부파일 등록
	 */
	@Insert("INSERT INTO tbl_attach(fullName, bno) "
			+ "VALUES(#{fullName}, LAST_INSERT_ID())")
	void addAttach(String fullName) throws Exception;

	/**
	 * 첨부파일 목록 검색
	 */
	@Select("SELECT fullName FROM tbl_attach WHERE bno = #{bno}")
	List<String> getAttach(int bno) throws Exception;

	/**
	 * 첨부파일 삭제
	 * @param bno - 게시글 번호가 일치하는 첨부파일 삭제
	 */
	@Delete("DELETE FROM tbl_attach WHERE bno = #{bno}")
	void deleteAttach(int bno) throws Exception;

	/**
	 * 수정페이지에서 첨부파일 삭제
	 * ++ mybatis는 파라미터를 하나만 전달 할 수 있음 그렇기 때문에 
	 * map 개체 생성해서 전달해야함 (int bno, String fullName)
	 * -> 어노테이션을 하나 만들어 주면 매개변수를  자동으로 변환해줌
	 * @param bno
	 * @param fullName
	 */
	@Insert("INSERT INTO tbl_attach(fullName, bno) "
			+ "VALUES(#{fullName} , #{bno})")
	void replaceAttach(@Param("bno") int bno, @Param("fullName")String fullName) throws Exception;
	
	
}
