show tables;

DESCRIBE tbl_board;

select * from tbl_board ORDER BY bno DESC;

-- 1번 게시글이 없을 시 sample data 추가
INSERT INTO tbl_board(bno,title,content,writer)
VALUES(1,'제목-test','내용-test','원빈');


-- tbl_board 게시물에 등록된 댓글을 저장할 테이블
CREATE TABLE IF NOT EXISTS tbl_comment(
	cno INT PRIMARY KEY AUTO_INCREMENT, 			-- 댓글 번호
	bno INT NOT NULL, 								-- 댓글이 작성된 게시글 번호 
	content TEXT NOT NULL,							-- 댓글 내용
	author VARCHAR(50) NOT NULL, 					-- 작성자
	regdate TIMESTAMP NOT NULL DEFAULT now(), 		-- 작성시간
	updatedate TIMESTAMP NOT NULL DEFAULT now(),	-- 수정시간
	CONSTRAINT fk_tbl_bno FOREIGN KEY(bno) REFERENCES tbl_board(bno),
	INDEX(bno)		-- 유니크키나 프라이머리키만 정렬이 되어있기에 bno도 정렬시킴 그러나 남발하면 안됨 (성능저하 일어날 수 있음)
);

-- 인덱스 정보 확인
SHOW INDEXES from tbl_comment;

-- 1번 게시글에 등록된 댓글 목록
SELECT * FROM tbl_comment WHERE bno = 1;

-- 제약 조건 정보 확인(중복으로 등록시 오류 발생)
SELECT * FROM information_schema.REFERENTIAL_CONSTRAINTS 
WHERE CONSTRAINT_SCHEMA = 'develop_spring' AND TABLE_NAME = 'tbl_comment';

-- 댓글 삽입 
INSERT INTO tbl_comment(bno, content, author)
VALUES(1, '1번 게시글의 댓글', '일기근');

INSERT INTO tbl_comment(bno, content, author)
VALUES(1, '1번 게시글의 2번째 댓글', '이기근');

INSERT INTO tbl_comment(bno, content, author)
VALUES(2, '2번 게시글의 댓글', '일기근');

INSERT INTO tbl_comment(bno, content, author)
VALUES(2, '2번 게시글의 2번째 댓글', '이기근');

SELECT * FROM tbl_comment where bno = 1;

-- 게시글만 삭제하려고 할때 제약조건 외래키로 남은 bno가 있어서 코멘트 먼저 삭제후 게시글 삭제 가능
-- DELETE FROM tbl_comment WHERE bno = 1;

DELETE FROM tbl_board WHERE bno = 15;

-- fk_tbl_bno 제약 조건 삭제
ALTER TABLE tbl_comment DROP CONSTRAINT fk_tbl_bno;

-- CASCADE가 추가된 외래키 제약 조건 추가
-- 보드에 있는 BNO 삭제시 COMMENT에 있는 BNO도 같이 삭제하도록함 
ALTER TABLE tbl_comment ADD CONSTRAINT fk_tbl_bno FOREIGN KEY(bno)
REFERENCES tbl_board(bno) ON DELETE CASCADE;


-- 최종 테이블 상태
-- tbl_board 게시물에 등록된 댓글을 저장할 테이블
CREATE TABLE IF NOT EXISTS tbl_comment(
	cno INT PRIMARY KEY AUTO_INCREMENT, 			-- 댓글 번호
	bno INT NOT NULL, 								-- 댓글이 작성된 게시글 번호 
	content TEXT NOT NULL,							-- 댓글 내용
	author VARCHAR(50) NOT NULL, 					-- 작성자
	regdate TIMESTAMP NOT NULL DEFAULT now(), 		-- 작성시간
	updatedate TIMESTAMP NOT NULL DEFAULT now(),	-- 수정시간
	CONSTRAINT fk_tbl_bno FOREIGN KEY(bno) REFERENCES tbl_board(bno) ON DELETE CASCADE,
	INDEX(bno)		-- 유니크키나 프라이머리키만 정렬이 되어있기에 bno도 정렬시킴 그러나 남발하면 안됨 (성능저하 일어날 수 있음)
);


SELECT * FROM tbl_comment 
WHERE bno = 2
ORDER BY cno DESC 		-- where이 없으면 전체 댓글에서 검색하기 떄문에 bno가 필요 
-- limit startRow, perPageNum;
limit 0, 10;