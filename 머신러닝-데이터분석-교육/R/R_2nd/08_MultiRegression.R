###################### 다중 회귀 분석
# 참고 웹페이지 : https://rstudio-pubs-static.s3.amazonaws.com/190997_40fa09db8e344b19b14a687ea5de914b.html
state.x77
View(state.x77)
dim(state.x77)

# 종속변수 = Murder
states <- as.data.frame(state.x77[, c('Murder', 'Population', 'Illiteracy', 'Income', 'Frost')])
states

# 선형 모델 만들기
fit <- lm(Murder ~ ., data=states)
summary(fit)  #Adjusted R-squared:  0.5285 
# Illiteracy(문맹률)의 Pr(>|t|) : 2.19e-05 -> Murder와 제일 연관률 높다
# 문맹률이 1% 변하면 Murder가 4.14 변한다고 95%의 확신을 가지고 이야기할 수 있음
#회귀계수의 95% 신뢰구간
confint(fit)

# 검증
# 1. 다중 공선성이 있는가?
# 해결방법: 주성분분석 and VIF(Variation Inflation Factor)
# VIF(분산팽창지수) : vIF 루트 값 > 2 -> 다중 공선성의 위험이 크다고 판단
#install.packages('car')
library(car)

sqrt(vif(fit))  # sqrt : 루트씌어주기기
# 결과값을 보니 2를 넘는 건 없다 -> 다중 공선성의 위험이 낮다고 판단

# 2. 이상치
  # 이상치: 표준 잔차 2배 이상 크거나 또는 -2배 이상 작은 값들을 의미한다.
  # 큰 지레점(High leverage points): p(절편을 포함한 인수들의 숫자)/n 의 값에 2~3배 이상되는 값 (states의 경우 5/50)
  # 영향 관측치: Cooks'D <- 독립변수의 수 / 샘플 수 - 독립변수의 수 - 1의 결과보다 크다면 이상치로 판단

influencePlot(fit, id=list(method='identify'))  # car를 설치했기에 쓸 수 있는 함수
# x축에서 0.2를 넘어가면 이상치로 봄..? (큰지레점)

outlierTest(fit) # Bonferonni 검정을 통해 outlier 골라주기(레버리지를 고려하지 않고 오차만을 고려)

# 회귀모형의 교정
########################
# 정규성에 대한 교정
# ex) 소득분포의 경우 절대 정규분포가 될 수 없다 이런 경우 어떻게 교정을 해야할까?
# -> 종속변수 제곱(람다) ?? or 모든변수에 log취하기 등

par(mfrow=c(2,2))
plot(fit)

# 만약 정규분포가 아니라면,
summary(powerTransform(states$Murder))  # 추정 변환 파라미터 : 0.605542  <- 종속변수에 이 값을 제곱하라
# Ramda가 0인경우와 1인경우의 pval, 0의 경우는 0.5보다 작고 1의 경우는 크다.  => 1의 경우 Transform이 큰 의미는 없을 거라는 의미의 수치..?
# -2, -1, -0.5, 0, 0.5, 1, 2 : 파라미터 0.605542의 경우 0.5를 해주면 된다 -> 결국 y에 root를 씌우는 것과 같은 의미, 0은 log취하기

#####################################################
#####################################################
# 19.05.27(월)

# 선형성에 대한 교정(boxTidwell())
?boxTidwell
boxTidwell(Murder ~ Population + Illiteracy, data=states)
# p-value값이 0.05이하였다면, Population 과 Illiteracy에 lambda... 0.86배, 1.35배..

# 등분산성에 대한 교정(ncvTest(), spreadLevelPlot())
# ncvTest()는 모형 적합 값에 따라 오차의 분산이 변하는지 검정해준다. 여기서 유의한 결과가 나온다면 오차의 등분산성 가정이 위배된다고 할 수 있다.
ncvTest(fit)
# spreadLevelPlot()은 fitted value(적합치)에 대한 absolute studentized residual(잔차를 표준편차로 나눈값의 절대값)을 scatter plot으로 보여준다.
spreadLevelPlot(fit)


# 회귀모형의 선택(Backward Regression, Forward Regression)
#####################
# Backward Regression
  #1. 모든 요인들을 회귀식에 넣는다.
  #2. p-value가 가장 나쁜 요인들을 하나씩 빼가면서 처리
  #3. AIC(Akaike's Information Criterion)

fit1 <- lm(Murder ~., data=states)
summary(fit1)

fit2 <- lm(Murder ~ Population + Illiteracy, data=states)
summary(fit2)

AIC(fit1,fit2)  # 자유도차이, AIC값, fit2 가 fit1보다 좋은 모형

