################# (package) plyr, dplyr, reshape, reshape2

### plyr : 두 개의 데이터 프레임을 대상으로 key값을 이용하여 하나의 패키지로 병합하거나, 집단변수를 기준으로 데이터 프레임의 변수에 함수를 적용하여 요약 집계결과를 제공하는 패키지이다.
#install.packages("plyr")
library(plyr)

# 데이터병합
x <- data.frame(id=c(1,2,3,4,5), height=c(160,171,173,162,165))
y <- data.frame(id=c(5,4,1,3,2), weight=c(55,73,60,57,80))

join <- join(x, y, by='id')
join

# x 와 y 의 id값 불일치
x <- data.frame(id=c(1,2,3,4,6), height=c(160,171,173,162,180))
y <- data.frame(id=c(5,4,1,3,2), weight=c(55,73,60,57,80))
join <- join(x, y, by='id')
# 결측치 발생(기본값으로 left join)
join

join <- join(x, y, by='id', type="full")
join

x <- data.frame(key1=c(1, 1, 2, 2, 3), key2=c('a', 'b', 'c', 'd', 'e'), val=c(10, 20, 30, 40, 50))
y <- data.frame(key1=c(3, 2, 2, 1, 1), key2=c('e', 'd', 'c', 'b', 'a'), val=c(500, 400, 300, 200, 100))

xy <- join(x, y, by=c("key1", "key2"))
xy

# 그룹별 기술 통계량 구하기: 
#tapply(): 집단변수를 대상으로 한번에 하나의 통계치를 구할 수 있다.
#ddply(): 한번에 여러 개의 통계치를 구할 수 있다.

head(iris)
unique(iris$Species)

# 꽃의 종류별로 꽃받침 길이 평균 구하기
tapply(iris$Sepal.Length, iris$Species, mean)
# 표준편차
tapply(iris$Sepal.Length, iris$Species, sd)

# 종류별 평균값, 표준편차 등
df_dd <- ddply(iris, .(Species), summarise, avg=mean(Sepal.Length), max=max(Sepal.Length), min=min(Sepal.Length))
df_dd

######################### dplyr : 데이터 프레임 형태를 보이는 정형화된 데이터를 처리하는 데에 적합한 패키지이다. (C++로 만들어진 패키지)
#install.packages(c('dplyr', 'hflights'))
library(dplyr)
library(hflights)  # 항공데이터

# tbl_df(), filter(), select(), mutate(), arrange(), summarise()

head(hflights)
str(hflights)  # 구조살펴보기기
View(hflights)  # 엑셀양식으로 테이블 만들어져서 보여줌
summary(hflights)

# 2011년도 미국 휴스턴에서 출발하는 모든 비행기의 이륙과 착륙정보를 기록
# 주요변수: Year, Month, DayofMonth, DayofWeek, AirTime, DepTime, ArrTime (년,월,일,요일 등등)
# TailNum, DepDelay, ArrDelay, Distance

hflights_df <- tbl_df(hflights)  # 너무 많은 데이터를 다 출력하지않고 예쁘게 잘 보여주는것..?
hflights_df

#filter(df, 조건1, 조건2, ...)
filter(hflights_df, Month==1 & DayofMonth==2)   # 1월 2일

# arrange(df, 컬럼1, 컬럼2, ...)
arrange(hflights_df, Year, Month, DepTime, ArrTime)  # 기본: 오름차순
arrange(hflights_df, Year, Month, desc(DepTime), ArrTime)  # 내림차순순

# select(df, 컬럼1, 컬럼2, ...) (검색기능) 

select(hflights_df, Year, Month, DepTime, ArrTime)
select(hflights_df, Year:ArrTime)  # 컬럼 범위
select(hflights_df, -(Month:DayOfWeek))  # 컬럼에서 제외하기
# cf) 행을 조정하고 싶을 땐 filter사용

# mutate(df, 컬럼명1=수식1, 컬럼명2=수식2, ...)  # 컬럼 여러개 추가시 사용
# 출발지연시간-도착지연시간 컬럼 추가 
hflights_df <- mutate(hflights_df, gain=ArrDelay-DepDelay, gain_per_hour=gain/(AirTime/60))
select(hflights_df, Year, Month, ArrDelay, DepDelay, gain , gain_per_hour)

# summarise(df, 추가할 컬럼명=함수(컬럼명), ...)
summarise(hflights_df, avgAirTime=mean(AirTime, na.rm = T))
summarise(hflights_df, cnt=n(), delay=mean(AirTime, na.rm = T))  
# n() : 빈도수 구함
# 참고: n()은 summarise(), mutate() and filter()내에서만 쓸 수 있다.


