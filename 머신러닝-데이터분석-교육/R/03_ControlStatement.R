############################ 조건문
# if(), ifelse()
x <- 2
y <- 3
z <- x*y

if(x*y >=40){
  cat("x*y의 결과는 40 이상입니다.\n")
  cat("x*y=", z)
}else{                            # else문 이어줘야함
  cat("x*y의 결과는 40미만입니다.\n")
}

score = scan()
if(score>=90){
  result = "A 학점"
}else if(score>=80){
  result = "B 학점"
}else if(score>=70){
  result = "C 학점"
}else if(score>=60){
  result = "D 학점"
}else{
  result = "F 학점"
}
cat("당신의 학점은", result)

score <- scan()
# 주석처리: ctrl+shift+c
# if (score>=80){
#   cat("우수")
# }else{
#   cat("노력")
# }

# 조건문 간단하게 만들기
ifelse(score>=80, "우수","노력")

# switch
# switch("name") <- 비교할 대상 변수
empname <- scan(what="")
switch(empname, id="hong", pwd="1111", age=10, name="홍길동")

# which() : 벡터 객체를 대상으로 특정 데이터를 검색하는데에 사용되는 함수
name <- c("kim", "lee", "choi", "park")
which(name=="choi")  # 3 (3번째에 위치해있다)
which(name=="song")  # integer(0)

no <- c(1:5)
name <- c("유비", "관우", "장비", "손권", "조자룡")
score <- c(85, 90, 60, 88, 78)
exam <- data.frame(학번=no, 이름=name, 성적=score)
exam

result <- which(exam$이름 == "장비")
result
exam[result, ]

############################ 반복문
i <- c(1:10)
for(n in i){
  cat(n*10)
  cat(n)
}

for(n in i){
  if(n %% 2 ==0){
   next    # python의 continue와 유사한 기능 
  }else{
    print(n)
  }
}

i <- 0
while(i < 10){
  i <- i + 1
  print(i)
}

###################### 사용자 정의 함수
f1 <- function(){
  cat("매개변수가 없는 함수")
}

f1()

f2 <- function(x){
  cat("x의 값 : ", x)
}

f2(10)

f3 <- function(x, ...){    # 첫번째 값은 첫번째 인수에 전달
  args <- list(...)
  for(n in args){
    print(n)
  }
}

f3(10,20,30)
f3('홍길동', '임꺽정')


f4 <- function(x, y){
  add <- x + y
  return(add)
}

result= f4(10,20)
result

############################### 기술통계량을 계산하는 함수 정의
# 시험에 나온다!(중요)
test <- read.csv("C:/chung/rwork/FirstProject/data/test.csv", header=T)
head(test)

summary(test)

# 빈도표
table(test$A)

# 한 번의 함수 호출로 다수의 컬럼에 대한 통계량을 계산하는 기능
# 각 컬럼 단위로 빈도와 최대값/최소값 계산 함수 정의

# data_pro라는 이름의 for문을 가진 함수 만들기
data_pro <- function(df){
  for(idx in 1:length(df)){
    cat(idx, "번째 컬럼의 빈도분석 결과")
    print(table(df[idx]))
    cat("\n")
  }
  
  for(idx in 1:length(df)){
    f <- table(df[idx])
    cat(idx, "번째 컬럼의 최대최소분석 결과")
    cat("max=", max(f), "min=", min(f), "\n")
  }
}

# data_pro함수 test에 적용
data_pro(test)

# 결측치 처리 함수
# 결측치 처리 전과 후를 비교하는 함수
data <- c(10, 20, 5, 4, 40, 7, NA, 6, 3, NA, 2, NA)

na <- function(vec){
  # 1차: 결측치를 제거하고 평균 계산
  print(vec)
  print(mean(vec, na.rm=T))  # rm: remove?
  
  # 2차: 결측치를 0으로 대체하고 평균 계산
  data <- ifelse(!is.na(vec), vec, 0)  # vec값이 na가 아니라면 vec값 출력하고, na라면 0
  print(data)
  print(mean(data))
  
  # 3차: 결측치를 평균으로 대체하고 평균 계산 (대체할 평균값:10.78)
  data2 <- ifelse(!is.na(vec), vec, round(mean(vec, na.rm = T),2))
  print(data2)
  print(mean(data2))
}

na(data)

# 기술통계량 처리 관련 내장함수
# min()
# max() 
# range() : 벡터를 대상으로 범위값을 구하는 함수(최대값 ~ 최소값)
# mean()
# median()
# sum()
# sort() : 벡터 데이터를 정렬(단, 원래의 값은 변경되지 않는다, 원본 미훼손)
# order(): 정렬된 값의 인덱스를 보여주는 함수
# rank() 
# sd()  
# summary()
# table()
# sample(x, y) : x 범위에서 y만큼 sample 데이터를 생성하는 함수

#################### 전처리 준비






























