# stepwise regression (Backward Regression, Forward Regression)
# : AIC 값을 이용하여 단계적 회귀를 수행하는 함수로 forward, backward stepwise regression을 모두 할 수 있다
full.model <- lm(Murder ~ ., data=states)
reduced.model <- step(full.model, direction = 'backward', trace = 0)  # trace = 0 : 과정print 생략
summary(reduced.model)

min.model = lm(Murder~1, data = states)
fwd.model <- step(min.model, direction = 'forward', scope = (Murder~Population+Illiteracy+Income+Frost))



# all subset regression
install.packages('leaps')
library(leaps)
#기본값은 각 변수 개수당 최선의 모델을 한 개씩만 구한다. 만약 변수 개수당 n개의 최선의 모델을 얻고자 한다면 nbest=n을 지정한다
result <- regsubsets(Murder~ ., data=states, nbest=4)
plot(result, scale='adjr2')


###################################### 또 다른 예제  => 시놀로지 챗방 참고
mydata <- read.csv('data/regression.csv')
View(mydata)
head(mydata)
str(mydata)
attach(mydata)
reg <- lm(birth_rate ~ cultural_center + social_welfare +active_firms + pop + urban_park + doctors + tris + kindergarten + dummy, data = mydata)
summary(reg)  # Adjusted R-squared:  0.1089


reduced.reg <- step(reg, direction = 'backward')
summary(reduced.reg)  # Adjusted R-squared:  0.1184 

min.reg = lm(birth_rate~1, data = mydata)
fwd.reg <- step(min.reg, direction = 'forward', scope = (birth_rate~cultural_center + social_welfare +active_firms + pop + urban_park + doctors + tris + kindergarten + dummy), trace = 0)
summary(fwd.reg)  # Adjusted R-squared:   0.12

#기본값은 각 변수 개수당 최선의 모델을 한 개씩만 구한다. 만약 변수 개수당 n개의 최선의 모델을 얻고자 한다면 nbest=n을 지정한다.
result_reg <- regsubsets(birth_rate ~ cultural_center + social_welfare +active_firms + pop + urban_park + doctors + tris + kindergarten + dummy, data = mydata, nbest=4)
summary(result_reg)
plot(result_reg, scale='adjr2')  # adjr 0.12 가 최대 <= social_welfare, active_firms, pop, tris(폐수배출업소)


#####################################################
# 로지스틱 회귀분석
# 0 < x < 1, cf) sigmoid , 직선을 2차방정식으로 변환 
# *일반화 선형모델:종속변수가 범주형변수인 경우, 종속변수가 count인 경우 사용, 로지스틱 회귀분석은 일반화 선형 모델의 특수 사례이다.
# yes or no 와 같은 이진 응답을 예측할 떄에는 로지스틱 회귀분석을 사용한다. glm()

library(survival)
str(colon)
# colon$status : 0 - 재발없이 잘 산다.  1 - 재발했거나 죽음

# 결측치 확인
table(is.na(colon))
colon1 <- na.omit(colon)
table(is.na(colon1))

# glm()
# 과산포(overdispersion) -> 결과에 왜곡을 불러옴
# family = 'binomial'(과산포없는 경우) or 'quasibinomial'(과산포있는 경우)
result <- glm(status ~ rx + sex + obstruct + perfor + adhere + nodes + differ + extent + surg, family = 'binomial', data=colon1 )
summary(result) # 영향력 높은 변수들 살피기(별표시)

# backward regression
reduced.model <- step(result)  # status ~ rx + obstruct + adhere + nodes + extent + surg
summary(reduced.model)

# odds ratio 이용
library(moonBook)
extractOR(reduced.model)  # rxLev는 제외(5Fu와 더해지면서 상당한 관계형성), obstruct p-value 0.0812 : 관계 의미 없음

# 과산포 유무 확인 : pchisq()
fit <- glm(status ~ rx + obstruct + adhere + nodes + extent + surg,
           family='binomial', data=colon1)
fit.od <- glm(status ~ rx + obstruct + adhere + nodes + extent + surg,
           family='quasibinomial', data=colon1)
summary(fit.od)

  # 0.05 기준
pchisq(summary(fit.od)$dispersion * fit$df.residual, fit$df.residual,
       lower=F)  # 0.2803691
  # 0.05보다 크므로 과산포 없다.

# 그래프로 시각화
# moonBook제공함수이용
ORplot(fit, main='Plot for OR', type=2, show.OR = F, show.CI = T, pch=15, lwd=3, col=c('blue', 'red'))  # 데이터가 1에 가까울 수록 의미가 없는 것! + 표시된 별표로도 확인가능

#-----------------------기본 통계 기법 끝 --------------------