# group_by(df, 집단변수)

## 실습 (교재 6장 내용)
#install.packages("ggplot2")
library(ggplot2)
str(ggplot2::mpg)  # 콜론 2개로 .. # 자동차와 관련된 정보
mpg <- as.data.frame(ggplot2::mpg)
head(mpg)
dim(mpg)  # 차원의 크기
summary(mpg)

# 통합 연비가 계산된 파생변수 추가 (cty:도시연비, hwy:도속도로연비)
mpg$total <- (mpg$cty + mpg$hwy)/2
head(mpg)

# 배기량(displ)이 4 이하인 것만 추출
select(filter(mpg, displ<=4), model, displ, year) # but, 코드 가독성이 떨어짐
# 가독성 높이기(pipe연산자: %>%)
mpg_a <- mpg %>% filter(displ<=4) %>% select(model, displ, year)
mpg_a

# 통합연비 파생변수를 만들고 통합연비로 내림차순 정렬을 한 후에, 3개의 행만 선택해서 출력
mpg <- subset(mpg, select=-total)  # total 컬럼 빼고 나머지 컬럼들만으로 재구성한다
head(mpg)

mpg %>% 
  mutate(total=mpg$cty + mpg$hwy, mean=total/2) %>%
  arrange(desc(mean)) %>% 
  head(3)

# 회사별로 묶어서 보기
#group_by(mpg, manufacturer)
mpg %>% group_by(manufacturer) %>% 
  summarise(mean_cty= mean(cty), mean_hwy=mean(hwy)) %>%
  head(10)

mpg <- as.data.frame(ggplot2::mpg)

# 회사별로 "suv"자동차의 도시 및 고속도로 통합 연비 평균을 구해 내림차순으로 정렬하고 1위~5위까지만 출력
mpg %>% 
  group_by(manufacturer) %>% 
  filter(class=='suv') %>%
  mutate(tot=cty + hwy) %>%
  summarise(mean_tot=mean(tot)) %>%
  arrange(desc(mean_tot)) %>%
  head(5)

# 어떤 회사 자동차의 hwy가 가장 높은지 알아보려고 한다. hwy평균이 가장 높은 회사 3곳을 출력하시오.
mpg %>%
  group_by(manufacturer) %>% 
  summarise(mean_hwy=mean(hwy)) %>%    # mutate말고 summarise를 써야 회사별로 볼 수 있다.
  arrange(desc(mean_hwy)) %>%
  head(3)

# 어떤 회사에서 compact(경차) 차종을 가장 많이 생산하는지 알아보려고 한다. 각 회사별 "compact"차종 수를 내림차순으로 정렬해 출력하시오.
mpg %>%
  group_by(manufacturer) %>%
  filter(class=='compact') %>%
  summarise(cnt=n()) %>%
  arrange(desc(cnt))

select(mpg, manufacturer, fl)

