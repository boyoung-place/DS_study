########## 공통 요인 분석
data1 <- c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 4, 5, 6)
data2 <- c(1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 3, 4, 3, 3, 3, 4, 5, 6)
data3 <- c(3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 4, 6)
data4 <- c(3, 4, 3, 3, 3, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 5, 4, 5)
data5 <- c(1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 6, 4, 5)
data6 <- c(1, 2, 1, 1, 1, 3, 3, 3, 2, 3, 1, 1, 1, 1, 1, 5, 4, 5)

testData <- cbind(data1, data2, data3, data4, data5, data6)
testData

EigenData <- cor(testData)
EigenData

# 고유값(Eigen Value) : 특정 요인에 모든 변수의 적재량을 제곱해서 합한 값. 몇 개의 요인을 도출할 것인지를 결정하는 지표.
# 선형대수학 개념
eigen(EigenData)  #3개를 뽑을 것임.
# 요인분석 - 정보손실의 우려 있음
factanal(testData, factors = 3) # Loadings부분 확인: factor1 - data1&2묶임 / factor2 - data5&6 / factor3 - data3&4
# -> data 가 각각 묶여서 총 3개가 됌.


########### 주성분분석(PCA) :요인분석의 보완(정보손실의 우려 보완)
head(iris)
  # 주의할 점) 다중공선성이 없어야.. : 독립변수간의 상관관계가 있으면 안된다는 것 -> 없애는 건 불가, 최소화시켜야함
  # 종속변수 제외하고 독립변수 4개의 상관행렬 보기
cor(iris[1:4]) # 상관관계 높은 몇 개가 보임 -> 이러한 다중 공선성을 해결하는 방법은?
# 다중 공선성 해결과정
log.ir <- log(iris[, 1:4])  # iris 데이터에서 품종을 뺀 나머지 데이터를 로그를 취하게 만든다.
head(log.ir)
ir.Species <- iris[,5] # 품종 데이터 따로 보관관
ir.Species
# 주성분분석을 돌린다는 것 = 독립변수 간의 상관관계를 최소화한다는 것
ir.pca <- prcomp(log.ir, center = T, scale. = T)  #center = T : 중앙평균값=0, scale. = T : 분산=1 (표준분포에 맞춤)
print(ir.pca)  # 일단은 원래 변수와 같은 수의 주성분이 나온다. 재생성된 4가지 주성분 중 몇가지를 쓸 지..
# PC1 =  0.5038236 * Sepal.Length -0.3023682 * Sepal.Width + 0.5767881 * Petal.Length + 0.5674952 * Petal.Width 의 선형식을 가지는 변수라고 해석하면 된다.

# 4가지 중 몇 가지 쓸지 정하는 방법
plot(ir.pca, type="l")  # 갑자기 꺾이는 부분=elbow point -> 꺾이기 전까지의 변수들을 선택
summary(ir.pca)
# 1. Variance가 가장 큰 PC1을 선택한다.(PC1이 전체의 0.7331을 대변한다.)
# 2. PC2까지 더해지면 0.96만큼 전체를 대변한다. -> PC2까지 (*PC3까지해서 0.99인것은 별로 드라마틱한 변화가 아니므로(0.96->0.99) PC2까지만 해줘도 충분하다)

ir.pca$rotation  # <- 알고리즘 : varimax, oblimin  <- 이 rotation으로 다중 공선성을 최소화시킬 수 있다?

class(log.ir) #data.frame

# 위의 print 로 보았을 때, 
# PC1 =  0.5038236 * Sepal.Length -0.3023682 * Sepal.Width + 0.5767881 * Petal.Length + 0.5674952 * Petal.Width 으로 이루어진 선형조합 이라고 했기때문에 각 주성분을 위의 형태에 맞게 계산해 주어야 한다.
# 따라서 원래 데이터와 선형계수를 메트릭스 곱으로 선형조합에 맞게 만들어 준다.
# %*% : 행렬 곱(매트릭스 곱)
# ir.pca$rotaion에 선형계수가 있다.
prc <- as.matrix(log.ir) %*% ir.pca$rotation   
head(prc)

train1 <- cbind(ir.Species, as.data.frame(prc))
head(train1)

class(train1[,1]) #factor
colnames(train1)[1] <- 'label'
head(train1)

fit <- lm(label ~ PC1 + PC2, data=train1)
fit

fit_pred <- predict(fit, newdata = train1)
fit_pred  # 소숫점 앞의 0 1 2 = species

b <- round(fit_pred)  # species를 가리키는 숫자만 보이도록
b # 0, 1 은 setosa, 2는 versicolor, 3은 virginica

b[b==0 | b==1] <- "setosa"
b[b==2] <- 'versicolor'
b[b==3] <- 'virginica'
b

table(b, ir.Species)

# 참고웹페이지: https://m.blog.naver.com/leedk1110/220783514855


############################# 라면 예제
ramen <- read.table('data/noodle.txt', header = T)
ramen

summary(ramen)
# 데이터 표준화
data <- scale(ramen)
cor(data) #-> 다중 공선성은 없어보임

p1 <- prcomp(data, scale. = T)
p1
summary(p1) # PC2까지의 누적비율=0.7956 -> PC1과 PC2

predict(p1)
# PC1을 보면, 짬뽕라면과 김치라면이 종합평가?가 제일 좋음

biplot(p1)  # 짬뽕, 김치

################################ 새로운 패키지를 이용한 주성분 분석
library(xlsx)
mydata <- read.csv('data/factor.csv')
mydata

#install.packages('psych')
library(psych)
#install.packages('nFactors')
library(nFactors)

names(mydata)
# 종속변수 : pop_growth, '군별'칼럼은 제외하고 분석할 것임
attach(mydata)
x <- cbind(pop_growth, birth_rate, elderly_rate, finance, cultural_center, social_welfare, active_firms, economic_activities)
class(x) #matrix
e_value <- eigen(cor(x))
e_value  # 3개 선택(요인의 갯수 정하기, 1 넘는 값?)

pca <- principal(x, nfactors = 3, rotate = 'varimax')
print(pca, digits = 3, sort = T)  # digits = 3 : 소숫점 3자리까지

# 요인 분석
fac <- factanal(x, 3, rotation='varimax')
print(fac, digits = 3, sort= T)


################################# 군집 분석
### K-means
mydata <- read.csv('data/cluster.csv')
mydata
View(mydata)
attach(mydata)
x <- cbind(pop_growth, birth_rate, elderly_rate)
x
scale(x)  # 데이터 표준화

clu <- kmeans(x, 3)
clu

### 계층적 분석
d <- dist(x, method = 'euclidian')
clu1 <- hclust(d, method= 'ward.D')
clu1
plot(clu1)

# 최단 연결법
clu2 <- hclust(d,method = 'single')
plot(clu2)

# 최장 연결법
clu3 <- hclust(d, method='complete')
plot(clu3)

# 평균 연결법
clu4 <- hclust(d, method='complete')
plot(clu4)

