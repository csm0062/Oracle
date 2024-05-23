--08-----------------------------------------------------------------
--1) 평점이 3.0에서 4.0사이의 학생을 검색하라(between and)
SELECT *
	 FROM STUDENT
	 WHERE AVR BETWEEN 3.0 AND 4.0;
	 

--2) 1994년에서 1995년까지 부임한 교수의 명단을 검색하라(between and)
SELECT *
	FROM PROFESSOR
	WHERE HIREDATE BETWEEN TO_DATE('1994-01-01 00:00:00','yyyy-MM-dd HH24:mi:ss')
					   AND TO_DATE('1995-12-31 00:00:00','yyyy-MM-dd HH24:mi:ss');
	

--3) 화학과와 물리학과, 생물학과 학생을 검색하라(in)
SELECT *
	FROM STUDENT
	WHERE MAJOR IN ('화학', '물리', '생물'); 

--4) 정교수와 조교수를 검색하라(in)
SELECT *
	FROM PROFESSOR
	WHERE ORDERS IN ('정교수', '조교수');

--5) 학점수가 1학점, 2학점인 과목을 검색하라(in)
SELECT CNAME
	 , ST_NUM 
	FROM COURSE
	WHERE ST_NUM IN(1,2);

--6) 1, 2학년 학생 중에 평점이 2.0에서 3.0사이인 학생을 검색하라(between and)
SELECT ST.SNAME
	 , ST.SYEAR
	 , ST.AVR
	 FROM STUDENT ST
	WHERE SYEAR IN(1,2)
	  AND AVR BETWEEN 2.0 AND 3.0;
	 

--7) 화학, 물리학과 학생 중 1, 2 학년 학생을 성적순으로 검색하라(in)
SELECT *
	FROM STUDENT ST
	WHERE ST.MAJOR IN('화학','물리')
	  AND ST.SYEAR IN(1,2)
	  ORDER BY AVR DESC;

--8) 부임일이 1995년 이전인 정교수를 검색하라(to_date)
SELECT *
	FROM PROFESSOR
	WHERE HIREDATE < TO_DATE('1995-01-01 00:00:00','yyyy-MM-dd HH24:mi:ss')
	  AND ORDERS = '정교수';
					  
--09-----------------------------------------------------------------
--1) 송강 교수가 강의하는 과목을 검색한다
SELECT C.CNAME
	 , P.PNAME
	 FROM COURSE C
	 JOIN PROFESSOR P
	   ON C.PNO = P.PNO
	 WHERE P.PNAME = '송강';

--2) 화학 관련 과목을 강의하는 교수의 명단을 검색한다
SELECT C.CNAME
	 , P.PNAME
	 FROM COURSE C
	 JOIN PROFESSOR P
	   ON C.PNO = P.PNO
	 WHERE C.CNAME LIKE '%화학%';

--3) 학점이 2학점인 과목과 이를 강의하는 교수를 검색한다
SELECT C.CNAME
	 , P.PNAME
	 , C.ST_NUM
	 FROM COURSE C
	 JOIN PROFESSOR P
	   ON C.PNO = P.PNO
	 WHERE C.ST_NUM = 2;

--4) 화학과 교수가 강의하는 과목을 검색한다
SELECT C.CNAME
	 , P.PNAME
	 , C.ST_NUM
	 FROM COURSE C
	 JOIN PROFESSOR P
	   ON C.PNO = P.PNO
	 WHERE P."SECTION" = '화학';

--5) 화학과 1학년 학생의 기말고사 성적을 검색한다
SELECT ST.MAJOR
	 , ST.SYEAR
	 , SC.RESULT
	 FROM STUDENT ST
	 JOIN SCORE SC
	   ON ST.SNO  = SC.SNO
	 WHERE ST.SYEAR = 1
	   AND ST.MAJOR = '화학';

--6) 일반화학 과목의 기말고사 점수를 검색한다
SELECT SC.RESULT
	 , C.CNAME 
	 FROM SCORE SC
	 JOIN COURSE C
	   ON  SC.CNO = C.CNO
	 WHERE CNAME = '일반화학';