# 연료정보 dataframe으로 따로 저장
# c:CNG, d:Diresel, e:ethanol E85, p:Premium, r:Regular
fuel <- data.frame(fl = c('c','d','e','p','r'),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel

# fuel 테이블을 mpg테이블에 병합
?left_join
mpg <- left_join(mpg, fuel, by='fl')
head(mpg)


# 미국 동부중부 437개 지역의 인구 통계 정보를 담은 midwest샘플이다.
midwest <- as.data.frame(ggplot2::midwest)
head(midwest)  # 컬럼 28개..
str(midwest)

# 전체 인구대비 미성년 인구 백분율 변수를 추가 (ratio_child)
midwest$ratio_child <- ((midwest$poptotal- midwest$popadults)/midwest$poptotal)*100
# midwest <- midwest %>%
#    mutate(ratio_child=(poptotal-popadults)/poptotal*100)
select(midwest, county, state, ratio_child)

# 미성년 인구 백분율이 가장 높은 상위 5개 지역의 미성년 인구 백분율을 출력
midwest %>%
  arrange(desc(ratio_child)) %>%    # 내림차순 정렬
  select(county, ratio_child) %>%
  head(5)

# 분류표의 기준에 따라 미성년 비율 등급 변수를 추가하고, 각 등급에 몇 개의 지역이 있는지 알아보기 (미성년 인구 백분율이 40이상이면 'large', 30이상이면 'middle', 그렇지 않으면 'small')
# -> 양적데이터의 범주화
midwest <- midwest %>%
  mutate(grade= ifelse(ratio_child>=40, 'large',
                       ifelse(ratio_child>=30, 'middle', 'small')))

#select(midwest, county, grade)
table(midwest$grade)  # 빈도수확인: large:32, middle:396, small:9

# 전체 인구 대비 아시아인 인구 백분율(ratio_asian) 변수를 추가하고 하위 10개 지역의 state, county, 아시아인 인구 백분율을 출력
midwest$ratio_asian <- ((midwest$popasian)/midwest$poptotal)*100
# midwest %>% mutate(ratio_asian=(popasian/poptotal)*100) 
midwest %>%
  arrange(ratio_asian) %>%  #오름차순
  select(state, county, ratio_asian) %>%
  head(10)

######################### reshape
# 데이터셋의 구성이 구분변수에 의해서 특정 변수가 분류된 경우 데이터셋의 모양을 변경하는 패키지
# 구분변수(indentifier variable): 데이터셋에서 1개 이상으로 분류되는 집단 변수
# 측정변수(measured variable): 구분변수에 의해서 구분되는 변수
# 시놀로지챗방 파일(reshape.csv) 다운로드

#install.packages("reshape")
library(reshape)

result <- read.csv("C:/chung/rwork/FirstProject/data/reshape.csv", header=F)
head(result)

# 컬럼명 변경 : rename()
result <- rename(result, c(V1='total', V2='num1', V3='num2', V4='num3'))
head(result)

# 긴 형식(기준변수와 관련변수의 1:1대응)을 넓은 형식(1:N)으로 변경
?reshape
# varying="반복되는 측정 색인"
# v.names="반복되는 측정값"
# timevar="반복되는 측정 시간"
# idvar="1개 이상의 값으로 분류되는 변수"  기준변수?
# direction="wide | long"

data("Indometh")
str(Indometh)

# 항염증제에 대한 약물동태학에 관한 데이터셋으로 생체 내에 있어서 약물의 흡수, 분포, 비축, 대사, 배설의 과정을 연구하는 학문
# 주요변수: Subject(실험대상), time(약투여시간(단위:hr)), conc(농도)

Indometh   # 긴 형식

# 넓은 형식으로 변환
wide <- reshape(Indometh, idvar="Subject", timevar = "time", 
                v.names = "conc", direction = "wide")
wide

# 긴 형식으로 되돌리기
reshape(wide, direction = "long")

long <- reshape(wide, idvar="Subject", v.names="conc",
                varying = 2:12, direction = "long")   # 2:12 = subject와 index조합
long
str(long)  # 구조확인

# melt(data, id="기준변수", measured="측정변수")
smiths  # reshape 패키지 샘플

# 아래 셋의 결과 모두 동일 (기준변수에 따라 구조가 바뀌는것)
smithm <- melt(smiths, id=c('subject', 'time'))  # 자연스럽게 구조를 변경해줌
smithm1 <- melt(smiths, id=c('subject', 'time'), measured=c("age"))
smithm2 <- melt(smiths, id=c('subject', 'time'), measured=c("age", "weight", "height"))

# cast
?cast
# data : melt()에 의해서 생성된 데이터셋
# fomular : (열변수 + 열변수 ... ~ 행변수 + 행변수 +...)
# variable : 측정변수
# fun.aggregate : 집합함수

# 기본자체가 wide형이라 아래 셋 모두 구조의 차이점이 없다
cast(smithm, subject + time ~ variable)
cast(smithm1, subject + time ~ variable)
cast(smithm2, subject + time ~ variable)

long <- melt(Indometh, id=c('Subject', 'time'))
long

cast(long, Subject + time ~ variable, sum)

########################## reshape2 패키지 : melt(), acast(), dcast()
# 시놀로지챗방 (data.csv) 파일 다운로드
#install.packages('reshape2')
library(reshape2)

data <- read.csv('C:/chung/rwork/FirstProject/data/data.csv')
data

# dcast() : 넓은 형식
wide <- dcast(data, Customer_ID ~ Date, sum)  #측정변수:Date(날짜별로 펼칠것)
wide
colnames(wide) <- c('Customer_ID', 'day1', 'day2', 'day3', 'day4', 'day5', 'day6', 'day7')
wide

# 넓은형식을 긴 형식으로: melt()
long <- melt(wide, id='Customer_ID')
long

# acast() : 3차원 구조변경
data('airquality')
airquality

# Newyork의 대기질을 측정한 데이터셋

air_melt <- melt(airquality, id=c('Month', 'Day'), na.rm = T)
head(air_melt)

# 3차원으로 변형
acast <- acast(air_melt, Day ~ Month ~ variable)   # 행,열,면
acast

acast(air_melt, Month~variable, sum, margins=T)  # margins=T 전체 행,열의 합계 보여줌


