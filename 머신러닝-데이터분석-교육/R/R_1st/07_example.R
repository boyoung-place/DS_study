# 데이터 파악
head(iris, 10)
tail(iris)
names(iris)
class(iris)
dim(iris)
str(iris)
View(iris)

# 기초동계학
mean(iris$Sepal.Length)
median(iris$sepal.Length)
var(iris$sepal.Length)
sd(iris$sepal.Length)
max(iris$sepal.Length)
min(iris$sepal.Length)
quantile(iris$sepal.Length)
summary(iris$sepal.Length)


# 기본 시각화

boxplot(iris$Sepal.Length)
hist(iris$Sepal.Length)
plot((iris$Sepal.Length))


### 한 화면에 여러 개의 그래프 그리기
opar <- par(no.readonly = T)
par(mfrow=c(2, 2))


plot(mpg$displ, mpg$hwy)
hist(mpg$cyl)
boxplot(mpg$disp1, mpg$cty)
plot(mpg$displ, mpg$cty)

par(mfrow=c(3,1))
plot(mpg$displ, mpg$hwy)
plot(mpg$displ, mpg$hwy)
plot(mpg$displ, mpg$hwy)

# layout(): 좀 더 자유로운 배치
#layout(matrix(c(1,2,3,4),2,2,byrow=T))  # byrow=T : 행 우선
?layout
#layout(matrix(c(1,1,2,3),2,2,byrow=T))
layout(matrix(c(1,0,2,3),2,2,byrow=T))
hist(mtcars$wt)
hist(mtcars$mpg)
hist(mtcars$disp)
hist(mtcars$wt)
head(mtcars)

### Special Graph(wordcloud, map)

# wordcloud
# install.packages('rJava')
# 한글처리 자연어처리.. 설치
#install.packages('memoise')
#install.packages('KoNLP')
library(KoNLP)
library(dplyr)

useNIADic()

# 한줄씩 읽어오기 : readLines()
getwd()
txt <- readLines("C:/chung/rwork/FirstProject/data/hiphop.txt")
head(txt, 10)

# 정규표현식 이용
library(stringr)
txt <- str_replace_all(txt, "\\W", " ")

extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")

# (참고)1차원: 벡터, 2차원:데이터프레임,매트릭스, 2차원이상(다차원):리스트, array

nouns <- extractNoun(txt)
class(nouns)
wordcount <- table(unlist(nouns))

df_word <- as.data.frame(wordcount, stringsAsFactors = F)  # 단어와 빈도수
head(df_word)

df_word <- rename(df_word, word=Var1, freq=Freq)
head(df_word)

df_word <- filter(df_word, nchar(word) >=2)  # 2글자 이상인것 뽑기기

top_20 <- df_word %>% arrange(desc(freq)) %>% head(20)
top_20

#install.packages('wordcloud')
library(wordcloud)
library(RColorBrewer)

set.seed(1234)  # 난수 고정

par(mfrow=c(1,1))
# 팔렛트
pal <- brewer.pal(9, 'Blues')[5:9]
wordcloud(words = df_word$word, freq = df_word$freq,
          min.freq = 2, max.freq=200,   # 최소빈도수설정: min.freq
          random.order = F,
          scale=c(4, 0.3),
          colors=pal,
          rot.per=.1) 

wordcloud(words = top_20$word, freq = top_20$freq,
          min.freq = 2, max.freq=200,   # 최소빈도수설정: min.freq
          random.order = F,
          scale=c(4, 0.3),
          colors=pal,
          rot.per=.1) 

# 지도 시각화
#install.packages('ggiraphExtra')
library(ggiraphExtra)

library(ggplot2)

# 1973년 미국 주별 강력범죄율 정보
str(USArrests)
head(USArrests)

library(tibble)  # dataframe을 업그레이드시킨 버전정도로 생각
crime <- rownames_to_column(USArrests, var='state')
str(crime)

head(crime)
# state 전부 소문자로 바꾸기
crime$state <- tolower(crime$state)
head(crime)

#install.packages("maps")
#url <- 'https://cran.rstudio.com/bin/windows/contrib/3.6/maps_3.3.0.zip'
#install.packages(url, repos = NULL, type='source')

states_map <- map_data("state")
head(states_map)
str(states_map)
#install.packages("mapproj")

#url2 <- 'https://cran.rstudio.com/bin/windows/contrib/3.6/mapproj_1.2.6.zip'
#install.packages(url2, repos = NULL, type='source')
ggChoropleth(data=crime, aes(fill=Murder, map_id=state), map=states_map, interactive = T)

# 대한민국 시도별 인구 지도 만들기
install.packages('devtools')

devtools::install_github('cardiomoon/kormaps2014')

# korpop1 : 2015년 센서스 데이터(시도별)
# korpop2 : 2015년 센서스 데이터(시군구별)
# korpop3 : 2015년 센서스 데이터(읍면동별)

library(kormaps2014)
changeCode(korpop1)
str(changeCode(korpop1))

library(dplyr)
korpop1 <- rename(korpop1, pop=총인구_명, name=행정구역별_읍면동)
str(changeCode(korpop1))

# kormap1, kormap2, kormap3
str(changeCode(kormap1))
ggChoropleth(data=korpop1, aes(fill=pop, map_id=code, tooltip=name),
             map=kormap1, interactive = T)

str(changeCode(tbc))
ggChoropleth(data=tbc, aes(fill=NewPts, map_id=code, tooltip=name),
             map=kormap1, interactive = T)


### Interactive Graph
#install.packages('plotly')
library(plotly)
library(ggplot2)

p <- ggplot(data=mpg, aes(x=displ, y=hwy, col=drv)) + geom_point()
ggplotly(p)

p <- ggplot(data=diamonds, aes(x=cut, fill=clarity)) + geom_bar(position = 'dodge')
ggplotly(p)

#install.packages('dygraphs')
library(dygraphs)

head(economics)
str(economics)
# 날짜 : date, format

# date -> xts
library(xts)
eco <- xts(economics$unemploy, order.by=economics$date)
head(eco)
class(eco)

dygraph(eco)  # interactive한 그래프..

dygraph(eco) %>% dyRangeSelector()  # controller를 이용하여 범위 조정

# 저축률
eco_a <- xts(economics$psavert, order.by = economics$date)

# 실업률
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)

eco2 <- cbind(eco_a, eco_b)
head(eco2)

colnames(eco2) <- c('psavert', 'unemploy')
head(eco2)

dygraph(eco2) %>% dyRangeSelector()