--7) 화학과 1학년 학생의 일반화학 기말고사 점수를 검색한다
SELECT ST.MAJOR
	 , ST.SYEAR
	 , C.CNAME
	 , SC.RESULT
	 FROM SCORE SC
	 JOIN STUDENT ST
	   ON ST.SNO  = SC.SNO
	 JOIN COURSE C
	   ON SC.CNO = C.CNO
	 WHERE ST.SYEAR = 1
	   AND ST.MAJOR = '화학'
	   AND C.CNAME = '일반화학';

--8) 화학과 1학년 학생이 수강하는 과목을 검색한다
SELECT ST.MAJOR
	 , ST.SYEAR
	 , C.CNAME
	 FROM SCORE SC
	 JOIN STUDENT ST
	   ON SC.SNO = ST.SNO
	 JOIN COURSE C
	   ON SC.CNO = C.CNO
	   WHERE ST.MAJOR = '화학'
	     AND ST.SYEAR = 1
	 

--9) 유기화학 과목의 평가점수가 F인 학생의 명단을 검색한다
SELECT ST.SNAME
	 , SC."RESULT"
	 , C.CNAME
	 , GR.GRADE
	 FROM STUDENT ST
	 JOIN SCORE SC
	   ON ST.SNO = SC.SNO
	 JOIN COURSE C
	   ON SC.CNO = C.CNO
	 JOIN SCGRADE GR
	 --비등가조인사용
	   ON SC.RESULT <= GR.HISCORE 
	  AND SC.RESULT >= GR.LOSCORE
	 WHERE C.CNAME = '유기화학'
	   AND GR.GRADE = 'F';
	  
--10-----------------------------------------------------------------
--1) 학생중에 동명이인을 검색한다
SELECT ST.*
	 FROM STUDENT ST
	 JOIN STUDENT S
	   ON ST.SNO != S.SNO
	  AND ST.SNAME = S.SNAME
	ORDER BY ST.SNAME;
	
--2) 전체 교수 명단과 교수가 담당하는 과목의 이름을 학과 순으로 검색한다
SELECT *
	FROM PROFESSOR P
	JOIN COURSE C
	  ON P.PNO = C.PNO
	ORDER BY CNAME;

--3) 이번 학기 등록된 모든 과목과 담당 교수의 학점 순으로 검색한다
SELECT *
	FROM COURSE C
	FULL JOIN PROFESSOR P
	  ON C.PNO = P.PNO
	ORDER BY ST_NUM;


--11-----------------------------------------------------------------
--1) 각 과목의 과목명과 담당 교수의 교수명을 검색하라
SELECT C.CNAME
	 , P.PNAME
	 FROM COURSE C
	 JOIN PROFESSOR P
	   ON C.PNO = P.PNO;

--2) 화학과 학생의 기말고사 성적을 모두 검색하라
SELECT ST.MAJOR
	 , ST.SNAME 
	 , SC.RESULT
	 FROM STUDENT ST
	 JOIN SCORE SC
	   ON ST.SNO = SC.SNO
	 WHERE ST.MAJOR = '화학';

--3) 유기화학과목 수강생의 기말고사 시험점수를 검색하라
SELECT ST.SNAME 
	 , SC.RESULT
	 , C.CNAME
	 FROM SCORE SC
	 JOIN STUDENT ST
	   ON ST.SNO = SC.SNO
	 JOIN COURSE C
	   ON SC.CNO  = C.CNO 
	 WHERE C.CNAME = '유기화학'; 

--4) 화학과 학생이 수강하는 과목을 담당하는 교수의 명단을 검색하라
SELECT DISTINCT P.*
	FROM PROFESSOR P
	JOIN COURSE C
	  ON P.PNO = C.PNO
	JOIN SCORE SC
	  ON SC.CNO = C.CNO
	JOIN STUDENT ST
	  ON ST.SNO = SC.SNO
	WHERE ST.MAJOR = '화학';

--5) 모든 교수의 명단과 담당 과목을 검색한다
SELECT P.*
	 , C.CNAME 
	FROM PROFESSOR P
	LEFT JOIN COURSE C
	  ON P.PNO = C.PNO;

--6) 모든 교수의 명단과 담당 과목을 검색한다(단 모든 과목도 같이 검색한다)
SELECT P.*
	 , C.CNAME 
	FROM PROFESSOR P
	FULL JOIN COURSE C
	  ON P.PNO = C.PNO;
