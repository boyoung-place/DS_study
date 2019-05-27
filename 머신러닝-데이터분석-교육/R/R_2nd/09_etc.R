# MySQL연동해서 사용하기
# https://cran.r-project.org/bin/windows/Rtools/
# Rtools3.6버전이 없으므로 3.5버전 설치
R.version
sessionInfo()

# mysql접속해서 db형성, table형성하기
# create database myweb;
# use myweb;
# create table score(
#   student_no  varchar(50) primary key,
#   kor int default 0,
#   eng int default 0,
#   mat int default 0
# );
# 
# insert into score values('1', 90, 80, 70);
# insert into score values('2', 90, 88, 70);
# insert into score values('3', 90, 89, 70);
# insert into score values('4', 90, 87, 70);
# insert into score values('5', 90, 60, 70);
# 
# select * from score;
# 끝


#install.packages('rJava')
#install.packages('DBI')
#install.packages('RMySQL')
library(RMySQL)

conn <- dbConnect(MySQL(), dbname='myweb', user='root', password='1111', host='127.0.0.1')  # db 드라이버 지정,
conn # 연결단자

cat(dbListTables(conn))

result <- dbGetQuery(conn, 'select count(*) from score')
class(result)  # data.frame

result <- dbGetQuery(conn, 'select * from score')
result

dbListFields(conn, 'score')

# insert, update, delete 이용할때
dbSendQuery(conn, 'delete from score')
result <- dbGetQuery(conn, 'select count(*) from score')
result  # delete 확인

# file에서 읽어온 내용을 db에 저장
  # 시놀로지 챗 score.csv파일 다운로드
data <- read.csv('data/score.csv', header=T)
data

# 주의) 행 번호를 빼고 가져오기(row.names=)
dbWriteTable(conn, 'score', data, overwrite=T, row.names=F)

result <- dbGetQuery(conn, 'select * from score')
result

dbDisconnect(conn)


# SQL사용법 2
# sqldf : db랑은 전혀 상관없음. 데이터프레임을 그냥 데이터베이스에 있는 것처럼 사용한다.
detach('package:RMySQL', unload = T)  #<- 이걸 안하면 자꾸 db랑 연결하려는 작업이 실행되어서 문제가 생긴다.

install.packages('sqldf')
library(sqldf)

head(iris)
sqldf('select "Sepal.Length", Species from iris order by Species desc limit 5')

sqldf('select distinct Species from iris')

sqldf('select Species, count(*) from iris group by Species')

# (참고) 배열 -> aplyr  data.fram -> dplyr


# p.232 유닛 테스팅과 디버깅
# 디버깅(p.237)
# browser(p.242)
sum_to_ten <- function(){
  sum <- 0
  for(i in 1:10){
    sum <- sum+ i
    
    if(i >= 5){
      browser()
    }
  }
  
  return(sum)
}

result <- sum_to_ten()
result

# 폭포수 개발방식(waterfall): 요구사항 -> 수집분석 -> 모델링 -> 코딩 -> 테스트 -> 배포 -> 유지보수
# 애자일 방식: 문서를 통한 개발 방법이 아니라, code-oriented, 실질적인 코딩을 통한 방법론  cf)TDD(테스트우선 개발)

# 유닛 테스트(p.232)
#install.packages('testthat')
library(testthat)

fib <- function(n){
  if(n==0){
    return(1)
  }
  
  if(n>0){
    return(fib(n-1) + fib(n-2))
  }
}

expect_equal(1, fib(0))   # 피보나치 수열에 0을 넣으면 1과 같은 값이 나오는지 확인
expect_equal(1, fib(1))  # 오류 발생 <- 이렇게 중간중간 테스트하며 코드를 짜야한다.

# 코드 수정
fib <- function(n){
  if(n == 0 || n == 1){
    return(1)
  }
  
  if(n>=2){
    return(fib(n-1) + fib(n-2))
  }
}
expect_equal(1, fib(1))
expect_equal(2, fib(2))
expect_equal(3, fib(3))
expect_equal(5, fib(4))
