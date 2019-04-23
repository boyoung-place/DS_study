### 파이썬 프로그래밍의 기초, 자료형
1. 배치프로그램(batch program): 명령어를 자동 실행되게끔 해주는 일종의 언어.
   반드시 확장자를 .bat 로 할 것 , 자주 사용하는 것들을 batch파일로 저장해두고 한번에 실행시킬 수 있음 (cmd에서 test.bat 실행)
2. 변수(variable)는 임시기억(저장)공간이다.
3. =은 대입, 치환,,,, 등의 의미를 가짐. (!같다라는 의미가 아님!)  e.g) a=1 1을 a에 대입한다... 참조? 라는 의미로도 볼 수 있음? (= 하나는 대입(주소가져오는?..)의 뜻이므로, 같다는 의미를 쓸 때에는 ==)
4. 자료형(data type) 즉, 자료=data 형=type
5. 참고: 함수 'IS' 는 a 와 b의 '주소' 가 같은지 확인하는 함수  e.g) a=10 / b=10 / print(a is b) -> TRUE
        함수'id'는 현재 데이터의 주소값을 확인해줌
6. Markup: HTML(hypertextmarkuplanguage)-웹페이지에서 디자인역할 / Markup: < >data< >   Markup(복잡,다량)문법을 좀 더 축약하고 간략화시킨 것이 Markdown

변수는 절대로 수정 불가
a = 10
b = 10

print(a is b)
b = 5
print(a is b)

a = b
print(id(a),id(b))

동시에 여러 변수에 하나의 객체를 할당
a = b = c = 10

여러 변수에 여러 개의 객체 할당
a,b,c = 10,11,12

# 자료형

## 종류

    1)기본 자료형
        - 정수형(int), 실수형(float), 복소수형, 문자형(str), 함수형
        
    2)집합(iterable) 자료형
        - 리스트, 듀플, 딕트, 세트(set)
        
## 수정 가능성에 따라

    1) 변경 가능 : list, dict, set
    
    2) 변경 불가능 : int, float, complex, bool, str, tuple
    
    
등등 자료형을 살펴봄.. (%d, %s, {}, .split, 와 같은 기본적인 함수? 들)
