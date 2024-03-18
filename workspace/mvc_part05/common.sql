-- common.sql
-- 검색가능한 답변형 게시판

/*
 * TINYTEXT - 최대 255 byte
 * TEXT - 최대 65535 바이트 (대략 64KB) - 3BYTE - 21844 글자 저장 가능.
 * MEDIUMTEXT - 16777215 byte(16MB)
 * LONGTEXT - 4294967295 byte(대략 4GB)
 * 
 */
CREATE TABLE re_tbl_board(
	bno INT PRIMARY KEY auto_increment,				-- 게시글 번호
	title VARCHAR(300) NOT NULL,					-- 게시글 제목
	content TEXT NOT NULL,							-- 게시글 내용
	writer VARCHAR(50) NOT NULL,					-- 작성자 이름 - 표시용
	origin INT NULL DEFAULT 0,						-- 원본글 그룹 번호
	depth INT NULL DEFAULT 0,						-- view 출력용
	seq INT NULL DEFAULT 0, 						-- 그룹 정렬 번호
	regdate TIMESTAMP NULL DEFAULT now(),			-- 게시글 작성 시간
	updatedate TIMESTAMP NULL DEFAULT now(),		-- 게시글 수정 시간	
	viewcnt INT NULL DEFAULT 0,						-- 조회수
	showboard VARCHAR(10) NULL DEFAULT 'y',			-- 삭제 요청 여부
	uno INT NOT NULL,								-- 게시글 작성자 회원 번호
	CONSTRAINT fk_re_tbl_uno 
	FOREIGN KEY(uno) REFERENCES tbl_user(uno),
	INDEX(origin)
);

ALTER TABLE re_tbl_board MODIFY content MEDIUMTEXT NOT NULL;

SELECT * FROM re_tbl_board;

-- 첨부파일 저장 table
CREATE TABLE tbl_attach(
	fullName VARCHAR(300) NOT NULL,			-- 첨부파일 이름
	bno INT NOT NULL,						-- 게시글 번호
	regdate TIMESTAMP NULL DEFAULT now(),	-- 등록 시간
	CONSTRAINT fk_tbl_attach FOREIGN KEY(bno)
	REFERENCES re_tbl_board(bno)
);

SELECT * FROM tbl_attach;

-- 2024-03-13 검색 Query 테스트
SELECT bno, title, writer, regdate, showboard, viewcnt
FROM re_tbl_board
WHERE (title LIKE CONCAT('%','THOR','%')) 
OR (content LIKE CONCAT('%','THOR','%')) 
OR (writer LIKE CONCAT('%','THOR','%'))
ORDER BY origin DESC, seq ASC LIMIT 0, 10;

SELECT count(*) FROM re_tbl_board
WHERE (title LIKE CONCAT('%','THOR','%')) 
OR (content LIKE CONCAT('%','THOR','%')) 
OR (writer LIKE CONCAT('%','THOR','%'));

commit;

-- 2024-03-13 re_tbl_board 댓글 테이블 추가
CREATE TABLE IF NOT EXISTS re_tbl_comment(
	cno INT PRIMARY KEY auto_increment, 			-- 댓글 번호
	bno INT NOT NULL,								-- 댓글 작성 게시글 번호
	commentText TEXT NOT NULL,						-- 댓글 내용
	commentAuth VARCHAR(300) NOT NULL,				-- 작성자
	regdate TIMESTAMP NOT NULL DEFAULT now(),		-- 작성시간
	updatedate TIMESTAMP NOT NULL DEFAULT now(), 	-- 수정시간
	CONSTRAINT fk_re_tbl_bno FOREIGN KEY(bno)       -- 외래키 지정
	REFERENCES re_tbl_board(bno) ON DELETE CASCADE, -- 게시글 삭제 시 참조하는 댓글도 삭제
	INDEX(bno)										-- bno column 인덱스 지정
);














