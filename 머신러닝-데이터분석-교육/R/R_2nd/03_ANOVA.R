# 조건 : 5% 유의수준
# 연속변수 : kruskal-wallis H test
# 정규분포 : kruskal-wallis H test
# 등분산 : (분산이 같지 않을 때)welch's ANOVA
# ANOVA 사용
# Tukey
#install.packages('moonBook')
library(moonBook)
View(acs)
str(acs$Dx)
# Dx(진단 결과) : STEMI, NSTEMI, Unstable Angina을 LDLC(저밀도 콜레스테롤)와 비교

# step1) LDLC는 연속변수? Y
# step2) 정규분포?
shapiro.test(acs$LDLC[acs$Dx=='STEMI'])  # p-value = 0.6066  -> 정규분포
shapiro.test(acs$LDLC[acs$Dx=='NSTEMI'])  # p-value = 1.56e-08  -> 정규분포 x
shapiro.test(acs$LDLC[acs$Dx=='Unstable Angina'])  # p-value = 2.136e-07 -> 정규분포 x
densityplot(LDLC ~ Dx, data=acs)

# ANOVA 함수 사용: aov
out <- aov(LDLC ~ Dx, data =acs)
shapiro.test(resid(out)) #p-value = 1.024e-11 -> 정규분포 아님  #resid: 잔차(residual)

# step3) 등분산? : ANOVA에선 bartlett.test() -> t-test의 경우에는 var.test()
bartlett.test(LDLC~Dx, data=acs) #p-value = 0.1857 >0.05

# (연속변수, 정규분포, 등분산 충족한다고 가정) anova 사용
out <- aov(LDLC ~ Dx, data =acs)
summary(out)  # Pr(>F) 0.00377  -> 혈중 LDLC 수치에 차이가 있다. (5% 유의수준)

# kruskal-wallis H test
kruskal.test(LDLC ~ factor(Dx), data =acs)  # p-value = 0.004669 -> 혈중 LDLC 평균에 차이가 있다.
class(acs$Dx)
?kruskal.test

# Welch's anova 사용
oneway.test(LDLC ~ Dx, data=acs, var.equal = F)  # aov와 유사한 함수
# p-value = 0.007471 -> 귀무가설 기각 -> 차이가 있다.

############## 사후검정

# anova를 사용했을 경우
TukeyHSD(out)  # Unstable Angina-NSTEMI : p abj = 0.0024227 로 인해 귀무가설이 기각된 것

# welch's anova를 사용했을 경우 (tukey와 결과 동일)
install.packages('nparcomp')
library(nparcomp)
result <- mctp(LDLC ~ Dx, data=acs)
summary(result)  # Unstable Angina - NSTEMI 의 p.value=0.002964189 -> 귀무가설 기각

# kruskal wallice h test를 사용했을 경우
install.packages('userfriendlyscience')
library(userfriendlyscience)
?posthocTGH # 이걸로 p value 안구해짐..

data("InsectSprays")
View(InsectSprays)  # 어떤 스프레이를 썼을 때 벌레가 몇마리나 박멸 되었는지
table(InsectSprays$spray)  # 표본의 갯수가 동일함을 확인
densityplot(count~spray, data=InsectSprays)

# method=c("games-howell", "tukey")
posthocTGH(x=InsectSprays$spray, y= InsectSprays$count, method = 'games-howell')

######################################
data("iris")
head(iris)
table(iris$Species)  # setossa / versicolor / virginica 각각 50개씩
densityplot(Sepal.Width~Species, data=iris)

# formula 이해하기
#install.packages("doBy")
library(doBy)
?summaryBy # Function to calculate groupwise summary statistics
summaryBy(Sepal.Width + Sepal.Length ~ Species, iris)
# ‘Sepal.Length + Sepal.Length ~ Species’ 
# Sepal.Width와 Sepal.Length를 +로 연결해 이 두 가지에 대한 값을 결과에 각 컬럼으로 놓고, 각 행에는 ~ Species를 사용해 Species를 놓았다. 즉, 위 결과는 Sepal.Width와 Sepal.Length를 Species별로 요약한 것이다.


# 귀무가설: iris의 Sepal.Width는 Species에 따라 차이가 없다.
# 연구가설: iris의 Sepal.Width는 Species에 따라 차이가 있다.

# anova에 넣어서 한번에 샤피로(shapiro) 데스트
out <- aov(Sepal.Width ~ Species, data =iris)
shapiro.test(resid(out))  # p-value = 0.323 -> 정규분포

# 등분산
bartlett.test(Sepal.Width ~ Species, data =iris)  # p-value = 0.3515 -> 등분산 만족

# anova 정리로 결론 내리기
summary(out) # Pr(>f) = <2e-16  -> 귀무가설 기각  sepal.width의 평균에 차이가 있다

# 사후검정
TukeyHSD(out) # 세가지 모두 서로 차이 존재.. 
# 결론: iris의 Sepal.Width는 Species에 따라 차이가 있다. (연구가설 채택)


### One way ANOVA 예제
# 시, 군, 구(ad_layer)에 따라서 합계 출산율의 차이 검증
mydata <- read.csv('data/anova_one_way.csv')
View(mydata)
str(mydata)
head(mydata)

# birt_rate는 연속변수? Y

