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

/* 리뷰에 댓글 달기 */
create table reviewReply(
	replyIdx int not null auto_increment,		/* 댓글의 고유번호 */
	reviewIdx int not null,							/* 원본글(부모글:리뷰)의 고유번호(외래키로 설정) */
	replyMid varchar(20) not null,			/* 댓글 올린 이의 아이디 */
	replyNickName varchar(20) not null,	/* 댓글 올린 이의 닉네임 */
	replyRDate datetime default now(),	/* 댓글 올린 날짜 */
	replyContent text not null,					/* 댓글 내용 */
	primary key(replyIdx),
	foreign key(reviewIdx) references review(idx),
	foreign key(replyMid) references member(mid)
);
desc reviewReply;
drop table reviewReply;

select * from review order by idx desc;
select * from review where partIdx=16;

select * from reviewReply order by replyIdx desc;

select * from review v, reviewReply r where v.partIdx=16 and v.idx=r.reviewIdx;
select * from review v, reviewReply r where v.partIdx=16 and v.idx=r.reviewIdx order by v.idx desc, r.replyIdx desc;
/* 내부조인이라 댓글이 없는 리뷰는 출력이 되지 않는 현상 발생 */

/* --> 리뷰 부분은 다 보여주고 댓글 부분은 없으면 null로 표시하기 */
select * from review v left join reviewReply r on v.partIdx=16 and v.idx=r.reviewIdx order by v.idx desc, r.replyIdx desc;
/* left join이라 review의 모든 내용이 나오게 됨(idx구별없이) */

/* 서브쿼리를 이용하여 review의 특정 idx 중 댓글 표시 */
select * from (select * from review where partIdx=16) as v left join reviewReply r on v.partIdx=16 and v.idx=r.reviewIdx order by v.idx desc, r.replyIdx desc;

