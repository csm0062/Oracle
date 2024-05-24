-- 1. 단일행 함수
-- 단일행 함수는 하나의 데이터를 받아서 하나의 결과값을 리턴하는 함수이다.
-- 단일행 함수에는 문자함수, 숫자함수, 날짜함수, 일반함수 등이 존재한다.

-- 1-1. 문자함수
-- LOWER: 영문자를 소문자로 변환해서 리턴 
-- UPPER: 영문자를 대문자로 변환해서 리턴
-- INITCAP: 영문자의 첫 글자만 대문자로 나머지 글자는 소문자로 변환해서 리턴
SELECT DNO
	 , LOWER(DNAME)
	 , UPPER(DNAME)
	 , INITCAP(DNAME)
	FROM DEPT;

-- 부서이름이 대문자인지 소문지인지 알 수 없을 때
-- LOWER를 사용해서 소문자로 비교
SELECT DNO
	 , DNAME
	 , LOC
	 , DIRECTOR
	FROM DEPT
	WHERE LOWER(DNAME) = 'erp';

-- 1-2. 문자 연산 함수
-- CONCAT(테이터1, 테이터2): 테이터1과 테이터2가 결합된 새로운 데이터 리턴
SELECT CONCAT(SNAME, AVR)
	FROM STUDENT;

-- CONCAT 함수는 매개변수를 두 개만 받을 수 있어서 여러개의 데이터나 다른 표현을 넣고 싶을 때는 ||와 조합하여 사용한다.
SELECT CONCAT(SNAME, ': ' || AVR)
	FROM STUDENT;

-- CONCAT을 이용해서 부서번호, 부서이름, 지역을 부서번호 : 부서이름 : 지역 형태로 조회하세요.
SELECT CONCAT(DNO, ' : ' || DNAME || ' : ' || LOC) AS "부서번호 : 부서이름 : 지역"
	FROM DEPT;

--SUBSTR(데이터, 시작인데스, 개수): 받아온 데이터에서 시작 인덱스에서 개수만큼 데이터를 잘라서 리턴
-- 교수 중에 정교수인 교수의 교수번호, 교수이름, 직위 조회
SELECT PNO
	 , PNAME
	 , ORDERS
	FROM PROFESSOR
	WHERE SUBSTR(ORDERS, 1, 1) = '정';

SELECT ENAME
	 , SUBSTR(ENAME, 2) -- 2번째 글자부터 모두
	 , SUBSTR(ENAME, -2) -- 뒤에서 두 번째 글자부터 모두
	 , SUBSTR(ENAME, 1, 2) -- 첫 번째 글자부터 두 글자
	 , SUBSTR(ENAME, -2, 2) -- 뒤에서 두 번째 글자부터 두 글자
	FROM EMP;

-- LENTH: 데이터의 길이를 리턴
-- LENTHB: 데이터의 길이를 BYTE 단위로 리턴
-- 오라클의 기본 문자셋은 AL32UTF8 => 영어를 제외한 다른 문자는 3BYTE씩 계산
SELECT DNAME
	 , LENGTH(DNAME)
	 , LENGTHB(DNAME)
	FROM DEPT;

-- INSTR(데이터, 문자): 데이터에서 주어진 문자의 위치를 리턴
-- DUAL 테이블: 오라클에서 제공하는 가상의 테이블
--			  간단하게 날짜나 연산 또는 결과값을 보기위해서 사용
--			  DUAL 테이블의 소유자는 SYS계정이지만 모든 사용자에서 사용이 가능하다.
SELECT INSTR('DATABASE', 'A') -- 첫 번째 A의 위치
	 , INSTR('DATABASE', 'A', 3) -- 세 번째 글자인 T다음의 첫 번째 A의 위치
	 , INSTR('DATABASE', 'A', 1, 3) -- 첫 번째 글자인 D 다음의 세 번째 A의 위치
	FROM DUAL;

