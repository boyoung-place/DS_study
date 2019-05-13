# 변수
# 1. 모든 변수는 객체형태로 생성된다.
# 2. 모든 데이터 저장 가능(함수, 차트, 이미지 등...)
goods.code <- "a001"
goods.name = "냉장고"
goods.price = 850000

# 스칼라 변수(p.49): 단 하나의 값을 의미, 한 개의 값을 갖는 벡터
class(goods.code)
mode(goods.price)

# 함수 도움말
help(sum)
?sum

# 함수 파라미터 보기
args(mean)

# 함수 예제샘플 보기
example(sum)

####################################################################
# 자료 구조

# vector 생성
v <- c(1,2,3,4,5)
v
#combine value라는 뜻으로 c() 씀 : c() 많이 씀

(v <-c(1,2,3,4,5))
c(1:5)
1:5  # 이렇게 해도 하나의 벡터 생성됨

# 동일한 자료형만 저장할 수 있다.
class(c(1,2,3,"4"))  # 하나만 문자열이 들어가면 전체가 문자열이 된다.
class(c(1,2,3,4.5))  # numeric
class(c(1:5))   # integer

?seq
seq(1, 10, 2)  #seq(from=1, to=10, by=2)

rep(1:3, 3)  # 1부터 3까지 3번 반복
rep(1:3, each=3) # 1부터 3까지 각각 3번씩 반복

# 벡터를 이용한 처리
x <- c(1,3,5,7)
y <- c(3,5)
union(x,y)  # 벡터와 벡터 합침->새로운 벡터 (합집합)
setdiff(x,y)  # 1 7 (차집합)
intersect(x,y)  # 3 5 (교집합)
union(x,y); setdiff(x,y); intersect(x,y)  # 한번에 처리

# 벡터에 컬럼명 지정
age <- c(30,35,40)
age

names(age) <- c("홍길동", "임꺽정", "신돌석")
age  # 각각의 요소에 이름이 붙은 것 확인 가능

age <- NULL  # age가 가지고 있던 값 삭제
age

# 벡터의 접근
a <- c(1:50)
a[10:45]  # 파이썬: a[9:45]
a[10:(length(a)-5)]

v1 <- c(13,-5,20:23,12,-2:3)
v1
v1[1]
v1[c(2,4)]  # 인덱싱하기 전에 꼭 벡터 묶어줘야함함
v1[c(3:5)]  # 3에서 5까지의 위치의 값을 선택
v1[c(4, 5:8, 7)]
v1[-1]  # 제외한다는 뜻: 1번째 위치를 뺀 나머지지
v1[-c(2,4)] # 2번째, 4번째 제외


# 팩터
gender <- c("man", "woman", "woman", "man", "man")
class(gender)
plot(gender)

nGender <- as.factor(gender)  #형식변환
plot(nGender)  # 남녀 빈도수를 그래프로 나타냄(factor로 바꿔서 가능)
class(nGender)
mode(nGender)
table(nGender)  # 빈도수 or 도수분포표를 그려주는 함수
is.factor(nGender)
nGender  # Levels: man woman

?factor
# 형식뿐만이 아닌 진짜 factor로
oGender <- factor(gender, levels=c("woman", "man"), ordered=TRUE)
plot(oGender)

# matrix
m <- matrix(c(1:5))  # 열 우선 기준이다.
m

m <- matrix(c(1:11), nrow=2)  # 열 우선
m

m <- matrix(c(1:11), nrow=2, byrow=T)  # 행 우선
m
class(m)

# 행 합치기, 열 합치기
x1 <- c(5,4,50:52)
x2 <- c(30,5,6:8)
mr <- rbind(x1,x2)
class(mr)
mr
mc <- cbind(x1,x2)
mc

?matrix
m1 <-matrix(10:19, 2)
m1
class(m1)
mode(m1)

# 접근
m1[1, ]
m1[, 5]
m1[2, 3]
m1[2, 2:5]

# 처리 함수
x <- matrix(c(1:9), nrow=3, ncol=3)  # 열부터 채워짐(디폴트:열기준)
x
#      [,1] [,2] [,3]
#[1,]    1    4    7
#[2,]    2    5    8
#[3,]    3    6    9


length(x)
ncol(x); nrow(x)  # 행과 열의 개수(길이)

?apply
apply(x, 1, max)
apply(x, 2, min)
apply(x, 1, mean)

f <- function(x){
  x * c(1,2,3)   # vector끼리의 연산=각 요소별로 계산(행렬계산)
}

