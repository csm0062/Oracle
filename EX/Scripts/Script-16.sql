CREATE TABLE T_MEMBER(
	id NUMBER (10) PRIMARY KEY,
	username VARCHAR2(20) UNIQUE,
	password VARCHAR2(100)
);

CREATE SEQUENCE member_seq;








