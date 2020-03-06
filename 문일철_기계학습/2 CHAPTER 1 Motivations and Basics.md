# CHAPTER 1 Motivations and Basics

참고한 블로그 : [https://blog.naver.com/ehdrndd/221451081077](https://blog.naver.com/ehdrndd/221451081077)

- 1.1. Motivations
    - ML은 많은 키워드가 혼재하고 있는 분야 : 데이터 마이닝, 머신러닝, AI, ...
        1. 데이터의 풍부함 : 데이터의 종류:  문자, SNS, 이미지, 시계열
        2. ML적용사례 : 스팸필터, 주가예측, 자동차 번호인식, SNS추천기능,....
        3. 이젠 단순 스팸 필터링이 아닌, 메일의 중요도(Importance) 등의 추가 기능 존재
        4. 주가예측 또한 ML응용으로 적용될 수 있다.  (Data → ML Tech → Prediction)

    - ML의 종류
        - Supervised Learning : 지도학습.
        어떠한 기계학습 알고리즘에 데이터 집합을 제공할 때, 이 데이터에 정답이 있는 상태
        Supervision이 들어간다.
        클래스 라벨이 정해져 있는 데이터 인스턴스(example)들로 학습을 하는 기법
            - 스팸필터링, 자동등급매기기, 자동 범주화 와 같은 케이스
            - 분류, 회귀:
                - 분류 : Hit or Miss(A or not) / Ranking / Types(긍정부정)
                - 회귀 : Value prediction(가치 예측)
        - Unsupervised Learning : 비지도학습, 데이터에 정답이 없는 상태,  군집 등의 작업에 이용된다.
            - 군집화, latent facor, 패턴 찾기 등의 케이스
            - 군집화, 필터링:
                - text data에서 대표 단어 찾기 / 여러 얼굴 이미지에서 latent image 찾기 ...
        - Reinforcement Learning : 강화학습, 주어진 상태에 대해 최적의 행동을 선택하는 학습 방법. 훈련 데이터 대신, 주어진 상태에 맞춘 행동의 결과에 대한 보상을 주어 성능을 향상시킨다.

- 1.2. MLE : Maximum Likelihood Estimator (최대가능도추정)
    - 압정을 던져서 윗면/아랫면이 확률을 알아보자 ← 왜 그 확률인지 설명할 수 있어야 한다!
    - Binoimial Bistribution : 이산확률분포
        1. yes/no 로, 서로의 사건이 독립적이다. 
        2. i.i.d (독립동일분포)  : 독립적 사건, 이산확률분포에 따라 동일하게 분배됨
        3. P(H) = θ,  P(T) = 1 - θ

            ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled.png)

    - 압정을 5번 던졌을 때, 앞면이 3번 나올 확률을 최대로 하는 θ를 구하는게 MLE의 방식이다.

        ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%201.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%201.png)

    - 위의 식에 로그를 취해 caculation을 해보면, θ = aH/aT+aH 일때 MLE의 관점에서 BEST가 됨을 알 수 있다! (극점을 활용한 최적화)

        ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%202.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%202.png)

    - additional trails 을 통해 예측의 에러를 줄일 수 있다.

         아래 이미지의 N = trial numbers, N을 늘릴수록 에러 줄어듦!

    따라서 아마도 해당 확률 내에서는 correct한게 세타햇일 것이다 라고 말할 수 있음... (PAC)

    ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%203.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%203.png)

- 1.3. MAP : Maximum A Posteriori (최대사후확률)
    - 베이즈가 말하길, 압정의 앞면과 아랫면의 확률이 각각 0.5임을 알고 있다면?
    - P(θ) = 사전지식의 부분이 된다...?
    - θ를 알아내는 공식 = 어떠한 θ가 사실일 확률을 구하는 공식

    ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%204.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%204.png)

    - θ가 베타 분포를 따른다고 했을 때, 결국 P(D|θ) 와 유사한 형태가 됨

    ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%205.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%205.png)

    - 최적화를 하는 과정을 MLE와 동일하나, 관점이 다르다.
    - 아주 많은 실험을 해보면, 알파와 베타에 대한 사전정보값이 fade away되면서  MLE와 MAP의 결과값이 동일해질 것이다. (관측값이 많지 않을때, 사전정보값은 매우 중요한 정보가 됨)
- 1.4. Probability and Distribution (확률과분포)
    - Probability

        ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%206.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%206.png)

        ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%207.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%207.png)

    - Conditional Probability (조건부확률)
        - 전체인 Ω를 다루기 힘드니, Scope(Condition)을 넣어서 이용한다.

            이미지의 Scope에서의 E2 파트의 확률

            ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%208.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%208.png)

            ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%209.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%209.png)

            조건부확률

            ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%2010.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%2010.png)

            조건부 확률로 이런 공식을 유도할 수 있다.

            ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%2011.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%2011.png)

    - Probability Distribution

        ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%2012.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%2012.png)

        x ← Event  ,  
        f(x) = Event가 발생할 확률

        - 어떤 포인트(point)가 발생할 확률을 함수그래프로  확인해보기

            ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%2013.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%2013.png)

            확률밀도함수                                                        누적분포함수 :  모든 이벤트 발생 확률 sum → 1

    - Normal Distribution
        
        - long tail을 가지고 있다. (0이 아니게, 무한대까지가는 긴 꼬리존재)
    - Beta Distribution
        - long tail 없고 범위가 정해짐 (0~1)
    - 확률 모델링에 이 분포를 사용함
    
    ![2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%2014.png](2%20CHAPTER%201%20Motivations%20and%20Basics/Untitled%2014.png)
    
    - Binomial Distribution
        - 이 분포의 그래프는 선이 아니라 점점으로 되어있음. ← discrete 이기 때문
        - 0 or 1과 같은 discrete
    - Multinomial Distribution
        - 이산확률분포의 일반화, 선택지가 여러개인 경우 이 분포가 필요!
        - 텍스트 마이닝할 때 많이 사용됨