################ 데이터 전처리 유형

# 데이터셋 조회 및 파악하기
dataset <- read.csv('C:/chung/rwork/FirstProject/data/dataset.csv', header = T)
View(dataset)  
# resident(명목) gender(명목) job(명목) age position(명목) price survey(명목) -> 직장인 조사??
head(dataset)
str(dataset)

# resident : 1~5까지의 값을 가지는 명목변수로 거주시를 나타낸다.
# gender : 1~2까지의 값을 가지는 명목변수로 성별(남/여)을 나타낸다.
# job : 1~3까지의 값을 가지는 명목변수로 직업을 나타낸다.
# age : 양적변수(연속변수,비율변수) : 2~69
# position : 1~5까지의 값을 가지는 명목변수(서열)로 직위를 나타낸다.
# price : 양적변수(비율) : 2.1~7.9
# survey : 만족도 조사 : 1~5 (매우만족~매우불만족) : 명목변수(등간)

# 산포도 그리기
x <- dataset$age
y <- dataset$price

plot(x, y)

# 교재 6장의 그래프 따라 그려보기

attach(dataset)  # dataset을 메모리에 올려놓고 사용 -> dataset$ 이런식으로 접근 안해도 된다
#detach(dataset)  # 원상태로 돌림(떼어내기)
### 결측치

# 결측치 확인 방법
#summary(dataset$price)
summary(price)  # 30개의 결측치 확인(NA's)

# 결측치 제거
?sum
sum(price, na.rm = T)  # na.rm이 어디에서나 쓸 수 있는 인자가 아니기 때문에 함수의 docu에서 사전 확인을 해야한다.

# na.rm 인자 없을 경우
price2 <- na.omit(price)
sum(price2)

# 결측치 대체
price[1:30]  # NA
price2 <- ifelse(!is.na(price), price, 0)   # 결측치 인지 아닌지
price2
price2[1:30]  # 0.0

# 결측치를 평균값으로 대체
price3 <- ifelse(!is.na(price), price, round(mean(price, na.rm = T), 2))
price3[1:30]  # 8.75

### 이상치(극단치)
# 양적이냐, 질적이냐에 따라 방식이 달라질 수 있다

# 질적 자료에서의 이상치 처리
table(dataset$gender)
pie(table(dataset$gender))

dataset <- subset(dataset, gender==1 | gender==2)  #subset: 조건에 만족하는 데이터만 추출
table(dataset$gender)
pie(table(dataset$gender))

# 양적 자료에서의 이상치 처리
dataset <- read.csv('C:/chung/rwork/FirstProject/data/dataset.csv', header = T)
length(dataset$price)
# 양적 변수에서는 이상치를 쉽게 삭제, 제거하지 말 것! (명목변수에서는 의미없겠지만 양적변수에서는 의미있는 값 일 수 있다!)

plot(dataset$price)
boxplot(dataset$price)

summary(dataset$price)

dataset2 <- subset(dataset, price>=2 & price<=8)
length(dataset2$price)  # 300->251

plot(dataset2$price)
boxplot(dataset2$price)
stem(dataset2$price)  # 줄기잎그래프: text형태로 그래프 그려짐, 빈도수
# 2.1 2.3 2.3 ..???
# 3.5 3.5 3.5 3.5 .... 각각의 데이터가 몇개인지 세부적으로 확인 가능

# age의 극단치 정제(20~69)

### 코딩 변경

# 가독성을 위한 코딩 변경
view(dataset)

dataset2$resident2[dataset2$resident==1] <- '1.서울특별시'
dataset2$resident2[dataset2$resident==2] <- '2.인천광역시'
dataset2$resident2[dataset2$resident==3] <- '3.대전광역시'
dataset2$resident2[dataset2$resident==4] <- '4.대구광역시'
dataset2$resident2[dataset2$resident==5] <- '5.시구군'

View(dataset2)

# 척도 변경을 위한 코드 변경
# (분석을 어떻게 하느냐에 따라 그 범주를 변경해야할 경우가 많다)
# 나이변수를 청년층, 중년층, 장년층으로 척도 변경
dataset2$age2[dataset2$age <=30] <- '청년층'
dataset2$age2[dataset2$age >30 & dataset2$age <=55] <- '중년층'
dataset2$age2[dataset2$age >55] <- '장년층'
View(dataset2)

# 역코딩을 위한 코드 변경
survey <- dataset2$survey
csurvey <- 6-survey  #(1~5:매우만족~매우불만족 -> 역순으로 바꾸기)
dataset2$survey <- csurvey
head(dataset2)

# 동시에 여러 그래프를 그려서 비교
### 탐색적 분석을 위한 시각화 (ggplot, ggmap, lattice..)
new_data <- read.csv('C:/chung/rwork/FirstProject/data/new_data.csv', header = T)
str(new_data)

# 범주형 vs 범주형
###################
# 성별에 따른 거주지역의 분표 현황
table(new_data$resident2, new_data$gender2)
resident_gender <- table(new_data$resident2, new_data$gender2)

barplot(resident_gender, col = rainbow(5), legend=row.names(resident_gender), beside=T, horiz=T,
        main='성별에 따른 거주지역의 분포 현황')  
# legend=범례


