# R 개념 정리글 첫번째

- 데이터분석 절차: 데이터 수집 -> 표본추출 -> 모집단에 대한 유추 -> 확률 (-> 추정 & 검정) -> 회귀분석  <- 머신러닝

- R은 데이터분석에 특화된 프로그램

- R studio : R tool -1  (https://www.rstudio.com/products/rstudio/download/#download)

- jupyter notebook : R tool -2  (conda install -c r r-essentials)



### 1. 데이터 타입

#### (1) 기본 자료형

​	1) 숫자형

​	2) 문자형

​	3) 논리형 : TRUE, FALSE, T, F

​	4) 결측 데이터 : NA, NaN

#### (2) 자료형 확인(is.xxx())

​	1) is.numeric(), is.integer(), is.double()

​	2) is.logical()

​	3) is.character()

​	4) is.data.frame()

​	5) is.na(), is.nan()

​	6) is.complex() : 복소수인지아닌지

​	7) is.factor()

#### (3) 자료형 변환(as.xxx())

​	1) as.numeric(), as.integer(), as double()

​	2) as.logical()

​	3) as.character()

​	4) as.data.frame()

​	5) as.list()

​	6) as.array()

​	7) as.factor()

​	8) as.vector()

​	9) as.Date()  : 대문자인것 주의

#### (4) 자료형 보기

​	class(), mode()

#### (5) 팩터

	- 범주형 데이터자료 표현, 하나의 데이터 타입이다!

### 2. 데이터 구조 

### 	(vector, matrix, array, list, data.frame) (!핵심!) 

#### (1) Vector

- R에서 가장 기본이 되는 자료구조 (모든 데이터는 벡터부터 시작한다!)

- 1차원 배열(의 선형구조)

- 변수[index]로 접근(시작 인덱스는 1부터)  - 파이썬은 0부터 시작

- 동일한 자료형만 저장

- 생성 함수 : c(), seq(), req()

- 처리 함수 : union(), setdiff(), intersect(), ...

#### (2) Matrix (행렬)

 - 행과 열의 2차원 배열
 
 - 동일한 데이터 타입만 저장 가능
 
 - 생성 함수 : matrix(), rbind(), cbind()
 
 - 처리 함수 : apply()

#### (3) Array(다차원 배열)

 - 행, 열, 면의 3차원 배열 형태의 객체를 생성

 - 생성 함수 : array()

  

#### (4) List : python의 dict와 유사 (python의 list와 다름!)

​	Key와 Value가 한 쌍

​	python에서의 dict와 유사

​	생성함수 : list()

​	처리함수 : unlist(), lapply(), sapply()

#### (5) DataFrame

 - 데이터베이스의 테이블과 유사
 
 - R에서 가장 많이 사용하는 구조
 
 - 컬럼 단위로 서로 다른 데이터 타입 사용 가능
 
 - 리스트와 벡터의 혼합형(컬럼은 리스트, 컬럼내의 데이터는 벡터)
 
 - python에서는 라이브러리를 import하여 사용하던 기능을 R에서는 기본기능으로 사용할 수 있음
 
 - 생성함수 : data.frame(), read.table(), read.csv()
 
 - 처리함수 : str(), ncol(), nrow(), apply(), summary(), subset(), ...
 

#### (6) stringr

​	1) str_length() <br>

​	2) str_c()<br>

​	3) str_sub()<br>

​	4) str_split()<br>

​	5) str_replace()<br>

​	6) str_extract()<br>

​	7) str_extract_all()<br>

​	8) str_locate()<br>

​	9) str_locate_all()<br>

<br>
<br>
<br>
<br>
### (참고) 패키지

#### (1) 설치

​	install.packages("패키지이름")<br>

​	Rstudio의 패널 이용

#### (2) 사용

​	library(패키지명)  (# 파이썬에서의 import와 유사)<br>

​	require(패키지명) 

#### (3) 삭제

​	remove.packages("패키지명")<br>

#### (4) 경로

​	C:/Users/'폴더명'/Documents/R/win-library/3.6
