######################### 데이터 불러오기

# 키보드 입력: scan(), edit()
num <- scan()  # vector형식으로 저장됨
num

name <- scan(what = character())
name

## edit(): 상당히 그래픽적??
df <- data.frame()
df <- edit(df)  # 데이터 편집기 팝업창이 뜸(데이터 입력이 매우 수월)
df

######################## 로컬 파일 불러오기
getwd()
setwd("C:/chung/rwork/FirstProject/data")

?read.table
student <- read.table("student.txt")
student

# 컬럼 이름 만들기
names(student) <- c("번호", "이름", "키", "몸무게")
student

student1 <- read.table("student1.txt", header = T)
student1  # 컬럼 제목도 하나의 데이터처럼 가지고 올 경우, 인자명을 써준다(header)

# 파일 선택 팝업창 뜨면 선택(choose)
student2 <- read.table(file.choose(), header = T)
student2

student2 <- read.table("student2.txt", header = T, sep=";")
student2

#결측치있는 파일 읽기
student3 <- read.table("student3.txt", header = T, sep="", na.strings = "-")
student3

student4 <- read.csv("student4.txt", header = T, sep=",", na.strings = c("-", "+", "$"))
student4

# 설치 엑셀파일 불러오는 함수 제공: xlsx패키지, rJava패키지(기본적으로 자바 설치)
#install.packages("xlsx")
#install.packages("rJava")
library(rJava)
library(xlsx)

studentex <- read.xlsx(file.choose(), sheetIndex = 1, encoding="UTF-8")  # 몇번째시트를 가져올건지 지정
studentex

############################# 인터넷에서 파일 입력받기(파일 다운로드 없이)
# http://data.worldbank.org
gdp_ranking <- read.csv("http://databank.worldbank.org/data/download/GDP.csv")
gdp_ranking

head(gdp_ranking, 10)  # 상위 10개만 뽑아보기

# 보기좋게 가공
gdp_ranking2 <- gdp_ranking[-c(1:4), c(1,2,4,5)]
head(gdp_ranking2)

str(gdp_ranking2)

# 상위 15개 국가 선별하고 컬럼이름을 Code, Ranking, Nation, GDP로 변경
gdp_ranking15 <- head(gdp_ranking2, 15)
names(gdp_ranking15) <- c('Code', 'Ranking', 'Nation', 'GDP')
gdp_ranking15

# 막대 그래프로 시각화
gdp <- gdp_ranking15$GDP
nation <- gdp_ranking15$Nation

?barplot
barplot(gdp, col = rainbow(15), xlab = "국가", ylab= "단위(달러)", names.arg=nation)

str(gdp_ranking15)
# gdp가 Factor로 되어있는걸 숫자로 변경해야함
gdp <- as.numeric(str_replace_all(gdp, ",", ""))
gdp

barplot(gdp/1000, col = rainbow(15), xlab = "국가", ylab= "단위(1000달러)", 
        names.arg=nation,main="2017년도 GDP세계 15위 국가")

###################### 웹문서(html) 읽어오기 (한 페이지 자체를 읽어오기)
# "XML", "httr" 패키지 설치
install.packages("httr")
install.packages("XML")
library(httr)
library(XML)

url <- "https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"

get_url <- GET(url)
get_url
# content : 웹페이지의 테이블을 감싸고 있는 단위?
html_content <- readHTMLTable(rawToChar(get_url$content), stringAsFactors=F)  
# stringAsFactors=F, 문자열은 그대로 문자열로 읽어 올수 있게, Factor로 바꾸지 말고
str(html_content)
class(html_content) #list
df <- as.data.frame(html_content)
head(df)
names(df) <- c('State', 2010, 2011, 2012, 2013, 2014, 2015)
head(df)

######################### 데이터 출력
# 화면 출력 : cat(), print()
x <- 10
y <- 20
z <- x + y

cat("x + y의 결과는", z, "입니다.\n")
print("x + y의 결과는", z, "입니다.\n")
# print는 문자와 숫자를 연결하여 출력할 수 없다! cat은 가능
print(z)
print(x+y)

(q <- x*y)  # 괄호로 묶어주면 결과값도 함께 출력됨

# 파일 출력(저장)
getwd()
setwd('C:/chung/rwork/FirstProject/output')

data()
data(iris)
head(iris)

# 모든 작업을 파일로 저장: sink()
sink("iris.txt")
head(iris)
str(iris)
# 끝
sink()

head(iris)

# write.table
studentex <- read.xlsx(file.choose(), sheetIndex = 1, encoding = 'UTF-8')
studentex

write.table(studentex, "stdt.txt")

# 행 인덱스 빼기
write.table(studentex, "stdt2.txt", row.names = F)

# " 빼기
write.table(studentex, "stdt3.txt", row.names = F, quote = F)

library("xlsx")
write.xlsx(studentex, "stdt4.xlsx")

write.csv(studentex, "stdt5.csv", row.names = F, quote = F)

# .RData (R전용으로 저장하면 실행이 빠름..R안에서)
# save(), load()
save(studentex, file="stdt6.rda") # 2진 file

# 삭제
rm(studentex)
studentex

# 파일 로드
load("stdt6.rda")
studentex



















