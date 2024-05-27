show tables;

create table webMessage(
	idx int not null auto_increment,				/* 메세지 고유번호 */
	title varchar(100) not null,						/* 메세지 제목 */
	content text not null,									/* 메세지 내용 */
	sendId varchar(20) not null,						/* 보내는 사람 아이디 */
	sendSw char(1) not null default 's',		/* 보낸메세지(s), 휴지통(g), 휴지통삭제(x) 표시 */
	sendDate datetime default now(),				/* 메세지 보낸 날짜 */
	receiveId varchar(20) not null,					/* 받는 사람 아이디 */
	receiveSw char(1) not null default 'n',	/* 받은메세지(n), 읽은메세지(r), 휴지통(g), 휴지통삭제(x) 표시 */
	receiveDate datetime default now(),			/* 메세지 받은 날짜/읽은 날짜 */
	primary key(idx),
	foreign key(sendId) references member(mid),
	foreign key(receiveId) references member(mid)	
);

desc webMessage;
drop table webMessage;

insert into webMessage values (default,'안녕하세요','메세지 테스트 중','admin',default,default,'hkd1234','r',default);
insert into webMessage values (default,'회원 간 메세지','테스트 중','hkd1234',default,default,'kms1234','r',default);
insert into webMessage values (default,'메세지 테스트','1234','dnm1234',default,default,'kms1234',default,default);
insert into webMessage values (default,'안녕','ㅎㅇㅎㅇ','kms1234',default,default,'hkd1234',default,default);
insert into webMessage values (default,'오랜만이야','냉무','hkd1234',default,default,'kms1234','r',default);
insert into webMessage values (default,'하이요','냉무','kms1234',default,default,'hkd1234',default,default);
insert into webMessage values (default,'점심시간이다','냉무','hkd1234',default,default,'kms1234',default,default);

select * from webMessage;

select *,timestampdiff(hour,sendDate,now()) as hour_diff from webMessage where receiveId='kms1234' and (receiveSw='n' or receiveSw='r') order by idx desc;