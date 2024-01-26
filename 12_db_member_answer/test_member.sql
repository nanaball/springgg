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