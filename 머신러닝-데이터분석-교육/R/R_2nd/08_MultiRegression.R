###################### 다중 회귀 분석
state.x77
dim(state.x77)

# 종속변수 = Murder
states <- as.data.frame(state.x77[, c('Murder', 'Population', 'Illiteracy', 'Income', 'Frost')])
states

# 선형 모델 만들기
fit <- lm(Murder ~ ., data=states)
summary(fit)  #Adjusted R-squared:  0.5285 
# Illiteracy의 Pr(>|t|) : 2.19e-05 -> Murder와 제일 연관률 높다

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
# x축에서 0.2를 넘어가면 이상치로 봄..?

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


# 참고 웹페이지 : https://rstudio-pubs-static.s3.amazonaws.com/190997_40fa09db8e344b19b14a687ea5de914b.html






























