show tables;

create table schedule(
	idx int not null auto_increment,	/* 스케줄관리 고유번호 */
	mid varchar(20) not null,					/* 회원 아이디(일정 검색시 필요) */
	sDate datetime not null,					/* 일정 등록 날짜 */
	part varchar(10) not null,				/* 일정 분류(1.모임, 2.업무, 3.학습, 4.여행, 5.기타) */
	content text not null,						/* 일정 상세내역	 */
	primary key(idx),
	foreign key(mid) references member(mid)
);

desc schedule;

insert into schedule values(default,'hkd1234','2024-05-3','모임','초등학교 동창회');
insert into schedule values(default,'hkd1234','2024-05-4','학습','프로젝트 기획');
insert into schedule values(default,'kms1234','2024-05-4','업무','단체회의');
insert into schedule values(default,'kms1234','2024-05-9','여행','목포 여행');
insert into schedule values(default,'dnm1234','2024-05-13','업무','ceo미팅');
insert into schedule values(default,'dnm1234','2024-05-14','모임','중학교 동창회');
insert into schedule values(default,'hkd1234','2024-05-14','모임','중학교 동창회');
insert into schedule values(default,'hkd1234','2024-05-14','기타','치과 예약');
insert into schedule values(default,'admin','2024-05-18','업무','프로젝트 제작');
insert into schedule values(default,'admin','2024-05-20','업무','보고서 보완');
insert into schedule values(default,'samsung','2024-05-20','업무','정기 총회');
insert into schedule values(default,'samsung','2024-06-2','모임','대학교 동기 모임');
insert into schedule values(default,'hkd1234','2024-05-25','학습','프로젝트 ppt 제작');
insert into schedule values(default,'hkd1234','2024-05-25','모임','저녁 약속');
insert into schedule values(default,'hkd1234','2024-05-25','기타','병원 예약');
insert into schedule values(default,'hkd1234','2024-05-25','학습','팀원 미팅');
insert into schedule values(default,'hkd1234','2024-06-17','학습','프로젝트 발표');
insert into schedule values(default,'apple','2024-05-25','모임','부서 회식');
insert into schedule values(default,'atom1234','2024-05-30','업무','반기보고서 제출');
insert into schedule values(default,'atom1234','2024-06-7','학습','학술교류회');
insert into schedule values(default,'atom1234','2024-05-22','업무','종합소득세 신고');
insert into schedule values(default,'admin','2024-05-31','학습','세미나 참석');
insert into schedule values(default,'hkd1234','2024-06-30','학습','인터넷강의 만료');
insert into schedule values(default,'kms1234','2024-06-11','여행','대만 출국');
insert into schedule values(default,'hkd1234','2024-06-15','모임','동호회 회식');

select * from schedule;

select * from schedule where mid='hkd1234' and substring(sDate,1,10)='2024-05-14' order by sDate;
select * from schedule where mid='hkd1234' and date_format(sDate,'%Y-%m-%d')='2024-05-25' order by sDate;
select * from schedule where mid='hkd1234' and date_format(sDate,'%Y-%m')='2024-05' order by sDate,part;
select *,count(*) as cnt from schedule where mid='hkd1234' and date_format(sDate,'%Y-%m')='2024-05' group by sDate order by sDate,part;
select *,count(*) as cnt from schedule where mid='hkd1234' and date_format(sDate,'%Y-%m')='2024-05' group by sDate,part order by sDate,part;

select * from schedule where mid='hkd1234' and date_format(sDate,'%Y-%m-%d')='2024-05-25' order by sDate, part;
select *,count(*) as cnt from schedule where mid='hkd1234' and date_format(sDate,'%Y-%m-%d')='2024-05-25' order by sDate, part;
select *,count(*) as cnt from schedule where mid='hkd1234' and date_format(sDate,'%Y-%m-%d')='2024-05-25' group by part order by sDate, part;
