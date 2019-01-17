set echo on

/* ---------------
   Create table structure
   --------------- */

drop table enrollments;
drop table prereq;
drop table schclasses;
drop table courses;
drop table students;
drop table majors;
drop table waitlist;

-----
-----


create table MAJORS
	(major varchar2(3) Primary key,
	mdesc varchar2(30));
insert into majors values ('ACC','Accounting');
insert into majors values ('FIN','Finance');
insert into majors values ('IS','Information Systems');
insert into majors values ('MKT','Marketing');

create table STUDENTS 
	(snum varchar2(3) primary key,
	sname varchar2(10),
	standing number(1),
	major varchar2(3) constraint fk_students_major references majors(major),
	gpa number(2,1),
	major_gpa number(2,1));

insert into students values ('101','Andy',3,'IS',2.8,3.2);
insert into students values ('102','Betty',2,null,3.2,null);
insert into students values ('103','Cindy',3,'IS',2.5,3.5);
insert into students values ('104','David',2,'FIN',3.3,3.0);
insert into students values ('105','Ellen',1,null,2.8,null);
insert into students values ('106','Frank',3,'MKT',3.1,2.9);
insert into students values ('107','Beth',3,'MKT',2.7,2.9);
insert into students values ('108','Danny',2,'MKT',3.1,3.9);
insert into students values ('109','David M',3,'MKT',2.5,2.9);
insert into students values ('110','Kevin',4,'MKT',3.5,3.75);
insert into students values ('111','Peggy',4,'MKT',3.76,3.9);
insert into students values ('112','Sara',1,'MKT',2.5,null);
insert into students values ('113','Nick',3,'ACC',1.8,1.9);

create table COURSES
	(dept varchar2(3) constraint fk_courses_dept references majors(major),
	cnum varchar2(3),
	ctitle varchar2(30),
	crhr number(3),
	standing number(1),
	primary key (dept,cnum));

insert into courses values ('IS','300','Intro to MIS',3,2);
insert into courses values ('IS','301','Business Communicatons',3,2);
insert into courses values ('IS','310','Statistics',3,2);
insert into courses values ('IS','340','Programming',3,3);
insert into courses values ('IS','380','Database',3,3);
insert into courses values ('IS','385','Systems',3,3);
insert into courses values ('IS','480','Adv Database',3,4);

create table SCHCLASSES (
	callnum number(5) primary key,
	year number(4),
	semester varchar2(3),
	dept varchar2(3),
	cnum varchar2(3),
	section number(2),
	capacity number(3));

alter table schclasses 
	add constraint fk_schclasses_dept_cnum foreign key 
	(dept, cnum) references courses (dept,cnum);

insert into schclasses values (10110,2014,'Fa','IS','300',1,5);
insert into schclasses values (10115,2014,'Fa','IS','300',2,5);
insert into schclasses values (10120,2014,'Fa','IS','300',3,5);
insert into schclasses values (10125,2014,'Fa','IS','301',1,5);
insert into schclasses values (10130,2014,'Fa','IS','301',2,5);
insert into schclasses values (10135,2014,'Fa','IS','310',1,5);
insert into schclasses values (10140,2014,'Fa','IS','310',2,5);
insert into schclasses values (10145,2014,'Fa','IS','340',1,5);
insert into schclasses values (10150,2014,'Fa','IS','380',1,5);
insert into schclasses values (10155,2014,'Fa','IS','385',1,5);
insert into schclasses values (10160,2014,'Fa','IS','480',1,5);

create table PREREQ
	(dept varchar2(3),
	cnum varchar2(3),
	pdept varchar2(3),
	pcnum varchar2(3),
	primary key (dept, cnum, pdept, pcnum));
alter table Prereq 
	add constraint fk_prereq_dept_cnum foreign key 
	(dept, cnum) references courses (dept,cnum);
alter table Prereq 
	add constraint fk_prereq_pdept_pcnum foreign key 
	(pdept, pcnum) references courses (dept,cnum);

insert into prereq values ('IS','380','IS','300');
insert into prereq values ('IS','380','IS','301');
insert into prereq values ('IS','380','IS','310');
insert into prereq values ('IS','385','IS','310');
insert into prereq values ('IS','340','IS','300');
insert into prereq values ('IS','480','IS','380');

create table ENROLLMENTS (
	snum varchar2(3) constraint fk_enrollments_snum references students(snum),
	callnum number(5) constraint fk_enrollments_callnum references schclasses(callnum),
	grade varchar2(2),
	primary key (snum, callnum));

insert into enrollments values (101,10110,'A');
insert into enrollments values (102,10110,'B');
insert into enrollments values (103,10120,'A');
insert into enrollments values (101,10125,null);
insert into enrollments values (102,10130,null);
insert into enrollments values (101,10150,null);
insert into enrollments values (101,10155,null);
insert into enrollments values (103,10110,'A');
insert into enrollments values (101,10160,null);
insert into enrollments values (104,10120,null);
insert into enrollments values (105,10120,null);

create table WAITLIST(
	snum varchar2(3),
	callnum varchar2(5),
	time date,
	primary key (callnum,snum));


commit;

