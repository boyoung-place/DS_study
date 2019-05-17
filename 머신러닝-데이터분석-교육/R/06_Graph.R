library(ggplot2)

# qplot()
x <- c('a', 'a', 'b', 'c')
qplot(x) # 빈도표 볼 수 있다

mpg
qplot(data=mpg, x=hwy) # 1갤런당 몇 마일?
qplot(data=mpg, x=cty)
qplot(data=mpg, x=drv, y=hwy, geom='line') # 몇 륜 구동...
# qplot의 장점: 옵션을 여러개 줄 필요 없이 간단하게 시각화 가능
qplot(data=mpg, x=drv, y=hwy, geom='boxplot')
qplot(data=mpg, x=drv, y=hwy, geom='boxplot', color=drv)
?qplot

# ggplot()
# 데이터 준비
ggplot(data=mpg, aes(x=displ, y=hwy))

ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point()  # 산포도
# 배기량이 클수록 연비가 낮아진다. (음의 상관관계)
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() + xlim(3,6)  # x축의 한계범위
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() + xlim(3,6) + ylim(10,30)

# 보통 전처리단계에서의 중간확인용으로 qplot을 쓰고 결과 시각화용으로 ggplot을 주로 쓴다.

library(dplyr)
# 구동방식 별 평균 고속도로연비
df_mpg <- mpg %>% 
  group_by(drv) %>%
  summarise(mean_hwy=mean(hwy))
df_mpg

### 막대그래프
ggplot(data = df_mpg, aes(x=drv, y=mean_hwy)) + geom_col() # 막대그래프
ggplot(data = df_mpg, aes(x=reorder(drv, mean_hwy), y=mean_hwy)) + geom_col()   # 정렬:reorder?
ggplot(data = df_mpg, aes(x=reorder(drv, -mean_hwy), y=mean_hwy)) + geom_col()  # -:내림차순

#y축없이 x축만으로 빈도 그래프
ggplot(data = mpg, aes(x=drv)) + geom_bar()
?geom_bar

# 자동차 중에 어떤 class(종류)가 가장 많은지를 알아보려고 한다.
ggplot(data=mpg, aes(x=class)) + geom_bar()

### 선 그래프
tail(economics)
ggplot(data=economics, aes(x=date, y=unemploy)) + geom_line()
ggplot(data=economics, aes(x=date, y=psavert)) + geom_line()

### 상자 그래프
ggplot(data=mpg, aes(x=drv, y=hwy)) + geom_boxplot()

# class가 'compact', 'subcompact', 'suv'인 자동차의 cty가 어떻게 다른지 비교해보려고 한다.
# 상자 그래프로 확인하시오.
# p,173 aggregate(): 좀 더 일반적인 그룹별 연산을 위한 함수

class_mpg <- mpg %>% filter(class %in% c('compact', 'subcompact', 'suv'))
ggplot(data=class_mpg, aes(x=class, y=cty)) + geom_boxplot()

### 기타 그래프
x <- c(1, 3, 6, 8, 9)
y <- c(12, 56, 78, 32, 9)
plot(x,y)  # 완전 기본 그래프
arrows(3, 56, 1, 12)  # 점 점 잇는 화살표선
rect(4, 20, 6, 30, density=9)
text(4, 40, '이것은 샘플이다', srt=55)
# side=1: 아래, 2: 왼쪽, 3: 위쪽, 4: 오른쪽
mtext('상단의 문자열입니다.', side=3)

x <- c(1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 4, 5, 6, 6, 6)
y <- c(2, 1, 4, 2, 3, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1)
z <- data.frame(x, y)
z
plot(x,y)

# sunflowerplot이라는 함수를 이용 -> 몇 번 중복되었는지 꽃잎으로 표현함
sunflowerplot(z)

# star graph

# ggplot의 mpg랑 비슷한 데이터
# 1974년 Motor Trand US magazine에서 추출한 것으로 1973년, 1974년  32개 자동차들의 디자인성능을 비교한 데이터
head(mtcars, 5)
# 나이팅게일 그래프..?
stars(mtcars[1:4], flip.labels = F, key.loc = c(13, 1.3), draw.segments = T)  # flip.labels = F : label 같은 높이

# 6장(교재) 꼭해보기























