# 2019.03.12 (화) 스터디 내용정리 + 03.20(수) 스터디 준비(추가분)
## SHAP
 - SHapley Additive exPlanations
 1. SH: 각 피쳐의 importance를 marginal하게 계산한 값, 각 피쳐의 조합에서 특정 피텨가 기여하는 정도(값)을 조합의 개수로 나누어 평균낸 값.
 2. SHAP: 각 피쳐별로 SH에 대한 값을 벡터로 나타내는 데 y값에 어떠한 영향을 미치는지, 방향성과 강도를 나타내는 데에 사용함.
 3. Shapley value: 특정 결과에 각 공헌자가 얼마나 공헌했는지를 나타내는 수치 (게임이론에 나오는 개념)
 4. data -> Model -> Prediction (Weak explanation) / data(or Model)->SHAP->explanation
 5. 참고 사이트 : https://github.com/slundberg/shap  also, https://towardsdatascience.com/interpreting-your-deep-learning-model-by-shap-e69be2b47893
 

 - SHAP의 배경에 관하여
  : 각 방법은 설명력이 약하거나 예측력이 약하거나 둘 중 하나가 더 약할 수 밖에 없다. (설명력과 예측력은 trade-off 관계에 있음.)
    BUT, catboost? 와 같이 높은 예측력을 가지는 동시에 설명력 또한 가지고 있는 모델들이 늘어나고 있다.
    (대표적인 예로, LIME이나 Shapley Value가 있음) \n
  스터디 목표 : SHAP를 통해 모델 features가 target variable에 어떻게 영향을 미치는지
  
## Hyperopt
- 기존 random search와 베이지안 optimization의 특헝을 혼합하여 만든 하이퍼파라미터 최적화 방법론.
- log-normal, normal, uniform(random) 등 다양한 분포가정을 통해 파라미터 값을 조정할 수 있음 + 좀 더 알아보야아함  NEXT WEEK...


-Hyperopt 관련:
https://medium.com/district-data-labs/parameter-tuning-with-hyperopt-faa86acdfdce
http://sanghyukchun.github.io/99/ (cb님이 알려준 참고사이트: 설명 이해하기 쉽게 잘 되어있음!)


## Feature Interaction 관련
 https://christophm.github.io/interpretable-ml-book/interaction.html
