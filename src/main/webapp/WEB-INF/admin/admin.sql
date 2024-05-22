show tables;

/* 신고테이블(complaint) */
create table complaint(
	idx int not null auto_increment,	/* 신고테이블 고유번호 */
	part varchar(15) not null,				/* 신고 분류(메뉴)(게시판: board, 자료실: pds, 방명록: guest) */
	partIdx int not null,							/* 해당 글의 고유번호 */
	cpMid varchar(20) not null,				/* 신고자 아이디 */
	cpContent text not null,					/* 신고 사유 */
	cpDate datetime default now(),		/* 신고 날짜 */
	primary key(idx)
);

desc complaint;

insert into complaint values (default,'board',16, 'hkd1234','광고',default);

select * from complaint;

select c.*,b.title,b.nickName,b.mid from complaint c, board b where c.partIdx = b.idx;

select c.*, b.title as title, b.nickName as nickName, b.mid as mid from complaint c, board b where c.partIdx = b.idx;

select c.*, date_format(c.cpDate,'%Y-%m-%d %H:%i') as cpDate, b.title,b.nickName,b.mid from complaint c, board b where c.partIdx = b.idx;

/* 리뷰 테이블(review) */
create table review(
	idx int not null auto_increment,	/* 리뷰테이블 고유번호 */
	part varchar(20) not null,				/* 분야(게시판:board, 자료실:pds...) */
	partIdx int not null,							/* 해당 분야의 고유번호 */
	mid varchar(20) not null,					/* 리뷰 올린이 */
	nickName varchar(20) not null,		/* 리뷰 작성자 닉네임 */
	star int not null default 0,			/* 별점 부여 점수 */
	content text,											/* 리뷰 내용 */
	rDate datetime default now(),			/* 리뷰 등록 일자 */
	primary key(idx),
	foreign key(mid) references member(mid)
);

desc review;

