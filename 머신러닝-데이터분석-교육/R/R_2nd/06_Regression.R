# 단순 선형 회귀
women # 미국 여성 대상으로 키와 몸무게 조사(연령 30~39세) 키:inch 몸무게:pound
# par("mar")
# par(mar=c(1,1,1,1))
plot(weight~height, data=women)
fit <- lm(weight~height, data=women) # 최소제곱법을 이용
abline(fit, col='blue')
summary(fit) #Adjusted R-squared:  0.9903    <- R-squared쓰지않고 이것을 쓴다!

par(mfrow=c(2,2))  #그래프 몇 개 보일건지 지정
plot(fit) # 여러 plot을 보여줌  (선형성 만족x, 정규성 만족x, 등분산성 만족o => 만족x)

par(mfrow=c(1,1))
plot(weight~height, data=women)
fit <- lm(weight~height, data=women) # 최소제곱법을 이용
abline(fit, col='blue') # =>곡선, 2차방정식 으로 추정된다. -> 예측이 힘들다.


fit2 <- lm(weight ~ height + I(height^2), data=women)
summary(fit2)  # Adjusted R-squared:  0.9994 
  # 곡선 그리기
plot(weight ~ height, data=women)
lines(women$height, fitted(fit2), col='red')
      
par(mfrow=c(2,2))
plot(fit2)  # 선형성 만족?, 정규성 만족?..ㅡ,

fit3 <- lm(weight ~ height + I(height^2) + I(height^3), data=women)

summary(fit3) # Adjusted R-squared:  0.9997 (설명력)
plot(fit3)  # 방정식 차원을 늘릴 수록 오히려 성능이 안좋아진다.

#################### 또다른 사례
mydata = read.csv('data/regression.csv')
head(mydata)
dim(mydata)
# social_welfate : 사회복지시설
# active_firms : 사업체수
# Urban_park : 도시공원
# doctor: 의사
# tris : 페수배출업소
# kindergarten : 유치원

# 유치원 수가 많은 지역에 합게 출산율도 높은가? 또는 합계 출산을이 영향을 받는가?에 대한 검증
lm(birth_rate~kindergarten, data='mydata')
plot(birth_rate ~ kindergarten, data='mydata')







