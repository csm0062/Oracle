---41--------------------------------------
--1) 과목번호, 과목이름, 과목별 평균 기말고사 성적을 갖는 레코드의 배열을 만들고
--   기본 LOOP문을 이용해서 모든 과목의 과목번호, 과목이름, 과목별 평균 기말고사 성적을 출력하세요.
DECLARE
    TYPE SCO_REC IS RECORD(
        CNO SCORE.CNO%TYPE,
        AVGRES SCORE.RESULT%TYPE,
        CNAME COURSE.CNAME%TYPE
    );
    CURSOR SC_CUR IS
        SELECT SC.CNO
        	, C.CNAME
        	, AVG(SC.RESULT) AS AVGRES
        FROM SCORE SC
        JOIN COURSE C
          ON SC.CNO = C.CNO
        GROUP BY SC.CNO, C.CNAME;
    -- 여러 레코드를 저장할 배열 타입을 정의합니다.
    TYPE SCO_REC_ARR IS TABLE OF SCO_REC
    INDEX BY PLS_INTEGER;
    -- 레코드의 배열을 저장할 변수
    SCOREC SCO_REC_ARR;
    IDX NUMBER := 1;
BEGIN
    OPEN SC_CUR;
    LOOP
        FETCH SC_CUR 
       		INTO 
       		SCOREC(IDX).CNO
       	  , SCOREC(IDX).CNAME
       	  , SCOREC(IDX).AVGRES;
        EXIT WHEN SC_CUR%NOTFOUND;  -- 먼저 조건을 확인합니다.
        IDX := IDX + 1; 
    END LOOP;
    CLOSE SC_CUR;
   
   -- 배열을 반복하면서 각 레코드의 데이터를 출력합니다.
    FOR IDX IN 1 .. SCOREC.COUNT 
    LOOP
        DBMS_OUTPUT.PUT_LINE('과목 번호: ' || SCOREC(IDX).CNO);
        DBMS_OUTPUT.PUT_LINE('과목 이름: ' || SCOREC(IDX).CNAME);
        DBMS_OUTPUT.PUT_LINE('평균 성적: ' || TO_CHAR(SCOREC(IDX).AVGRES));
       	DBMS_OUTPUT.PUT_LINE('-------------------------------');
    END LOOP;
   
END;

--2) 학생번호, 학생이름과 학생별 평균 기말고사 성적을 갖는 테이블 T_STAVGSC를 만들고
--   커서를 이용하여 학생번호, 학생이름, 학생별 평균 기말고사 성적을 조회하고 
--   조회된 데이터를 생성한 테이블인 T_STAVGSC에 저장하세요.

--  1번.학생번호, 학생이름과 학생별 평균 기말고사 성적을 갖는 테이블 T_STAVGSC
CREATE TABLE T_STAVGSC(
	SNO VARCHAR2(8),
    SNAME VARCHAR2(20),
    AVG_RES NUMBER
);
--DROP TABLE T_STAVGSC;

SELECT *
	FROM T_STAVGSC;
 
-- 2번. 커서를 이용하여 학생번호, 학생이름, 학생별 평균 기말고사 성적을 조회
DECLARE
	CURSOR STAVGSC_CUR IS
		SELECT SC.SNO
			 , ST.SNAME
			 , ROUND(AVG(SC.RESULT), 2) AS AVG_RES
			FROM SCORE SC
			JOIN STUDENT ST
			  ON SC.SNO = ST.SNO
			GROUP BY SC.SNO, ST.SNAME;
			 
--	 STAVGSC_ROW STAVGSC_CUR%ROWTYPE;
	
BEGIN
	FOR STAVGSC_ROW IN STAVGSC_CUR
	LOOP
		DBMS_OUTPUT.PUT_LINE(STAVGSC_ROW.SNO);
		DBMS_OUTPUT.PUT_LINE(STAVGSC_ROW.SNAME);
		DBMS_OUTPUT.PUT_LINE(STAVGSC_ROW.AVG_RES);
		DBMS_OUTPUT.PUT_LINE('--------------------');
	
	INSERT INTO T_STAVGSC
	VALUES STAVGSC_ROW;
	COMMIT;
	
	END LOOP;
END;






























