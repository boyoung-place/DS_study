SQL의 시작
-MySQL  (VS Oracle VS MS-SQL server 등 비슷한거 많음.) 규모가 크지않으면 대부분 MySQL씀.
-SQLite
-MongoDB

데이터: 정형(어떤 데이터가 저장될것인지 미리정해놓고 모음), 비정형 데이터

DataBase
================
Data Persistence
파일 => DBMS
DataWareHousing(DataMining)
대용량 데이터베이스

1. DBMS : Oracle, MS-SQL, CB2, Infomix, Sybase, MySQL(MariaDB)...
     1) 네트워크 유형에 따라
         - 로컬 DBMS : Access, SQLite
         - 네트워크 DBMS : 서버, 클라이언트 (클라이언트가 요청하고 서버가 요청한 데이터를 보내줌, 컴터 2대필요..?) (MySQL은 서버와 클라이언트 둘다의 역할이 가능)

     2) 데이터 저장 형태
         - 계층형 DB : 데이터를 Tree 모양으로
         - 네트워크형 DB : Graph (Tree의 단점보완) BUT 실용성 안좋음
         - 관계형 DB : Table
         - 객체지향형 DB
         - 객체관계형 DB

         -- 데이터의 양이 많아짐에 따라 처리속도 더딤.. -> 극복: 네트워크 DB(=Graph) BUT? 실용성이 떨어짐.

     3) SQL(Structured Query Language) : 비절차적 언어, 데이터베이스만을 위한 언어, 생산성 매우 좋음, 
        여러 언어들의 조합
        - DDL(Data Definition Language) :데이타 정의  # 데이터가 잘 돌아갈수 있도록
            CREATE
            ALTER
            DROP

        - DML(Data Manipulation)
            INSERT
            UPDATE
            DELETE

        - DCL(Data control)
            백업, 복원, 인증, 보안
            GRANT(권한 부여), REVOKE(권한 배제)

        - QL(Query Language)
            SELECT (조회의 의미로 많이씀,)

          *. ANSI-SQL (어떤 제품을 써도 똑같이 표준문법을 쓸 수 있음)
             오라클 : PL-SQL
             MS : T-SQL

        - SQL 사용여부
            사용 : 관계형 DB
            사용안함 : 비관계형 DB(NoSQL, Not Only SQL)

2. MySQL 클라이언트 프로그램
    1) 콘솔 : mysql.exe
    2) 윈도우용 : workbench, heidi


    # mysql show databases; 에서 information_schema/mysql/performance_schema/sys는 가급적이면 사용금지(잘못했다간 프로그램 다시 깔아야함)
    sakila & world는 sample = 실습가능

    # use "DB 이름"

    # show tables;
    table 뭐 있는지 확인
    실제 데이터를 저장하고 있는것 = Table  ( tables ⊂ DB ⊂ DBMS )

    # desc "이름 among tables";
    Table의 구조 파악 필요함.

    # SELECT first_name FROM "table이름"
    Table의 특정부분 확인

3. 접속 시 기본 작업명령어 # sql은 대,소문자 구분안함
    show databases; - DB 뭐가 있는지 알면 사용할 필요x
    use "특정DB"; (연결) - 처음에 무조건 써야하는 명령어
    show tables;
    desc(describe) "table 이름"; -table의 구조 설명 요구 명령어
    select "이름1", "이름2" from "table 이름"
 
 -- 한줄 주석
 /*
 여러줄
 주석
 */   

4. SELECT
    1) 기본 문법 (saple sql파일, scott으로 문법 알아보기)
        SELECT 필드명,... FROM 테이블명;
        SELECT * FROM 테이블명;  (<- 모든 필드명 선택)

        -- 필드의 가공 처리 (필드에 직접 가공 가능)
        SELECT empno, ename, sal, sal+100 FROM scott_emp;

        -- 필드의 alias(별명) (보여지는 이름만 달라진다.)
        SELECT empno, ename, mgr (as,생략가능) manager FROM scott_emp;
        SELECT empno, ename, mgr as 'my manager' FROM scott_emp; (<-공백있는 alias 사용 시)

        -- 중복 제거(*중요중요*) : disctinct
        SELECT disctinct job FROM scott_emp;
    
    2) 확장 문법 
        --Tip: 기본문법부터 짜놓고 그 다음에 필요부분 추가할 것
        2-1) 정렬 기능 : ORDER BY 필드명[, 필드명, ...]  [ASC │ DESC] (1번째 필드명으로 정렬, 그 결과값으로  필드명으로 정렬... 이런식으로 이어나가는 것)
                -- 급여가 많은 순으로 이름, 급여, 부서코드를 조회 
                SELECT ename, sal, deptno FROM scott_emp ORDER BY sal DESC;  (내림차순이니까 DESC p.96)

                -- 부서별로 급여가 적은 순으로 이름, 급여, 부서코드 조회
                SELECT ename, sal, deptno FROM scott_emp ORDER BY deptno ASC, sal ASC;

        2-2) 조건 기능(레코드 필터링) p.65 6장 : WHERE 조건문
            -- 급여가 3000$ 이상인 직원의 사번, 이름, 급여를 조회
            SELECT empno, ename, sal FROM scott_emp WHERE sal>=3000;

            -- 업무가 manager인 직원의 이름, 부서, 업무, 급여 조회
            SELECT ename, deptno, job, sal FROM scott_emp WHERE job = 'manager';   cf)""은 쓰지않는다!

            -- 부서가 20이고 업무가 analyst인 직원의 이름, 부서, 업무, 급여 조회 - 조건 조합하기(p.75)
            SELECT ename, deptno, job, sal FROM scott_emp WHERE deptno = 20 AND job = 'analyst';

            -- 급여가 1500이상 2500미만을 받는 직원의 이름, 부서, 업무 ,급여 조회 (단, 급여가 많은순으로 정렬)
                -- 정렬은 항상 맨 마지막에 쓴다.
            SELECT ename, deptno, job, sal FROM scott_emp WHERE sal>=1500 AND sal<2500 ORDER BY sal DESC;

            -- 급여가 1500이상 2500이하를 조회 (이상, 이하만 가능)
            SELECT ename, deptno, job, sal FROM scott_emp WHERE sal BETWEEN 1500 AND 2500;

            -- 업무가 clerk, salesman, analyst인 직원의 이름, 부서, 업무, 급여 조회
            SELECT ename, deptno, job, sal FROM scott_emp WHERE job = 'clerk' or job ='salesman' or job ='analyst';
            SELECT ename, deptno, job, sal FROM scott_emp WHERE job IN('clerk', 'salesman', 'analyst'); 
                -- IN : '='와 'OR' 연산자가 붙어있는 경우에만 사용가능
