drop user student cascade;
create user student identified by student;
grant dba to student;
conn student/student
create table classroom
(
classroom_id nvarchar2(10) constraint classroomidpk primary key,
year nvarchar2(20),
grade_id number(8),
section nvarchar2(10),
status nvarchar2(10),
remarks nvarchar2(10),
teacher_id nvarchar2(10)
);
create or replace trigger biclassroom before insert on classroom for each row
declare
begin
 if(:new.classroom_id not like 'C%') then
	raise_application_error(-20001,'Class room id must starts with C');
  end if;
end;
/

create table grade
(
grade_id nvarchar2(10) constraint gradeidpk primary key,
name nvarchar2(20),
desc1 nvarchar2(10)
);
create or replace trigger bigrade before insert on grade for each row
declare
begin
 if(:new.grade_id not like 'G%') then
	raise_application_error(-20001,'grade id must starts with G');
  end if;
end;
/

create table course
(
course_id nvarchar2(10) constraint courseidpk primary key,
name nvarchar2(20),
desc1 nvarchar2(10),
grade_id nvarchar2(8) constraint gradeidfk references grade(grade_id) on delete cascade
);
create or replace trigger bicourse before insert on course for each row
declare
begin
 if(:new.course_id not like 'C%') then
	raise_application_error(-20001,'course id must starts with C');
  end if;
end;
/

create table teacher
(
teacher_id nvarchar2(10) constraint teacheridpk primary key,
fname nvarchar2(20),
lname nvarchar2(10),
dob nvarchar2(10),
phone number(20),
mobile number(20),
status nvarchar2(10),
address nvarchar2(10)
);
create or replace trigger biteacher before insert on teacher for each row
declare
begin
 if(:new.teacher_id not like 'T%') then
	raise_application_error(-20001,'teacher id must starts with T');
  end if;
end;
/


create table student
(
student_id nvarchar2(10) constraint studentidpk primary key,
fname nvarchar2(20),
lname nvarchar2(10),
dob nvarchar2(10),
phone number(20),
mobile number(20),
parent_id nvarchar2(10),
date_of_join nvarchar2(10),
status nvarchar2(10)
);
create or replace trigger bistudent before insert on student for each row
declare
begin
 if(:new.student_id not like 'S%') then
	raise_application_error(-20001,'student id must starts with S');
  end if;
end;
/

create table parent
(
parent_id nvarchar2(10) constraint parentidpk primary key,
fname nvarchar2(20),
lname nvarchar2(10),
dob nvarchar2(10),
phone number(20),
mobile number(20),
status nvarchar2(10)
);
create or replace trigger biparent before insert on parent for each row
declare
begin
 if(:new.parent_id not like 'P%') then
	raise_application_error(-20001,'parent id must starts with P');
  end if;
end;
/

create table attendance
(
date1 nvarchar2(20) constraint date1pk primary key,
student_id nvarchar2(20) constraint studentidfk references student(student_id) on delete cascade,
status nvarchar2(10),
remarks nvarchar2(10)
);
create table class_room_student
(
classroom_id nvarchar2(20)constraint classroomidfk references classroom(classroom_id) on delete cascade,
student_id nvarchar2(20)constraint studentidfk1 references student(student_id) on delete cascade
);
create or replace trigger biclass_room_student before insert on class_room_student for each row
declare
begin
 if(:new.classroom_id not like 'C%') then
	raise_application_error(-20001,'classroom_id must starts with C');
  end if;
end;
/

create table exam
(
exam_id nvarchar2(20) constraint examidpk primary key,
exam_type_id number(20),
name nvarchar2(10),
start_date nvarchar2(10)
);
create or replace trigger biexam before insert on exam for each row
declare
begin
 if(:new.exam_id not like 'E%') then
	raise_application_error(-20001,'exam_id must starts with E');
  end if;
end;
/

create table exam_type
(
exam_type_id nvarchar2(20),
name nvarchar2(10),
desc1 nvarchar2(10)
);
create or replace trigger biexam_type before insert on exam_type for each row
declare
begin
 if(:new.exam_type_id not like 'E%') then
	raise_application_error(-20001,'exam_type_id must starts with E');
  end if;
end;
/


create table exam_result
(
exam_id nvarchar2(20) constraint examidfk references exam(exam_id) on delete cascade,
student_id nvarchar2(20) constraint studentidfk3 references student(student_id) on delete cascade,
course_id number(20),
marks nvarchar2(10)
);
create or replace trigger biexam_result before insert on exam_result for each row
declare
begin
 if(:new.exam_id not like 'E%') then
	raise_application_error(-20001,'exam_id must starts with E');
  end if;
end;
/

create table login 
(
id nvarchar2(10) constraint loginidpkchk primary key,
pwd nvarchar2(10)
);
insert into login values('student','student');

create table enquiry
(
name nvarchar2(10),
dob number(20),
gender nvarchar2(10),
fname nvarchar2(10),
address nvarchar2(10),
contact number(20),
email nvarchar2(10),
qualification nvarchar2(10),
college nvarchar2(10),
course nvarchar2(10),
date1 number(20)
);
create or replace trigger bienquiry before insert on enquiry for each row
declare
begin
 if(:new.name not like 'E%') then
	raise_application_error(-20001,'name must starts with E');
  end if;
end;
/
create table help
(
  nm nvarchar2(10),
  email nvarchar2(50),
  subject nvarchar2(20),
  msg nvarchar2(10)
);

create table message
(
name nvarchar2(10),
email nvarchar2(10),
subject nvarchar2(10),
message nvarchar2(10)
);

create table senquiry
(
name nvarchar2(10),
email nvarchar2(100),
course nvarchar2(10)
);


