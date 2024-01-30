-- num(int) / id / pass / name / addr / phone / gender / age(int)
CREATE TABLE test_member(
	num INT PRIMARY KEY auto_increment,
	id VARCHAR(30) UNIQUE NOT NULL,
	pass VARCHAR(30) NOT NULL,
	name VARCHAR(50),
	addr TEXT,
	phone VARCHAR(20),
	gender VARCHAR(10),
	age int(3)
);

-- 관리자 계정 추가 - id : admin , pass - admin , name - MASTER
INSERT INTO test_member 
VALUES(null,'admin','admin','MASTER',
	   '부산광역시','01011111111','남성',30);
	   
SELECT * FROM test_member;

commit;

INSERT INTO test_member 
VALUES
(null,'id880','pw0','일기근','부산','01011111111','남성',30),
(null,'id881','pw1','이기근','서울','01011111111','남성',30),
(null,'id882','pw2','삼기근','광주','01011111111','남성',30),
(null,'id883','pw3','사기근','울산','01011111111','남성',30),
(null,'id884','pw4','오기근','대전','01011111111','남성',30),
(null,'id885','pw5','육기근','대구','01011111111','남성',30),
(null,'id886','pw6','칠기근','경기','01011111111','남성',30),
(null,'id887','pw7','팔기근','인천','01011111111','남성',30),
(null,'id888','pw8','구기근','제주','01011111111','남성',30),
(null,'id889','pw9','십기근','강원','01011111111','남성',30);

SELECT count(*) from test_member;

-- 모든 최 검색
SELECT * FROM test_member WHERE name like = '%최%';

-- 앞에 한글자 있고 두번째 최 뒤는 상관 ㄴㄴ
SELECT * FROM test_member WHERE name like = '_최%';

-- 파라미터로 전달된 모든 최
SELECT * FROM test_member WHERE name like CONCAT( '%','','%');




-- 공지형 게시판 
CREATE TABLE IF NOT EXISTS notice_board(
	notice_num INT PRIMARY KEY AUTO_INCREMENT,		-- 공지 글 번호
	notice_category VARCHAR(20) NOT NULL,			-- 공지 분류
	notice_author VARCHAR(50) NOT NULL,				-- 작성자
	notice_title VARCHAR(200) NOT NULL,				-- 제목
	notice_content TEXT NOT NULL,					-- 내용
	notice_date TIMESTAMP NOT NULL DEFAULT now()	-- 작성 시간
);
	
SELECT * FROM notice_board;


-- 질문과 답변 - 자유게시판 table
CREATE TABLE IF NOT EXISTS qna_board(
	qna_num INT PRIMARY KEY AUTO_INCREMENT, 	-- 글번호
	qna_name VARCHAR(20) NOT NULL,				-- 작성자
	qna_title VARCHAR(200) NOT NULL,			-- 글 제목
	qna_content TEXT NOT NULL,					-- 글 내용
	qna_write_num INT NOT NULL,					-- 글 작성자 회원 번호 
	qna_readcount INT DEFAULT 0,				-- 조회수
	qna_date TIMESTAMP DEFAULT now()			-- 글 작성 시간
);

-- qna_write_num column -> qna_writer_num 으로 수정
ALTER TABLE qna_board change qna_write_num qna_writer_num int not null;

DESC qna_board;

-- 조회수 증가 
UPDATE qna_board SET qna_readcount = qna_readcount + 1 where qna_num = 1;

commit;


INSERT INTO qna_board (qna_name, qna_title, qna_content, qna_writer_num) 
select qna_name, qna_title, qna_content, qna_writer_num from qna_board;
-- where qna_num not in (1,2);

select * from qna_board order by qna_num desc;

-- 원본글(질문글)일 경우 자신의 게시글 번호를 저장
-- 답변 글일 경우 자신이 답변하는 원본글의 번호를 저장
-- 동일한 그룹 번호일경우 묶어서 출력
alter table qna_board add column qna_re_ref int not null default 0 after qna_content;


-- 기존에 등록된 행정보에 자기 글 번호로 qna_re_ref 컬럼 수정
update qna_board set qna_re_ref = qna_num;

select * from qna_board order by qna_re_ref desc;

insert into qna_board values(null, 'master', '855번의 답변글','업승ㅁ', 855,1,0,now());;

-- view 화면에서 출력될 답변 글의 깊이
ALTER TABLE qna_board ADD COLUMN qna_re_lev int not null default 0 after qna_re_ref;

-- 원본글과 답변글까지의 청렬 순서 기준
alter table qna_board ADD column qna_re_seq int not null  DEFAULT 0 AFTER qna_re_lev;

UPDATE qna_board SET 
qna_re_lev = qna_re_lev + 1,
qna_re_seq = qna_re_seq + 1 
WHERE qna_num = 1037;

SELECT * FROM qna_board ORDER BY qna_re_ref DESC, qna_re_seq ASC;

insert into qna_board(qna_name, qna_title, qna_content, qna_writer_num)
values('MASTER', '첫질문인데염','mysql이 뭔가요??','6');

select max(qna_num) from qna_board;

select LAST_INSERT_ID();

ROLLBACK;



-- qna_board 게시판의 게시물이 삭제 요청된 게시글인지 여부를 저장
ALTER TABLE qna_board add column qna_delete char(1) default 'N'
AFTER qna_date;

desc qna_board;

select qna_delete from qna_board;

-- qna_board.qna_writer_num 참조 무결성 - 외래키 추가
-- test_member.num

ALTER TABLE qna_board ADD CONSTRAINT fk_qna_writer 
FOREIGN KEY (qna_writer_num) REFERENCES test_member(num);