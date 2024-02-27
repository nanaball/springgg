-- message.sql

CREATE TABLE tbl_user(
	uno INT PRIMARY KEY auto_increment,
	uid varchar(50) not null unique,
	upw varchar(50) not null,
	uname varchar(50) not null,
	upoint int not null default 0
);

DROP TABLE tbl_message;

-- message
CREATE TABLE tbl_message(
	mno int primary key auto_increment,			-- 메세지 번호
	targetid varchar(50) not null,				-- 수신자 아이디
	sender varchar(50) not null, 				-- 발신자 아이디
	message TEXT not null, 						-- 발신 메세지
	opendate TIMESTAMP NULL, 					-- 수신 확인 시간
	senddate TIMESTAMP NOT NULL DEFAULT now(),	-- 발신시간
	FOREIGN KEY(targetid) REFERENCES tbl_user(uid),
	FOREIGN KEY(sender) REFERENCES tbl_user(uid)
);

insert into tbl_user(uid, upw, uname)
values('id001', 'pw001','IRON MAN'),
	('id002', 'pw002','THOR'),
	('id003', 'pw003','DR.STRANGE');	
	
SELECT * FROM tbl_user;
SELECT * FROM tbl_message;


/*
 	-- 기본 회원목록
   1 id001 pw001 IRON MAN        0
   2 id002 pw002 THOR            0
   3 id003 pw003 DR.strange      0
 */

/*
 	-- 메세지 보내고 난 후 포인트 적용 
   1 id001 pw001 IRON MAN        0
   2 id002 pw002 THOR           10
   3 id003 pw003 DR.STRANGE      0
*/
/*
 	-- 미동록된 아이디로 메시지 보내도 포인트 적용 
   1 id001 pw001 IRON MAN       10
   2 id002 pw002 THOR           10
   3 id003 pw003 DR.STRANGE      0
*/
/*
 	-- 트랜잭션 적용 후 미등록된 아이디로 메시지 보낼시 rollback 
   1 id001 pw001 IRON MAN       10
   2 id002 pw002 THOR           10
   3 id003 pw003 DR.STRANGE      0
*/

