show tables;

create table board (
	idx int not null auto_increment,			/* 게시글의 고유번호 */
	mid varchar(20) not null,							/* 게시글 올린이 아이디 */
	nickName varchar(20) not null,				/* 게시글 올린이 닉네임 */
	title varchar(100) not null,					/* 게시글 제목 */
	content text not null,								/* 글 내용 */
	readNum int default 0,								/* 글 조회수 */
	hostIp varchar(40) not null,					/* 작성자 아이피 */
	openSw char(2) default 'OK',					/* 게시글 공개여부(OK: 공개, NO: 비공개) */
	wDate datetime default now(),					/* 작성 날짜 */
	good int default 0,										/* 좋아요 수(누적) */
	complaint char(2) default 'NO',				/* 신고 여부(신고당한 글: OK, 정상글: NO) */
	primary key(idx),											/* 기본키 : 고유번호 */
	foreign key(mid) references member(mid)
);
drop table board;
desc board;

insert into board values (default,'admin','관리맨','게시판 서비스를 시작합니다.','즐거운 게시판 생활 ... ',default,'192.168.50.58',default,default,default);

/* 댓글 연습하기 */
create table boardReply (
	idx int not null auto_increment,	/* 댓글 고유번호 */
	boardIdx int not null,						/* 원본글(부모글)의 고유번호-외래키로 지정ㄴ */
	mid varchar(20) not null,					/* 댓글 올린이의 아이디 */
	nickName varchar(20) not null,		/* 댓글 올린이의 닉네임 */
	wDate datetime default now(),			/* 댓글 올린 날짜, 시간 */
	hostIp varchar(50) not null,			/* 댓글 올린 PC의 고유 IP */
	content text not null,						/* 댓글 내용 */
	primary key(idx),
	foreign key(boardIdx) references board(idx)
	on update cascade
	on delete restrict
);
desc boardReply;

insert into boardReply values (default, 36,'admin','관리맨',default,'192.168.50.58','안녕하세요.');
insert into boardReply values (default, 33,'admin','관리맨',default,'192.168.50.58','안녕하세요.');
insert into boardReply values (default, 29,'hkd1234','홍장군',default,'192.168.50.58','다녀갑니다...');

select * from boardReply;

select * from board;
select * from board where idx = 11; /* 현재글 */
select idx,title from board where idx > 11 order by idx limit 1; /* 다음글 */
select idx,title from board where idx < 11 order by idx desc limit 1; /* 이전글 */

-- 시간으로 비교해서 필드에 값 저장하기
select *, timestampdiff(hour, wDate, now()) as hour_diff from board;

-- 날짜로 비교해서 필드에 값 저장하기
select *, datediff(wDate, now()) as date_diff from board;

-- 관리자는 모든글 보여주고, 일반사용자는 비공개글(openSw='NO')과 신고글(complaint='OK')은 볼수없다. 단, 자신이 작성한 글은 볼수 있다.
select count(*) as cnt from board;
select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO';
select count(*) as cnt from board where mid = 'hkd1234';
select * from board where openSW = 'OK' and complaint = 'NO';
select * from board where mid = 'hkd1234';
select * from board where openSW = 'OK' and complaint = 'NO' union select * from board where mid = 'hkd1234'; /* union : 동일한 건 하나만 */
select * from board where openSW = 'OK' and complaint = 'NO' union all select * from board where mid = 'hkd1234';		/* union all : 중복된 사항도 나옴 */

select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board where mid = 'hkd1234';
select sum(a.cnt) from (select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board where mid = 'hkd1234') as a;
select sum(a.cnt) from (select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board where mid = ?) as a;

select sum(a.cnt) from (select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board where mid = 'hkd1234' and (openSW = 'NO' or complaint = 'OK')) as a;


select * from board where openSW = 'OK' and complaint = 'NO' union select * from board where mid = 'hkd1234' order by idx desc;

/* 댓글 수 연습 */
select * from board order by idx desc;
select * from boardReply order by boardIdx, idx desc;

-- 부모글(39)의 댓글만 출력
select * from boardReply where boardIdx = 39;
select boardIdx,count(*) as replyCnt from boardReply where boardIdx = 39;

select * from board where idx = 39;
select *,(select count(*) from boardReply where boardIdx = 39) as replyCnt from board where idx = 39;
select *,(select count(*) from boardReply where boardIdx = b.idx) as replyCnt from board b;
