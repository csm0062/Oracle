-- 1. 추가적인 조인
-- 1-1. NATURAL JOIN: 조인조건을 명시하지 않아도 자동으로 조인될 컬럼을 추적해서 조인을 해주는 조인
-- 조인되는 컬럼은 테이블의 별칭을 사용할 수 있다.
-- 학생의 학생번호, 학생이름, 기말고사 성적 조회
SELECT ST.SNO
	 , ST.SNAME
	 , SC.CNO
	 , SC.RESULT
	 FROM STUDENT ST
	 JOIN SCORE SC
	   ON ST.SNO = SC.SNO
	 ORDER BY ST.SNO, SC.CNO;
	
-- NATURAL JOIN 사용
SELECT SNO
	 , ST.SNAME
	 , SC.CNO
	 , SC.RESULT
	FROM STUDENT ST
	NATURAL JOIN SCORE SC
	ORDER BY SNO, SC.CNO;

-- NATURAL JOIN을 이용해서 학생번호, 학생이름, 해당학생의 기말고사 평균점수 조회
SELECT SNO
	 , ST.SNAME
	 , AVG(SC.RESULT)
	 FROM STUDENT ST
	 NATURAL JOIN SCORE SC
	 GROUP BY SNO, ST.SNAME
	 ORDER BY SNO;
	 

-- NATURAL JOIN을 이용해서 최대급여가 4000만원 이상인 부서번호, 부서이름, 최대급여 조회
SELECT 


-- 2. 다중컬럼 IN절
-- 여러개의 컬럼의 값과 여러개의 데이터를 비교하고 싶을 때 사용하는 구문
-- (컬럼1, 컬럼2) IN ((데이터1-1, 데이터 2-1),(데이터 1-2, 데이터 2-2), ...,(데이터1-N,데이터2-N))
-- => (컬럼1 = 데이터1-1 AND 컬럼2 + 데이터 2-1) OR (컬럼1 = 데이터 1-2 AND 컬럼2 = 데이터2-2) OR...
-- OR (컬럼1 = 데이터 1-N AND 컬럼2 = 데이터 2-N)
-- 부서번호가 10 이면서 업무가 분석이나 개발인 사원의 사원번호, 사원이름, 업무, 부서번호
SELECT ENO
	 , ENAME
	 , JOB
	 ,DNO
	 FROM EMP
	 WHERE DNO = '10'
	   AND JOB IN ('개발','분석');
	  
SELECT ENO
	 , ENAME
	 , JOB
	 , DNO
	 FROM EMP
	 WHERE (DNO, JOB) IN(('10','개발'),('10','분석'));

SELECT ENO
	 , ENAME
	 , JOB
	 , DNO
	 FROM EMP
	 WHERE (DNO= '10'AND JOB = '개발')
		OR (DNO= '10'AND JOB = '분석');

-- 다중 컬럼 IN절을 사용해서 화학과 1학년 학생이거나 물리학과 3학년인 학생의 학생번호, 학생이름, 전공, 학년 조회
SELECT SNO
	 , SNAME
	 , MAJOR
	 , SYEAR
	 FROM STUDENT
	 WHERE (MAJOR, SYEAR) IN(('화학','1'),('물리','3'));
	
-- 다중 컬럼 IN절을 사용해서 부서번호는 01이나 02면서 사수번호가 0001인 사원의 사원번호, 사원이름, 사수번호, 부서번호 조회
SELECT ENO
	 , ENAME
	 , MGR
	 , DNO
	 FROM EMP
	 WHERE (DNO,MGR) IN (('01','0001'),('01','0001'));
	    
	
-- 다중 컬럼 IN절을 사용해서 기말고사 성적의 평균이 48점이상인 과목의 과목번호, 과목이름,기말고사 평균점수, 교수번호, 교수이름 조회
SELECT SC.CNO
	 , C.CNAME
	 , AVG(SC.RESULT)
	 , C.PNO
	 , P.PNAME
	FROM SCORE SC
	JOIN COURSE C
	  ON C.CNO = SC.CNO
	JOIN PROFESSOR P
	  ON C.PNO = P.PNO
	GROUP BY SC.CNO, C.CNAME, C.PNO, P.PNAME
	HAVING (SC.CNO, C.PNO) IN (
		SELECT S.CNO
			 , CO.PNO
			 FROM SCORE S
			 JOIN COURSE CO
			   ON S.CNO = CO.CNO
			   GROUP BY S.CNO, CO.PNO
			   HAVING AVG(S.RESULT) >= 48
			   
	);
	
	
	
	
	
	
	
	
	


