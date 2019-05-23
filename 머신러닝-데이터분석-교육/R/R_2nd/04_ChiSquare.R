data(mtcars)
head(mtcars)
# 자동차의 실린더 수와 변속기의 관계를 확인
table(mtcars$cyl, mtcars$am)
# 간단한 데이터 정제 (파생변수만들기)
mtcars$tm <- ifelse(mtcars$am == 0, 'automatic', 'manual')
table(mtcars$cyl, mtcars$tm)

# 파생변수 만들기2 (factor이용): 변수가 여러개? 일 때 사용
mtcars$sm <- factor(mtcars$am, labels = c('automatic', 'manual'))
result <- table(mtcars$cyl, mtcars$sm)

addmargins(result) # 셀수(Cell count)의 20% 이상의 셀에서 5이하의 값이 있다. -> Fisher 사용

#chisq.test(result) # p-value = 0.01265
fisher.test(result) # p-value = 0.009105 -> 충분히 관계가 있음이 확인되었다.


# Cochran-armitage trend test
  # 흡연과 고혈압의 관계 확인
library(moonBook)
str(acs)
  #빈도수확인
table(acs$HBP, acs$smoking)

  #칼럼순서바꾸기
acs$smoking = factor(acs$smoking, levels=c('Never', 'Ex-smoker', 'Smoker'))
result <- table(acs$HBP, acs$smoking)

result[2,] # 고혈압 yes
colSums(result)  # 전체 합계

  #코크란 아미티지 트렌드 검정
prop.trend.test(result[2,], colSums(result)) # p-value = 9.282e-11 -> 흡연율과 고혈압 관계o

  #모자이크 그래프
mosaicplot(result)
mosaicplot(result, color = c('tan1', 'firebrick2'))

colors()
demo('colors')

t(result)
mosaicplot(t(result), color=c('tan1', 'firebrick2'), ylab = 'Hypertension', xlab = 'Smoking')

mytable(smoking ~ age, data=acs)
# 앞에선 age를 무시했었음. -> 해석에서 혼란을 일으키는 age: 교란변수


############################################# 카이제곱 관련 예제
mydata <- read.csv('data/anova_two_way.csv')
head(mydata)
tail(mydata)
  # 시, 군, 구 별 다자녀 지원 조례 채택 여부 관계

str(mydata)
result <- table(mydata$ad_layer, mydata$multichild)
chisq.test(result)  #p-value = 0.7133   # 5이하 많아서 정확하지 않음
fisher.test(result) #p-value = 0.7125  # 관계없다..?