apply(x, 1, f)  # 계산결과는 열기준으로 출력(전치행렬)
#     [,1] [,2] [,3]]
#[1,]    1    2    3
#[2,]    8   10   12
#[3,]   21   24   27

colnames(x) <- c("one", "two", "three")
x

################# Array
vec <- c(1:12)
arr <- array(vec, c(3, 2, 2))  # 3행 2열 2면
arr

arr[,,1]
arr[,,2]
# 5라는 데이터만 뽑기
arr[,,1][2,2]
#답: 
arr[2,2,1]
# 8 데이터만 뽑기
arr[,,2][2,1]
#답:
arr[2,1,2]

################# List
# 1차원 리스트
list <- list("lee", "이순신", 95)
list
class(list)

# list를 원래대로(vector,문자열) 돌려놓기
un <- unlist(list)
un
class(un)

list <- list(id="lee", name="이순신", age=95)
list
# key로 접근1
list$id
list$name
# key값 접근2
list[[1]]
list[[2]]
# key와 value를 묶어놓은 객체에 접근
list[1]

member <- list(name=c("홍길동", "임꺽정"), age=c(35, 45),
               address=c("한양", "충남"), gender=c("남자", "여자"))
member
# 45 값에 접근
member$age[2]

# 45라는 값을 25로 수정
member$age[2] <- 25
member$age[2]

# 없는 key면 새로 만들어버림
member$id <- "hong"
member

# lapply():list로 return , sapply(): vector로 return
a <- list(c(1:5))
b <- list(6:10)

c <- lapply(c(a,b), max)  # 각 list에서의 max값
c
class(c)   # list형식

d <- sapply(c(a,b), max)
d
class(d)   # vector형식(integer)

# 다차원 리스트(중첩 리스트)
multi_list <- list(c1=list(1,2,3), c2=list(10,20,30), c3=list(100,200, 300))
multi_list  # 리스트안에 리스트..
multi_list$c1

m <- do.call(cbind, multi_list)  # 시스템이 대신 호출해서 사용
m
class(m)

############################ DataFrame
# 벡터를 이용하여 데이터프레임 생성
no <- c(1,2,3)
name <- c("hong", "lee", "kim")
pay <- c(150,250,300)

vemp <- data.frame(No=no, Name=name, Payment=pay)
vemp
class(vemp)

# 매트릭스를 이용하여 데이터프레임 생성
m <- matrix(c(1, "hong", 150, 2, "lee", 250, 3, "kim", 300), 3, by=T) #byrow
m
class(m) # matrix..

memp <-data.frame(m)
memp

# 외부 파일을 이용하여 데이터프레임 생성
#txtemp <- read.table(file="data/emp.txt", header=F, sep="")

# 현재 작업 경로 알려줌
getwd()
setwd("C:/chung/rwork/FirstProject/data/")

txtemp <- read.table("emp.txt", header = T, sep="")

txtemp
class(txtemp)

csvemp <- read.csv("emp.csv", header=T)
csvemp

# 제목이 없어서 이상하게 만들어짐(그럴땐 header=F)
csvemp2 <- read.csv("emp2.csv", header=F, col.names=c("사번", "이름", "급여"))
csvemp2

# 접근
class(csvemp2$사번)
class(csvemp2[,1])
csvemp2[2,3]
class(csvemp2[1,])
class(csvemp2[c(1,3),2])
csvemp2[-1,-2]  # 1행, 2열 제외

# 처리 함수
str(csvemp)
csvemp <- read.csv("emp.csv", header=T, stringsAsFactors = FALSE)
# name부분에서 변화가 생김 (Factor -> chr)
str(csvemp)

summary(csvemp)

# sub dataset 만들기
df <- data.frame(x=c(1:5), y=seq(2,10,2), z=c("a", "b", "c", "d", "e"))
df

apply(df[, c(1,2)],2, sum)

x1 <- subset(df, x>=3)
x1
xyand <-subset(df, x<=2 & y<=6)
xyand

height <- data.frame(id=c(1,2), h=c(180, 175))
weight <- data.frame(id=c(1,2), h=c(80, 75))
user <- merge(height, weight, by.x = "id", by.y = "id")  # by='id'
user

########################### 날짜형
d <- as.Date("19/5/6", "%y/%m/%d")
d
class(d)  # Date

dates <-c("02/28/19", "02/29/19", "03/01/19")
class(dates)
as.Date(dates, "%m/%d/%y")
class(dates)
# 해당날짜가 없을 때에 자동 결측지 NA로 변환

Sys.time()

############################ 문자열 처리
# stringr (별도 설치 필요)
#data()
#install.packages("stringr")
library(stringr)