# 샤피로
test <- aov(birth_rate ~ ad_layer, data =mydata)
shapiro.test(resid(test))  # p-value = 5.788e-07 -> 정규분포가 아님..

# 정규분포 아닐땐 kruskal test
kruskal.test(birth_rate ~ ad_layer, data =mydata) # p-value < 2.2e-16 -> 차이 존재

# 흠 이 다음에 posthocTGH 를 사용????
posthocTGH(x=mydata$ad_layer, y=mydata$birth_rate, method = 'games-howell')
#세가지 비교에서 모두 .01보다 작거나 혹은 .04와 같다. -> .05보다 작음


##### Two Way ANOVA
mydata2 <- read.csv('data/anova_two_way.csv')
head(mydata2)
tail(mydata2)
# multichild : 다자녀 지원조례 채택여부

m2 <- aov(birth_rate ~ ad_layer + multichild + ad_layer:multichild, data = mydata2)
?aov
summary(m2) # 채택x

TukeyHSD(m2)


###### Repeated Measured ANOVA
ow <- read.csv('data/onewaySample.csv', header = T)
dim(ow)
ow <- ow[, 2:6]
ow
# 그래프 그리기
# step1) 평균 구하기
means <- c(mean(ow$score0), mean(ow$score1), mean(ow$score3), mean(ow$score6))
means # 58.28571 37.57143 24.28571 15.71429
plot(means)
plot(means, type='l')  #l : line
plot(means, type='o')
plot(means, type='o', lty=2)
plot(means, type='o', lty=2, col=2, xlab='month', ylab = 'score', main='One Way test')

multimodel <- lm(cbind(ow$score0, ow$score1, ow$score3, ow$score6) ~ 1) # ~1 : 전체를 하나로 묶음
multimodel
trials <- factor(c('score', 'score1', 'score3', 'score6'), ordered = F)
trials

# 필요한 패키지 설치
#install.packages('car')  # Anova함수 이용을 위해
library(car)
?Anova
# III : 3종오류?
model1 <- Anova(multimodel, idata = data.frame(trials), idesign = ~trials, type = "III")
model1 # trials의 Pr(>F)=0.0001272 -> 상당히 의미 있게 나옴

# ow 데이터를 long형으로 바꾸기
library(tidyr)
str(ow)
head(ow)
owLong <- gather(ow, key='ID', value='score')
owLong <- owLong[8:35, ]
owLong
# 정규분포 확인(샤피로)
out <- aov(score~ID, data=owLong)
shapiro.test(resid(out)) # p-value = 0.954 -> 정규분포

# 사후검정(Tukey)
TukeyHSD(out) # 전부 다 차이가 있음, 연구가설 채택

# t-검정을 여러 번 하면 제1종오류(알파)가 0.05보다 커지는 문제 발생 
# 이 문제를 해결하기 위한 방법들(Bonferroni, Tukey, Scheffe)

# 본페로니(Bonferroni) 사후검정 방식 : 유의수준 0.05를 비교하는 개수로 나누어준다.
# ow의 경우 : 0.05/4 = 0.0125 


####### repeated measured anova가 비모수 통계일 경우 : Friedman test
?friedman.test  # Friedman Rank Sum Test
RoundingTimes <-
  matrix(c(5.40, 5.50, 5.55,
           5.85, 5.70, 5.75,
           5.20, 5.60, 5.50,
           5.55, 5.50, 5.40,
           5.90, 5.85, 5.70,
           5.45, 5.55, 5.60,
           5.40, 5.40, 5.35,
           5.45, 5.50, 5.35,
           5.25, 5.15, 5.00,
           5.85, 5.80, 5.70,
           5.25, 5.20, 5.10,
           5.65, 5.55, 5.45,
           5.60, 5.35, 5.45,
           5.05, 5.00, 4.95,
           5.50, 5.50, 5.40,
           5.45, 5.55, 5.50,
           5.55, 5.55, 5.35,
           5.45, 5.50, 5.55,
           5.50, 5.45, 5.25,
           5.65, 5.60, 5.40,
           5.70, 5.65, 5.55,
           6.30, 6.30, 6.25),
         nrow = 22,
         byrow = TRUE,
         dimnames = list(1 : 22,
                         c("Round Out", "Narrow Angle", "Wide Angle")))
RoundingTimes

# 정규분포 여부 확인
library(reshape)
rt2 <- melt(RoundingTimes)
rt2

out <- aov(value~X2, data=rt2)
shapiro.test(resid(out)) #p-value = 0.001112 -> 정규분포X

boxplot(value~X2, data=rt2)

# 비모수 통계 test
friedman.test(RoundingTimes) #p-value = 0.003805 -> 이 데이터가 뭔진모르겠지만 차이가 있음

# Friedman test 사후검정
#install.packages('coin')
library(coin)

# https://www.r-statistics.com/2010/02/post-hoc-analysis-for-friedmans-test-r-code/
source("https://www.r-statistics.com/wp-content/uploads/2010/02/Friedman-Test-with-Post-Hoc.r.txt")

friedman.test.with.post.hoc(value ~ X2 | X1, rt2) #Wide Angle - Round Out : 0.003350398
# 0.05/3 = 0.01666667 이것보다 작아야 의미가 있음








