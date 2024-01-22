use develop_jsp;

SHOW TABLES;
-- member_test.sql

create table if not EXISTS member(
		num INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(50),
        addr VARCHAR(300)
);

/*
		INSERT 	SELECT	UPDATE	DELETE
		CREATE	 READ	UPDATE	DELETE	
        CRUD 처리
*/

-- table에 값 삽입 - insert
-- num, name, addr
INSERT INTO member VALUES(null, '홍길동', '한양');
INSERT into member (name,addr) VALUES('최기근', '제주');


select * FROM MEMBER;