-- TRIM
-- TRIM(leading 접두어 FROM 데이터): 데이터에서 접두어에 해당하는 값을 앞에서 제거
-- TRIM(trailing 접미어 FROM 데이터): 데이터에서 접미어에 해당하는 값을 뒤에서 제거
-- TRIM(both 문자 FROM 데이터): 데이터에서 문자에 해당하는 값을 앞, 뒤에서 제거
-- TRIM(데이터): 데이터에서 앞,뒤의 공백 제거
SELECT TRIM(LEADING '0' FROM '000123000')
	 , TRIM(TRAILING '0' FROM '000123000')
	 , TRIM(BOTH '0' FROM '000123000') -- BOTH는 생략 가능
	 , TRIM('    0 0 0 1 2 3 0 0 0    ')
	FROM DUAL;

-- LPAD(데이터, 길이, 문자): 지정한 길이에서 데이터의 길이를 뺀 나머지 길이만큼 문자로 앞에 채워주는 함수
-- RPAD(데이터, 길이, 문자): 지정한 길이에서 데이터의 길이를 뺀 나머지 길이만큼 문자로 뒤에 채워주는 함수
-- LPAD, RPAD: 영어를 제외한 나머지 문자를 2BYTE 계산, 길이는 BYTE 단위로 지정한다.
SELECT LPAD(ENAME, 10, '*')
	 , RPAD(ENAME, 10, '*')
	FROM EMP;

-- 지정한 길이가 데이터의 길이보다 작거나 같으면 문자를 붙이지 않는다.
SELECT LPAD(ENAME, 6, '*')
	 , RPAD(ENAME, 6, '*')
	FROM EMP;

-- 사원의 사원번호, 사원이름을 조회하는데 사원이름에서 마지막 한 글자만 빼고 조회
SELECT ENO
	 , SUBSTR(ENAME, 1, LENGTH(ENAME) - 1)
	FROM EMP;

-- 1-3. 문자열 치환함수
-- TRANSLATE
-- 치환될 문자에 포함된 모든 문자를 치환한다.
SELECT TRANSLATE('World of War', 'Wo', '--')
	FROM DUAL;

-- REPLACE
-- 치환될 문자열과 동일한 문자열을 치환한다.
SELECT REPLACE('World of War', 'Wo', '--')
	FROM DUAL;

-- 1-4. 숫자 함수
-- ROUND(데이터, 소수점 자리수): 지정된 소수점 자리수까지 반올림하여 반환
SELECT ROUND(123.45678, 3)
	FROM DUAL;

-- 학생의 학생번호, 학생이름, 전공, 학년, 4.5 만점으로 치환된 평점을 조회하는 데 평점은 소수점 둘째까지 조회(ROUND 함수 사용)
SELECT SNO
	 , SNAME
	 , MAJOR
	 , SYEAR
	 , AVR
	 , ROUND(AVR * 1.125 , 2)
	FROM STUDENT;

-- TRUNC(데이터, 소수점 자리수): 지정된 소수점 자리수까지 버림하여 반환
SELECT TRUNC(123.45678, 3)
	FROM DUAL;

-- MOD(데이터1, 데이터2): 데이터1에서 데이터2를 나눈 나머지 리턴
SELECT MOD(10, 4)
	FROM DUAL;

-- POWER(데이터1, 데이터2): 데이터1의 데이터2 제곱한 값을 리턴(데이터1의 데이터2승)
SELECT POWER(3, 3)
	FROM DUAL;

-- CEIL(데이터): 데이터보다 큰 가장 작은 정수 리턴
-- FLOOR(데이터): 데이터보다 작은 가장 큰 정수 리턴
SELECT CEIL(2.59)
	 , FLOOR(2.59)
	FROM DUAL;

-- SQRT(데이터): 데이터의 제곱근 값을 리턴
SELECT SQRT(9)
	 , SQRT(25)
	 , SQRT(100)
	FROM DUAL;

-- SIGN(데이터): 데이터의 부호를 판단해주는 함수. 데이터가 음수면 -1, 양수면 1, 0이면 0을 리턴
SELECT SIGN(-123)
	 , SIGN(0)
	 , SIGN(456)
	FROM DUAL;
	
-- 1-5. 날짜 연산
SELECT SYSDATE
	 , SYSDATE + 100 -- 오늘날짜부터 100일 뒤
	 , SYSDATE - 100 -- 오늘날짜부터 100일 전
	 , SYSDATE + 3 / 24 -- 현재시간으로부터 3시간 뒤
	 , SYSDATE - 5 / 24 -- 현재시간으로부터 5시간 전
	 , SYSDATE - TO_DATE('20230523', 'YYYYMMDD') -- 두 날짜간의 차이
	 -- 날짜에 TRUNC 함수를 사용하면 시간 분 초를 00:00:00로 초기화한다.
	 , TRUNC(SYSDATE) - TO_DATE('20230523', 'YYYYMMDD')
	FROM DUAL;

