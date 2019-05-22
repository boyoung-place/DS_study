# T-test는 3개로 넘어가면 잘 안쓴다.
# T-test를 쓰기 위해서 
# 1. T-test(), student t-test, independnt t-test
# 2. Mann_whitney U test, Wilcoxon rank-sum test, Mann-Whitney-Willcoxon test(MWW)
# 3. Welch's t-test

# 어떤 기준으로 위 3가지 중에 하나를 선택하는지
# 결과값이 연속변수가 아니라면 MWW(비모수적) 방법 사용
# 정규분포가 아니라면 MWW 방법 사용
# 등분산이 아니라면 Welch's t-test 사용
# 이 3가지 조건을 만족하면 t-test 사용
# (참고) 모수적 통계방식 / 비모수적 통계방식

install.packages('moonBook')
library(moonBook)
data(acs)
# 경기도에 소재한 한 대학병원에서 2년동안 내원한 관상동맥증후군 환자들에 대한 자료
?acs
head(acs)
str(acs)


# 남성vs여성 : 전형적인 독립표본, 남성과 여성의 나이 차
mean.man <- mean(acs$age[acs$sex=='Male'])    # 60.61
mean.woman <- mean(acs$age[acs$sex=='Female'])  # 68.68

# 이 평균의 차이가 의미가 있는지 -> t-test -> 2번째 알고리즘
# 1. 결과값 연속변수 = 나이
# 2. 정규분포?
# 교재 p.336 샤피로 윌크 검정( 정규분포 테스트)
shapiro.test(acs$age[acs$sex=='Male']) # p-value = 0.2098 -> 정규분포 맞음
shapiro.test(acs$age[acs$sex=='Female'])  # p-value = 6.34e-07(숫자매우작음) -> 정규분포 아님
# -> t-test쓸 수 없다! (두 그룹의 정규분포성이 다름)

moonBook::densityplot(age~sex, data = acs) # 그래프로도 정규분포성 확인

# 두번째 알고리즘 사용(Mann_whitney U test, Wilcoxon rank-sum test, Mann-Whitney-Willcoxon test(MWW))
wilcox.test(age~sex, data=acs)  # p-value < 2.2e-16  -> 남녀나이 차의 평균에 충분한 차이가 있다.


# (정규분포가 맞다고 가정을 하고) 등분산 검정 : 서로다른 집단의 분산이 같은지 확인
var.test(age~sex, data=acs)  # p-value = 0.3866  -> 귀무가설 채택(분산은 같다)
# -> t-test 사용
?t.test
t.test(age~sex, data=acs, var.equal=T) # p-value < 2.2e-16 -> 귀무가설 기각(차이가 있다)

# welch's test (등분산이 서로 다르다고 가정하고 하는 t-test)
t.test(age~sex, data=acs, var.equal=F) # p-value < 2.2e-16

######################################
### 몇 가지 사례들

# 집단이 한 개일 경우 (-> 모수와 비교)
#-------------------------------------
# A회사의 건전지 수명이 1000시간일 때 무작위로 뽑은 10개의 건전지 수명에 대해 샘플이 모집단과 다르다고 할 수 있는가?

a <- c(980, 1008, 968, 1032, 1012, 1002, 996, 1017)
mean(a)  # 1001.875

shapiro.test(a) # p-value = 0.9469 -> 정규분포가 맞다
# (명제)귀무가설: 표본집단의 평균이 모집단의 평균과 같다.
# 연구 가설: 표본집단의 평균이 모집단의 평균과 다르다.
t.test(a, mu=1000, alternative="two.sided") # p-value = 0.8032 -> 모집단의 평균과 같다.

# 어떤 학급의 수학 평균 성적이 55점이다. 0교시 수업을 시행하고 나서 학생들의 성적을 살펴보았다. 

a <- c(58, 49, 39, 99, 32, 88, 62, 30, 55, 65, 44, 55, 57, 53, 88, 42, 39)

# 귀무가설 : 0교시 수업 시행 후 학생들의 성적은 오르지 않았다. 
# 연구가설 : 0교시 수업 시행 후 학생들의 성적은 올랐다.

shapiro.test(a) # p-value = 0.1058 -> 정규분포 맞음
mean(a)
?t.test
t.test(a, mu=55, alternative="greater") # p-value = 0.4046 -> 모집단의 평균과 같다.?
# 0교시 수업 진행 안하는걸로... 변화가 없으니까

# 아래 20개의 도시는 우리나라 76개의 자치도시 중에 20개만 뽑은 것이다.
# 귀무 가설 : 20개 도시의 합계 출산율은 모집단의 합계출산율과 차이가 없다.
# 대립 가설 : 20개 도시의 합계 출산율이 모집단의 합계 출산율과 다르다.
# 모집단의 평균값 : 1.37812

getwd()
b <- read.csv("C:/chung/rwork/SecondProject/data/onesample.csv", header = T, sep=",")
head(b)
str(b)
shapiro.test(b$birth_rate) #p-value = 0.1538 -> 정규분포 맞음
sum(b$birth_rate)  # 24.923
t.test(b$birth_rate, mu=1.37812, alternative = "two.sided")  #p-value = 0.0001791 -> 귀무가설 기각 -> 대립가설 채택

##### 독립표본 샘플
c <- read.csv("C:/chung/rwork/SecondProject/data/independent.csv", header = T, sep = ",")
View(c)

gun.mean <- mean(c$birth_rate[c$dummy==0])  # 1.47216
si.mean <- mean(c$birth_rate[c$dummy==1])  #1.37812

