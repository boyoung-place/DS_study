# 7주차 : CHAPTER 6 Training Testing and Regularization

날짜: Mar 07, 2020
진행자: 정보영

# **CH6. Training Testing and Regularization**

## **Intro**

머신러닝 알고리즘, 모델 등의 성능 점검을 위해서는 Training 과 Testing을 이해해야 한다.

- 목표!
    - bias와 variance의 컨셉 이해
    - bias and variance trade-off 이해
    - regularization(제약)의 컨셉이해

## **Bias and Variance 컨셉**

이제까지 배웠던 나이브 베이브, 로지스틱 회귀, 서포트벡터머신 등과 같은 classification의 기능이 잘 되는지 확인이 필요하다! 이제는 이 모델의 능률과 정확도에 주의를 기울여야..!

## **6.1. Over-fitting and Under-fitting**

- accuracy의 타당성

    항상 False로 prediction하는 분류 모델이 있다면? : 데이터셋이 100개 중 1개만 True인 경우, accuracy가 99%가 됨

    => 여러 measure를 사용한다 (Precision/Recall, F-Measure)

- dataset의 타당성
    - 어디에서 모은 것인지
    - 여러 variance가 있는지 등등

### **Training and Testing**

- Training
    - 파라미터 추정을 위해 사용
    - 사전 정보 등 -> Prior setting
    - 앞으로 들어올 데이터에서도 잘 작동한다는 보장이 없음
- Testing
    - 앞으로 들어올 데이터가 training에서의 데이터와 같은 양상이라는 믿음을 가지고 데이터셋을 Training과 Testing용으로 나눈다.

### **Over-Fitting and Under-Fitting**

![7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled.png](7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled.png)

- ML알고리즘 트레이닝을 위해 N개의 포인트들이 주어짐
- 위의 3가지의 선은 N개의 포인트들로 모델fitting을 한 것

### **Tuning Model Complexity**

- 트레이닝 function의 차수를 무조건 높인다고 좋은게 아니다.
- 모델의 복잡도를 적정선으로 잡을 수 있는 방법? trade-off !
- 이 trade-off관계를 어떻게 정의하고 잴 수 있는지? <- 핵심 포인트!!

## **6.2. Bias and Variance**

### **Understand Error in ML**

ML성능 측정을 위해서는 에러에 대한 이해 필요

- Eout <= Ein + Ω
    - Ein = approximation에서의 에러
    - Ω = 앞으로 돌어오는 data의 variance로 인한 에러
    - 이 2가지 에러의 합 이하가 최종에러, Eout (estimation error)
- more symbols 정의
    - f : the target function to learn ( True function, 배우려고(목표) 하는 func)
    - g : ML 모델 (배워나가는 중인 func, 내가 만든다)
    - g^(D) : 주어진 data로 학습된, parameter inference까지 된 func
    - D : available 한 dataset
    - g^-(hat) : 주어진 무한대의 D의 평균가정
- Eout의 이해를 위한 수식 도출

    : learning한 모델func과 True func의 차이에서 발생한 에러의 기대값...

![7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%201.png](7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%201.png)

### **Bias and Variance Dilemma**

![7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%202.png](7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%202.png)

- 2개의 term으로 나눌 수 있음
    - Variance : specialized된 dataset(가지고있는 데이터셋) 과 앞으로 올 다양한 generalized dataset(알고있다고 가정) -> 에러 발생..
    - Bias : Approximation의 한계에서 발생

## **6.3. Occam's Razor**

### **Empirical Bias and Variance Trade-off**

Bias and Variance trade-off 를 empirical하게 이해해보자!

- True function을 억지로 가정 (sin함수를 True func으로 가정)
- 주어진 2개 가설로, 무한대의 평균가설을 내보면 아래의 그래프와 같다.
- 가지고 있는 데이터셋의 한계로, 샘플링에 한계가 있음

![7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%203.png](7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%203.png)