-- 1999년 1월 1일부터 100일 뒤 까지 부임한 교수의 교수번호, 교수이름, 부임일자 조회
SELECT PNO
	 , PNAME
	 , HIREDATE
	FROM PROFESSOR
	WHERE HIREDATE 
		BETWEEN TO_DATE('19990101', 'YYYYMMDD') 
		AND TO_DATE('19990101', 'YYYYMMDD') + 100;

-- 1-6. 날짜 함수
-- ROUND(날짜, 날짜 단위): 지정한 날짜 단위까지의 날짜는 빼오고 나머지 날짜는 초기화. 버려지는 날짜의 절반이상 지났으면 올림된다.
SELECT ROUND(SYSDATE, 'DD')
	FROM DUAL;

SELECT ROUND(TO_DATE('20241124', 'YYYYMMDD'), 'MM')
	FROM DUAL;

-- TRUNC(날짜, 날짜 단위): 지정한 날짜 단위까지의 날짜는 빼오고 나머지 날짜는 초기화. 버려지는 날짜는 그냥 초기화.
SELECT SYSDATE
	 , TRUNC(SYSDATE, 'YYYY')
	 , TRUNC(SYSDATE, 'MM')
	 , TRUNC(SYSDATE, 'DD')
	FROM DUAL;

-- MONTHS_BETWEEN(날짜1, 날짜2): 날짜1에서 날짜2를 뺀 일자 차이를 개월수로 치환해서 리턴
SELECT MONTHS_BETWEEN(TRUNC(SYSDATE, 'DD'), TO_DATE('20230831', 'YYYYMMDD'))
	FROM DUAL;

-- ADD_MONTHS(날짜, 숫자): 날짜에서 숫자만큼의 개월수를 더한 날짜 리턴
SELECT ADD_MONTHS(SYSDATE, 5)
	FROM DUAL;

-- NEXT_DAY(날짜, 요일): 날짜 이후에 처음으로 만나는 요일의 날짜 리턴
SELECT NEXT_DAY(SYSDATE, '일요일')
	FROM DUAL;

-- LAST_DAY(날짜): 날짜를 포함하고 있는 달의 마지막 날짜를 리턴
SELECT LAST_DAY(SYSDATE)
	FROM DUAL;

-- 사원의 사원번호, 사원이름, 입사일, 입사일 +100일의 날짜, 입사일 +10년의 날짜 조회
SELECT ENO
	 , ENAME
	 , HDATE
	 , HDATE + 100
	 , ADD_MONTHS(HDATE, 120)
	FROM EMP;
	
-- 1-7. 변환함수
-- TO_CHAR(날짜나 숫자, 변환될 문자열의 형식지정자): 매개변수로 받은 날짜나 숫자 데이터를 지정된 형식으로 변환한 문자열을 리턴
-- 숫자를 문자열로 변환
SELECT TO_CHAR(10000000, '999,999,999') -- 9자리까지 숫자를 표기하고 3자리마다 쉼표 표시
	 , TO_CHAR(1000000, '099,999,999') -- 9자리까지 숫자를 표기하고 3자리마다 쉼표 표시, 0을 붙여서 표기
	FROM DUAL;

-- 날짜를 문자열로 변환
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS')
	 , TO_CHAR(SYSDATE, 'YYYY/MM/DD DAY')
	 , TO_CHAR(SYSDATE, '"오늘은 "YYYY"년 " MM"월 " DD"일입니다."')
	 , TO_CHAR(SYSDATE, 'DY"요일입니다."')
	FROM DUAL;

SELECT TO_DATE('2024/05/24 15:18:00', 'YYYY/MM/DD HH24:MI:SS')
	FROM DUAL;

-- 교수의 부임일을 다음 형식으로 표현하세요
-- 'OOO 교수의 부임일은 YYYY년 MM월 DD일입니다.'


-- 교수중에 3월에 부임한 교수의 명단을 검색하세요



