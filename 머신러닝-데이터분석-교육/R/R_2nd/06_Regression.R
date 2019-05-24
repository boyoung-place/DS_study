# 단순 선형 회귀
women # 미국 여성 대상으로 키와 몸무게 조사(연령 30~39세) 키:inch 몸무게:pound

plot(weight~height, data=women)
# lm(): 최소제곱법을 이용, 선형 회귀를 만든다. formula: 종속변수~독립변수형태로 지정
fit <- lm(weight~height, data=women) 
abline(fit, col='blue')
summary(fit) #Adjusted R-squared:  0.9903    <- R-squared쓰지않고 이것을 쓴다!

par(mfrow=c(2,2))  #그래프 몇 개 보일건지 지정
plot(fit) # 여러 plot을 보여줌  (선형성 만족x, 정규성 만족x, 등분산성 만족o => 만족x)

par(mfrow=c(1,1))
plot(weight~height, data=women)
fit <- lm(weight~height, data=women) # 최소제곱법을 이용
abline(fit, col='blue') # => 데이터들을 잘 보면 곡선형태, 2차방정식으로 추정된다. -> 예측이 힘들다.

# I(height^2): 2차방정식 표현? p.392 표현식을 위한 I()의 사용, 객체의 해석과 변환을 방지한다.
fit2 <- lm(weight ~ height + I(height^2), data=women)
summary(fit2)  # Adjusted R-squared:  0.9994 
  # 곡선 그리기
plot(weight ~ height, data=women)
lines(women$height, fitted(fit2), col='red')
      
par(mfrow=c(2,2))
plot(fit2)  # 선형성 만족?, 정규성 만족?..ㅡ,

# 3차방정식 표현
fit3 <- lm(weight ~ height + I(height^2) + I(height^3), data=women)

summary(fit3) # Adjusted R-squared:  0.9997 (설명력)
plot(fit3)  # 방정식 차원을 늘릴 수록 오히려 성능이 안좋아진다.
# Normal Q-Q 라는 그래프가 나옴 -> p.339
# Q-Q : 데이터가 특정 분포를 따르는지를 시각적으로 검토하는 방법, Q는 분위수(quantile)의 약어이다.

#################### 또다른 사례
mydata = read.csv('data/regression.csv')
head(mydata)
str(mydata)
dim(mydata)
# social_welfate : 사회복지시설
# active_firms : 사업체수
# Urban_park : 도시공원
# doctor: 의사
# tris : 페수배출업소
# kindergarten : 유치원

# 유치원 수가 많은 지역에 합게 출산율도 높은가? 또는 합계 출산을이 유치원 수에 영향을 받는가?에 대한 검증
fit4 <-lm(birth_rate~kindergarten, data=mydata)
plot(birth_rate ~ kindergarten, data=mydata)
abline(fit4, col='blue')
summary(fit4)  # Adjusted R-squared:  0.03305 <- 상관관계 없다고 볼 정도..!?
par(mfrow=c(2,2))
plot(fit4) #(선형성 만족x->o 임, 정규성 만족o?->x 끝부분이 삐끗함, 등분산성 만족o => 만족x)

# 설명 (출처: https://thebook.io/006723/ch08/02/06/)
# Residuals vs Fitted는 X 축에 선형 회귀로 예측된 Y 값, Y 축에는 잔차를 보여준다.선형 회귀에서 오차는 평균이 0이고 분산이 일정한 정규 분포를 가정하였으므로, 예측된 Y 값과 무관하게 잔차의 평균은 0이고 분산은 일정해야 한다. 따라서 이 그래프에서는 기울기 0인 직선이 관측되는 것이 이상적이다.
#  Normal Q-Q는 잔차가 정규 분포를 따르는지 확인하기 위한 Q-Q도
# Scale-Location은 X 축에 선형 회귀로 예측된 Y 값, Y 축에 표준화 잔차Standardized Residual3 를 보여준다. 이 경우도 기울기가 0인 직선이 이상적이다. 
# Residuals vs Leverage는 X 축에 레버리지Leverage, Y 축에 표준화 잔차를 보여준다. 레버리지는 설명 변수가 얼마나 극단에 치우쳐 있는지를 뜻한다. (이상치 확인)
# 쿡의 거리는 회귀 직선의 모양(기울기나 절편 등)에 크게 영향을 끼치는 점들을 찾는 방법이다. 쿡의 거리는 레버리지와 잔차에 비례하므로 두 값이 큰 우측 상단과 우측 하단에 쿡의 거리가 큰 값들이 위치하게 된다.

# 강사님 답
y <- cbind(mydata$birth_rate)  #종속변수
x <- cbind(mydata$kindergarten)  #독립변수

reg1 <- lm(y ~ x , data = mydata)
summary(reg1)  # Adjusted R-squared:  0.03305 -> 설명력이 3%밖에 안된당.  관계가 있긴하지만 약함
par(mfrow=c(2,2))
plot(reg1) # 선형성 만족o, 이상치도 큰 문제는 없어보임, Q-Q를 보니 정규분포가 아닌 것 같음
# 정규분포 정확히 확인
shapiro.test(resid(reg1)) #p-value = 8.088e-05 -> 정규분포가 아니다. 

# 데이터를 교정해서 최대한 맞게끔 만드는 방법이 있음 : 지수, 로그
# log로 데이터 다듬기
reg2 <- lm(log(y) ~ log(x), data=mydata) # 때에 따라서는 하나의 변수에만 로그를 취할 수도 있다.
summary(reg2)  #Adjusted R-squared:  0.03745  #p-value: 0.009645
plot(reg2)
shapiro.test(resid(reg2)) #p-value = 0.2227 -> 정규분포가 되었다!

par(mfrow=c(1,1))