# 연속형 vs 범주형
######################
# 직업유형에 따른 나이 분포 현황

#install.packages("lattice")
library(lattice)

?densityplot  # 확률밀도
densityplot(~age, data=new_data, groups=job2, auto.key=T)  # job2에 따라 그래프... n개 그려지고..그럼..

# 연속형 vs 범주형 vs 범주형
#############################
# 성별에 따른 직급별 구매 비용 분석
densityplot(~ price | factor(gender2), data=new_data, groups=position2, auto.key=T)  # 첫번째 인자 x 는 formula method를 쓰도록 지정되어 있음

# 직급에 따른 성별 구매비용 분석
densityplot(~ price | factor(position2), data=new_data, groups=gender2, auto.key=T)

# 연속형(2개) vs 범주형(1개)
##############################
# 성별로 구매비용과 나이의 분포형태
xyplot(price ~ age | factor(gender2), data=new_data)  # x인자, formulat method
?xyplot

### 파생변수

# user_data
  # 거주유형: 단독주택(1), 다가구주택(2), 아파트(3), 오피스텔(4)
  # 직업유형: 자영업(1), 사무직(2), 서비스(3), 전문직(4), 기타
user_data <- read.csv('C:/chung/rwork/FirstProject/data/user_data.csv', header = T)

# pay_data
  # 상품유형: 식료품(1), 생필품(2), 의류(3), 잡화(4), 기타(5)
  # 지불방법: 현금(1), 직불카드(2), 신용카드(3), 상품권(4)
pay_data <- read.csv('C:/chung/rwork/FirstProject/data/pay_data.csv', header = T)

# return_data
  # 반품코드: 제품이상(1), 변심(2), 원인불명(3), 기타(4)
return_data <- read.csv('C:/chung/rwork/FirstProject/data/return_data.csv', header = T)

# 더미 변수
table(user_data$house_type)

house_type2 <- ifelse(user_data$house_type==1 | user_data$house_type==2, 0, 1)  # 1,2는 0, 3,4는 1로
user_data$house_type2 <- house_type2
head(user_data)


head(pay_data)
# 빈도수 확인
table(pay_data$product_type)

library(reshape2)
?dcast
product_price <- dcast(pay_data, user_id ~ product_type, sum, na.rm=T)
head(product_price)  

names(product_price) <- c('user_id', '식료품(1)', '생필품(2)', '의류(3)', '잡화(4)', 
                          '기타(5)')  
head(product_price)  

# join으로 파생변수 합치기
library("plyr")

user_pay_data  <- join(user_data, product_price, by='user_id')
head(user_pay_data)  

# 지불방법도 wide하게 변형해서 추가
pay_method2 <- dcast(pay_data, user_id ~ pay_method, sum, na.rm=T) 
head(pay_method2)  

user_pay_data2 <- join(user_pay_data, pay_method2, by='user_id')
head(user_pay_data2)


# 고객별 상품유형에 따른 구매금액 합계 파생변수 생성
product_price <- dcast(pay_data, user_id ~ product_type, sum, na.rm=T)
head(product_price)

# 총 구매금액 파생변수 생성
# user_pay_data$total_price <- user_pay_data$pay_method
# head(user_pay_data)
# https://dbrang.tistory.com/1051
  
### 표본 추출
data <- read.csv('C:/chung/rwork/FirstProject/data/cleanData.csv', header = T)
head(data)

nrow(data)  # 400  행의 갯수만 필요할 때
ncol(data)  # 16   열의 갯수만 필요할 때

#sample함수(머신러닝에서 많이 활용)
choice1 <- sample(nrow(data), 30)  # 400개의 data에서 30개를 무작위로 추출
data[choice1,]

sample(c(50:100), 30)
sample(c(10:50, 80:150, 160:190), 30)

#iris
data(iris)
head(iris)

# 훈련용과 테스트용을 7:3으로
idx <- sample(1:nrow(iris), nrow(iris)*0.7)
training <- iris[idx, ]
testing <- iris[-idx, ]
head(training)
head(testing)

# 훈련용 데이터에 K-Folding cross validation(교차검정) 많이 쓰임 : 교재 p.456
name <- c('a', 'b', 'c', 'd', 'e', 'f')
score <- c(90, 85, 99, 75, 65, 88)
df <- data.frame(Name=name, Score=score)

#교재 p.460~
#install.packages("cvTools")
library(cvTools)

cross <- cvFolds(n=6, K=3, R=1, type="random")
cross

# K=1 : (6, 4), (1, 2, 3, 5)
# K=2 : (2, 5), (1, 3, 4, 6)
# K=3 : (3, 1), (2, 4, 5, 6)

cross$which
cross$subsets
cross$subsets[cross$which==1, 1]  #which==1의 1번째열
cross$subsets[cross$which==2, 1]
cross$subsets[cross$which==3, 1]

r=1
K=1:3
for(kfold in K){
  data_idx <- cross$subsets[cross$which==kfold, r]
  cat("K=", kfold, '검정데이터 \n')
  print(df[data_idx, ])
  
  cat('훈련 데이터\n')
  print(df[-data_idx, ])
}

# dplyr 같은 경우..? filter로 결측치빼고 불러오는.. %>% ,,, 명령어를 간단,단순하게 사용

