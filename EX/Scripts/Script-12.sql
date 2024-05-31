-- 1. Stored Sub Program: SQL로 작성된 프로그램들을 오라클 내부에 저장했다가 필요할 떄마다 호출해서 사용할 수 있는 데
-- 						  오라클 내부에 저장되지 않는 PL/SQL 프로그램들을 Stored Sub Program이라고 한다.
--						  Stored Prcadure, Stored Funtion, Trigger 등이 있다.
-- 1-1. Stored Procedure
-- 파라미터가 없는 프로시저
-- 프로시저의 선언
CREATE OR REPLACE PROCEDURE PRO_NOPARAM
IS
	ENO VARCHAR2(8);
	ENAME VARCHAR2(20);
BEGIN
	ENO := '1111';
	ENAME := '이순신';

	INSERT INTO EMP(ENO, ENAME)
	VALUES(ENO, ENAME);
	COMMIT;
END;

-- 프로시저의 실행





































































































