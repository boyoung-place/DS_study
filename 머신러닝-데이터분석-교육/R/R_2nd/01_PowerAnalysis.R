#(일반적으로 표본의 갯수 30개 정도로)
# Power Analysis (적정한 표본의 갯수 산출)
  # 실험군과 대조군의 차이가 난다는 것을 입증할 수 없는 상황
    # 표본의 갯수가 적어서
    # 표본의 갯수는 충분한데, 실제로 두 그룹간의 결과의 차이가 없는 것인지
    
  # Cohen의 d(effective size:유효한 갯수)공식
  ## 첫번째 집단과 2번째 집단의 갯수가 동일: |mean.1 - mean.2| / 루트((s.1제곱 + s.2제곱)/2)
  
#install.packages("pwr")
#install.packages('https://cran.rstudio.com/bin/windows/contrib/3.6/pwr_1.2-2.zip', repos=NULL, type="source")
library(pwr)
getwd()
KY <- read.csv(file="C:/chung/rwork/SecondProject/data/KY.csv", header = T, sep = ",")
KY
table(KY$group)

# effect size를 구해야? Power Analysis를 쓸 수 있다!?
# effective size 구하기
mean.1 <- mean(KY$score[KY$group==1])  # 14.5
mean.2 <- mean(KY$score[KY$group==2])  # 36.95

sd.1 <- sd(KY$score[KY$group==1])  # 18.70
sd.2 <- sd(KY$score[KY$group==2])  # 26.78

effectSize <- abs(mean.1-mean.2)/sqrt((sd.1^2 + sd.2^2)/2)  # 0.9719


?pwr.t.test
# power : 0.2, 0.5, 0.8
pwr.t.test(d=effectSize, sig.level = .05, type = "two.sample", alternative = "two.sided", power=.8)
# sig.level : 유의수준에 대한 오차범위, power는 베타오류에서 사용한다

# Two-sample t test power calculation 
# 
#               n = 17.63116    # Number of observations (per sample)
#               d = 0.9719389
#       sig.level = 0.05
#           power = 0.8
#     alternative = two.sided
# 
# NOTE: n is number in *each* group


# 전환율: 어느정도의 표본이 주어졌을 때 전환율이 의미가 있는지
# 웹사이트의 전환률(1000명당 15명) : 고치기 전과 후의 차이 알아보기
web_a <- 15
web_n_a <- 1000
(web_p_a <- web_a/web_n_a)  # 0.015

# 개선 전후의 효과크기를 탐지하는 데에 필요한 표본의 크기
?pwr.2p2n.test (이표본비율)
pwr.2p2n.test(h=.2, n1=1000, sig.level = .05, power = .8, alternative = "two.sided")  
# 일종의 대응표본 (n2=244.1239, 탐지하는 데에 필요한 표본의 크기?)