# dummy라는 컬럼은 0은 군, 1은 시를 나타내는 컬럼이다.
# 시와 군에 따라 합계 출산율의 차이가 있는지 없는지를 보려고 한다.
# 귀무 가설 : 차이가 없다.
# 연구 가설 : 차이가 있다.

shapiro.test(c$birth_rate[c$dummy==0]) # p-value = 0.009702 -> 정규분포x
shapiro.test(c$birth_rate[c$dummy==1]) # p-value = 0.001476 -> 정규분포x

wilcox.test(c$birth_rate~ c$dummy, data=c) 
# p-value = 0.04152 -> 귀무가설 기각 -> 연구 가설 채택(차이가 있다.)

# mtcars 문제..??
str(mtcars)  # 32obs, 11variables
head(mtcars)
# am : 0=auto(자동), 1=수동

a_mpg <- mean(mtcars$mpg[mtcars$am == 0])
m_mpg <- mean(mtcars$mpg[mtcars$am == 1])

# 정규분포 확인
shapiro.test(mtcars$mpg[mtcars$am == 0]) # p-value = 0.8987 -> 정규분포
shapiro.test(mtcars$mpg[mtcars$am == 1]) # p-value = 0.5363 -> 정규분포

# 등분산
var.test(mtcars[mtcars$am==1, 1], mtcars[mtcars$am==0, 1]) #p-value = 0.06691 -> 만족
# 1,1 (행,렬)

# t 테스트
# t.test(mtcars$mpg[mtcars$am == 0], mu=m_mpg) #p-value = 1.613e-07 -> 귀무가설 기각
t.test(mpg~am, data=mtcars, var.equal=T, conf.level=0.95) # p-value = 0.000285 -> 귀무가설 기각

################################################################################
###### Paired Samples T-Test
# (참고) t-test(student t) : 1. 연속변수 2. 정규분포 -> 아니면, MWW  3.등분산 -> 아니면, welch's

# 정규분포가 아니거나 서열변수 : Willcoxon signed rank test
# Willcoxon matched paires rank test, Wilcoxon t-test, Wilcoxon test
# 표본의 갯수가 반드시 같아야 한다.
?t.test #Student's t-Test
getwd()
# 쥐에게 약투어 전 후 몸무게
pd <- read.csv("C:/chung/rwork/SecondProject/data/pairedData.csv", header=T)
pd   
# Paired test 전, 데이터 정제
# data wide형, long형 이용
library(reshape2)
melt(pd, id='ID', variable.name="GROUP", value.name="RESULT")

install.packages('tidyr')
library(tidyr)
# melt보다 좀 더 직관적으로 사용할 수 있는  함수
?gather
pd2 <- gather(pd, key='GROUP', value='RESULT', -ID)
# 정규분포인지 확인
# 방법1
shapiro.test(pd2$RESULT[pd2$GROUP=='before']) #p-value = 0.2768 -> 정규분포
shapiro.test(pd2$RESULT[pd2$GROUP=='After'])  #p-value = 0.2894 -> 정규분포

# 방법2
d <- pd2$RESULT[pd2$GROUP=='before'] - pd2$RESULT[pd2$GROUP=='After']
shapiro.test(d)  # p-value = 0.6141 -> 정규분포

install.packages('PairedData')
library(PairedData)

# 2개의 시점을 그래프로 (after / before)
before <- subset(pd2, GROUP=='before', RESULT, drop = T) # drop: 짝이 안맞는경우 버리기기
after <- subset(pd2, GROUP=='After', RESULT, drop = T)

pd3 <- paired(before, after)
class(pd3)
plot(pd3, type='profile') + theme_bw()

t.test(RESULT~GROUP, data=pd2, paired=T) #p-value = 6.2e-09

############## Paired Samples T- Test가 정규분포가 아니거나 서열변수인 경우
data(sleep)
head(sleep)
View(sleep)

shapiro.test(sleep$extra[sleep$group==2] - sleep$extra[sleep$group==1]) # p-value = 0.03334 -> 정규분포 아니다
# 데이터 이름을 생략하고 사용할 수 있게 해줌 : with
with(sleep, shapiro.test(extra[group==2] - extra[group==1]))

group_1 <- subset(sleep, group==1, extra, drop = T)
group_2 <- subset(sleep, group==2, extra, ddrop = T)

sleep_test <- paired(group_1, group_2)
plot(sleep_test, type='profile') + theme_bw()

# Wilcoxon test
?wilcox.test
with(sleep, wilcox.test(extra[group==2] - extra[group==1], exact = F)) #p-value = 0.009091 ->귀무가설 기각
# 순위가 같은 값일 경우에 계산을 못함... -> Warning messages -> exact=F 설정


### 또다른 사례

e1 <- read.csv("C:/chung/rwork/SecondProject/data/paired.csv", header=T)
head(e1)
str(e1)
View(e1)

e2 <- gather(e1, key='GROUP', value='RESULT', -c(ID, cities))
head(e2)
with(e2, shapiro.test(RESULT[GROUP=='birth_rate_2015'] - RESULT[GROUP=='birth_rate_2010']))
# p-value = 0.3839 -> 정규분포

with(e2, t.test(RESULT[GROUP=='birth_rate_2015'] - RESULT[GROUP=='birth_rate_2010']), paired=T)
# p-value = 0.5055 -> 2010년과 2015년 출산율의 유의한 차이가 없다.
# !주의! 대응표본의 경우 반드시 표본의 갯수가 반드시 같아야 함

# 등분산 test
with(e2, var.test(RESULT[GROUP=='birth_rate_2015'], RESULT[GROUP=='birth_rate_2010']))
# p-value = 0.7058  -> 유의한 차이가 없다.