- Bias and Variance 참고이미지 ( 원문: [How would you explain the bias-variance tradeoff to a five year old?](https://www.quora.com/How-would-you-explain-the-bias-variance-tradeoff-to-a-five-year-old))

![7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%204.png](7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%204.png)

- 참고이미지2 : bias and variance trade-off ( 출처: [https://ai-pool.com/a/s/bias-variance-tradeoff-in-machine-learning](https://ai-pool.com/a/s/bias-variance-tradeoff-in-machine-learning))

    ![https://files.ai-pool.com/a/eba93f5a75070f0fbb9d86bec8a009e9.png](https://files.ai-pool.com/a/eba93f5a75070f0fbb9d86bec8a009e9.png)

### **Occam's Razor**

- 정의 : 여러개의 경쟁가설 중에서는 가장 simple한 Hypothesis가 better!
- 에러가 유사하다고 하면 가장 simple한 가설이 BEST
- 오캄의 면도날 : 불필요하게 복잡한 것을 제시해서는 안된다 (plurality should not be posited without necessity)

## **6.4. Cross Validation**

- 현실에서는 Bias, Variance의 계산이 불가능 -> 미래에 오는 데이터에 대한 반응이 어떨지 시뮬레이션해보자
- 무한대로 샘플링 못하니까 흉내라도 내자 : 100번,, 1,000번,,,, 10,000번,,
- 이렇게 imitation해서 앞으로 올 데이터에 대한 시뮬레이션하는 방법 = N-fold cross validation
    - 실제론 1번 샘플링이지만 여러번(N-1) 샘플링했다고 흉내내는 것...
    - 주어진(가지고 있는) dataset을 N개로 자른다.
    - (N-1)의 subsets으로 트레이닝을 한다.
    - 남은 1 subset으로 테스트한다.
    - 예시 이미지(출처:[https://blog.quantinsti.com/cross-validation-machine-learning-trading-models/](https://blog.quantinsti.com/cross-validation-machine-learning-trading-models/))

        ![https://d1rwhvwstyk9gu.cloudfront.net/2019/01/Cross-Validation-In-Machine-Learning-2-1024x691.jpg](https://d1rwhvwstyk9gu.cloudfront.net/2019/01/Cross-Validation-In-Machine-Learning-2-1024x691.jpg)

- 스페셜 케이스 , LOOCV(leave one out cross validation)

    : 딱 한 instance남겨두고 모조리 training

## **6.5. Performance Metrics**

- 현실에선 타겟 함수 알 수 없음! 평균가설도 알 수 없음!
- 따라서, bias 와 variance도 계산할 수 없음! -> 성능 평가 measure로 사용불가

### **Precision and Recall**

- 그래서! bias와 variance 대신 아래의 measures를 사용한다.
    - Accuracy = (TP+FN) / (TP+FP+FN+TN)
    - Precision(정밀도) = TP / (TP+FP)
    - Recall(재현률) = TP / (TP+FN)

![7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%205.png](7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%205.png)

- 두가지 케이스에서의 measure이용법을 알아보자
    - 스팸필터 : 보수적으로 분류 (진짜 스팸인 것만 스팸으로 분류해야함)
        - False Positive(FP)를 줄이는 것이 우선순위
        - Precision이 높을수록 좋다 (위 표의 연두박스)
        - Recall이 높은 것도 좋지만 Precision을 갉아먹으면 안됨, Precision이 100%가 되어야함
    - CRM(VIP고객유치어쩌구..) : 비보수적으로 분류(VIP를 하나라도 놓치면 안됨..!)
        - False Negative(FN)을 줄이는 것이 우선순위
        - Recall이 100%가 되어야함 (위 표의 보라박스)

### **F-Measure**

- precision과 recall을 합쳐서 생각하는 방법
- F-measure가 precision이나 recall보다 많이 사용됨

![7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%206.png](7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%206.png)

- 위의 식은 차이없이, 동일한 레벨에서 Precision과 Recall, 2개의 measure가 합쳐진 것
- b의 값을 조정하여 recall을 강조하거나, precision을 강조할 수 있다(b의 숫자가 클수록 recall 강조)

## **6.6. Definition of Regularization**

- 있는 모델을 그대로 쓰면서 성능은 조금 높여보는 방법? Regularization
- Perfect fit을 포기한다 = 완벽한 최적화는 포기한다 = 트레이닝 accuracy를 희생시킨다
- 앞으로 올 test상황에서의 fit이 더 좋지않을까 하는 생각 (트레이닝에서의 완벽한 정확도 대신에 테스트에서 정확성을 높이겠다)
- over-fitting을 피하기 위해서 -> complex한 모델은 그대로 쓰되, 모델을 조금 둔감하게 만들자
- 모델이 데이터셋에 의해 민감하게 반응하지 않도록하자 -> Regularization이 모델의 또다른 하나의 constraint가 됨

### **regression에서의 regularization**

- another constraint
- Penalty를 어떻게 주느냐에 따라 Reg term의 모양이 결정되고, regularization의 종류가 결정된다.
- 릿지 정규화 / 라쏘 정규화

    ![7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%207.png](7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%207.png)

- (그래프 이미지 출처 : [https://datascienceschool.net/view-notebook/83d5e4fff7d64cb2aecfd7e42e1ece5e/](https://datascienceschool.net/view-notebook/83d5e4fff7d64cb2aecfd7e42e1ece5e/))

![7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%208.png](7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%208.png)

- Ridge 모형은 가중치 계수를 한꺼번에 축소시키는데 반해 Lasso 모형은 일부 가중치 계수가 먼저 0으로 수렴하는 특성이 있다.

 (이미지 출차:[https://ratsgo.github.io/machine%20learning/2017/05/22/RLR/](https://ratsgo.github.io/machine%20learning/2017/05/22/RLR/))

![7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%209.png](7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%209.png)

### **linear regression에서의 regularization**

- w를 잘 선택해서 전체값을 optimize하려고 한닷 -> w에 대해서 편미분 진행

![7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%2010.png](7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%2010.png)

### **정규화의 영향**

![7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%2011.png](7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%2011.png)

- λ를 조정하여 Regularization을 최적화한다.
- 적절한 λ값은? 여러번의 실험을 거쳐 최적화하는 과정이 필요하다.

### **logistic regression에서의 regularization**

- 기존 공식에 reg term 추가

![7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%2012.png](7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%2012.png)

### **Regularization and SVM**

- SVM에서는 C가 regularization과 유사한 역할을 하는 constant이다
- C에 따른 DB의 변화
- soft margined를 감안했을 때, 이미 Regularization이 들어간 것!

![7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%2013.png](7%20CHAPTER%206%20Training%20Testing%20and%20Regularization/Untitled%2013.png)