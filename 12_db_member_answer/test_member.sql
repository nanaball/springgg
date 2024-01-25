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
(null,'id053','pw033','이기근','부산광역시','01011111111','남성',30),
(null,'id054','pw034','공기근','부산광역시','01011111111','남성',30),
(null,'id055','pw035','박기근','부산광역시','01011111111','남성',30),
(null,'id056','pw036','조기근','부산광역시','01011111111','남성',30),
(null,'id057','pw037','엄기근','부산광역시','01011111111','남성',30),
(null,'id058','pw038','조기근','부산광역시','01011111111','남성',30),
(null,'id059','pw039','최기근','부산광역시','01011111111','남성',30),
(null,'id050','pw030','김기근','부산광역시','01011111111','남성',30),
(null,'id031','pw031','송기근','부산광역시','01011111111','남성',30),
(null,'id032','pw032','엄기근','부산광역시','01011111111','남성',30);

SELECT count(*) from test_member;