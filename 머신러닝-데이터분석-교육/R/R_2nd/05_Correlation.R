install.packages('UsingR')
library(UsingR)
# 부모와 자식의 키의 관계
data(galton)
str(galton)
  # parent : 아빠의 키와 1.08*엄마의 키의 산술평균

plot(child~parent, data = galton)

  #피어슨 상관계수
cor.test(galton$child, galton$parent) #p-value < 2.2e-16 -> 관계가 있다.(cor 0.4587624)

result <- lm(child~parent, data=galton)
summary(result)
# 절편: 23.94153  기울기: 0.64629  y=0.65x+23.94
abline(result, col='purple') # 회귀선
  # 겹쳐져있는 데이터들을 퍼질 수 있게 흔들.기..?
plot(jitter(child,5)~jitter(parent,5), data = galton)
abline(result, col='purple')
sunflowerplot(galton)


install.packages('SwissAir')  # 스위스 공기 질 측정
library(SwissAir)
head(AirQual)
tail(AirQual)
  # 오존관련
Ox <- AirQual[ , c("ad.O3", "lu.O3", "sz.O3")] + AirQual[ , c("ad.NOx", "lu.NOx", "sz.NOx")] -
  AirQual[ , c("ad.NO", "lu.NO", "sz.NO")]

names(Ox) <- c("ad", "lu", "sz")

plot(lu~sz, data=Ox) # 겹치는 데이터가 넘 많음 -> 이걸 효과적으로 보여주는 그래프-> 아래

# 겹치는 데이터를 효과적으로 시각화하는 그래프
#install.packages("hexbin")
library(hexbin)

  #1번째
bin <- hexbin(Ox$lu, Ox$sz, xbin=50)
plot(bin)
  #2번쨰
smoothScatter(Ox$lu, Ox$sz)
  #3번째
#install.packages("IDPmisc")
library(IDPmisc)
iplot(Ox$lu, Ox$sz)

################################ 또 다른 사례
mydata <- read.csv('data/cor.csv')
head(mydata)
dim(mydata)  # 157, 7
  # (참고) elderly_rate: 65세이상 인구, finance: 재정자립도, cultural_center: 인구10만명당 문화기반 시설의 수
plot(mydata$pop_growth, mydata$elderly_rate)

cor(mydata$pop_growth, mydata$elderly_rate, method = 'pearson')
# -0.4069218 => 약한 음의 상관관계
  # 순위를 가지고 구하는 상관관계
cor(mydata$pop_growth, mydata$elderly_rate, method = 'spearman')
# -0.4342161

  # 한번에 비교하는 방법 -> 합치기
attach(mydata)
x <- cbind(pop_growth, birth_rate, elderly_rate, finance, cultural_center)
cor(x)
#                 pop_growth  birth_rate elderly_rate     finance cultural_center
# pop_growth       1.0000000  0.16152885  -0.40692178  0.23078789     -0.20736363
# birth_rate       0.1615289  1.00000000   0.05672361 -0.09981501      0.08881914
# elderly_rate    -0.4069218  0.05672361   1.00000000 -0.43573354      0.49885306
# finance          0.2307879 -0.09981501  -0.43573354  1.00000000     -0.06016467
# cultural_center -0.2073636  0.08881914   0.49885306 -0.06016467      1.00000000

x<-c(70, 72, 62, 64, 71, 76, 0, 65, 74, 72)
y<-c(70, 74, 65, 68, 72, 74, 61, 66, 76, 75)


