# 데이터 구조 및 분석 week2
​	https://www.edwith.org/datastructure-2019s(강의 및 교재 링크)

## Object-oriented paradigm and Software design

#### 1강

Object Oriented Concept

Design & Programming

	- lobby1 과 lobby2 : 역할은 동일하고, Design은 비슷하나 Interior는 다르게 할 수 있다.

Good Software Design
 - 설계 목적에 맞게, error없이

 - 유연성(미래의 수정사항?을 유연하게 받아들일 수 있는.. 그런 유연성!)

 - 다양한 목적, 환경에 맞출 수 있음

    (Correctness / Robustness / Flexibility / Usability and Reusability / Efficiency)

 Object-Oriented Design
 - Abstract

   Real world concept들을 추상화시킴

   => 개념(concept)의 이름을 정한다 - 개념의 특성 - 개념이 할 수 있는 행동

Class와 Instance는 뭐나요??

​	Class:conceptualization(개념화)

​	Instance:realization(실현화의 기능)

### 2강
UML notation 1

 - 설계 표준 = UML (Unified Modeling Language, 통합 모델링 언어)
 - class를 그리는 방법
 - class는 어떤 template이고 이게 realize되면 instance가 될 수 있다.

 1) 클래스 설계
   Abstract class / class / Named instance / Unnamed instance

   Member variables = Attribute = property (속성들)

   Methods = member functions
     - 다양한 type 필요  +-#(name)(arguments):(type)

   기호로 표시해줌. (e.g. Visibility options : + public # protected - private)



### 3강
Encapsulation & Inheritance

Encapsulation (캡슐화)

: 실제 구현 내용 일부를 외부에 감추어 은닉한다

  - object = data + behavior
    -data : field, "member" variable, attribute
    -behavior: method, "member" function, operation
    -behavior를 이용해 객체를 생성!

  - visibility option : private(Only I can see)  data
      protected
      public (Many can see)  method
    - method를 이용하여 data를 관리하는 것!

    * 헷갈리는 부분: 학원에서는 __ 접근도 안된다고 배웠는데, 문일철교수님은 __ 굳이 찾겠다면 접근은 가능하나 적절치 않다고 하심.
      (학원에선 _이 접근은 가능하나 적절치 않음을 표현한다고 했음)

  - 파이썬은 기본적으로 비쥬얼 옵션은 지원하지 않는다. 이건 인테리어의 몫 

Inheritance

  1) Inheritance

  - attribute 상속
  - 자손은 새로운 attribute를 가질 수도 있다.
  - 상속받은 특성을 mask한 속성(새로운 attr는 아니다)

  2) Superclass
  - 조상 역할
  - generalized view... 상위에 있을수록 추상적이고 일반화됨

  3) Subclass
  - specialization

Inheritance in Python

  1) Multiple Inheritance

  2) Super? superclass호출..

​       :super() : 내가 inherit하고 있는 상위단계의 superclass를 호출

​      'self' and 'super'

  	 -self: instance itself (인스턴스 자기자신을 가리킴)
   	-super

### 4강

Polymorphism and Abstract Class

 : 다형성, 추상성 클래스

Polymorphism: signature 라고도...

Signature = Method name + parameter list

​    sub1) Method Overriding (재정의)

​        상속받고 있는... Base class가 A(num)을 가지고 있고, 상속받은 자식class가 A(num) Method를 가지고있음

​          => 부모클래스의 메서드는 무시하고, child의 메서드로 본다. 새로이 정의된 메서드를 사용

​    sub2) Method Overloading (중복정의)

​        메서드 이름은 같지만 파라미터가 달라서 여러가지 다른 형태로 실행될 수 있는 것.

​        A class는 A(num), A(num, name), A(num, name, home) 메소드를 가지고 있다



Abstract Class

​    abstract Method가 있는 클래스

​    Method with signature, but with no implementation <- 그럼 왜 필요? 뭔가 있어야한다고 정의할때 필요(should)

​    이것으로 인스턴스를 만들수는 없다



@abstractmethod  이 밑에 있는 건 abstractmethod에 포함되는 것이라고 표시

pass : 이 블락 끝났어! 아무것도 하지마~ 라는 뜻

완전히 구현되지 않은 클래스를 상속받으면 error 발생

Overriding Methods in object

​	class Room:  <- ()없다 = object를 그대로 받는다는 의미

​	BUT, 숨겨진 몇개의 method가 있음. (강의자료참고)

 1. __init__ 밑에 있는 함수는 __init__을 override해서 구현한다.

 2. 3. ```python
       __eq__ : 값 비교
       
       print(room1 == room2) 를 할때 __eq__ 함수가 호출되어서 이퀄리티를 체크함
       ```

       



DuckTyping

​	other? : other가 Room클래스의 instance인지 알 수 없지만 있겠거니 하고 막 프로그래밍한 것, 만약 아닌경우 실행 error가 발생한다.

### 5강

UML notation2

앞에 까지는 어떻게하면 class를 잘 설계할 수 있는지에 대해 배웠음!

​	use case diagram 등 4개의 다이어그램이 있음

UML class diagram

: Visibility options (encapsulation에 도움)

Structure of classes in class Diagram

: association을 활용하여 관계를 읽는다.

  공통적인 속성을 뽑아 abstract class를 만드는 것=generalization

  다이어그램에서..:

  	→: association

  	화살촉이 뚱뚱한것 : generalization

  	촉이 마름모꼴 : aggregation

  	Generalization

  		inheritance relationship (like, superclass and subclass)

  		is-a relationship

  		Hollow triangle shape

  		Base class 밑에 Leaf class들이 있다 (Q: superlass와 subclass관계와 동일한 의미인지?)

​        Superclass의 atttibute는 따로 선언되지 않아도 subclass안에 존재한다.

​    Association

​    	has-a relationship (어떤 클래스가 무엇을 가지고 있다라는 말)

​    	: 객체합성이라고 말할 수 있음

​    		multiplicity 정보 필요로 함, 얼마만큼 복수계를 가지고 있는지 



​    	Member variables

​    		e.g)한 customer가 여러 accounts를 가지고 있음

​    			한 customer는 하나의 account를 가지고 있음

​    	Simpleline : association 관계

​    		방향성 정의, 정의되지 않은건 양방향의 관계임

​          	 색인이 가능?

​    		simpleline에 관계에 대한 이름을 붙일 수 있다.

​    		Multiplicity 표현도 가능 (*: 하나가 many를 가지고 있다는 의미)



    * Q : s-a 와 has-a의 차이점

  

  Multiplicity of Association
    	

```python
*(아스테리스크)
    		: many라는 의미로 자주 사용됨
    		(1) 1..* : 1 to Many
    		(2) * : 0 to many (same with '0..*') 하나도 없거나 여러개 있을 수 있다
    		(3) 1 : 딱 하나 있음
    		(4) 0..1 : 없거나 하나있음
    		(5) 딱히 지정되어있지 않으면 1
            
```

​    Aggregation

​    	has-a relationship에 추가적인 관계가 있음, 'part-whole' or 'part-of' relationship

​    	아래 그림) Family는 여러개의 패밀리멤버를 가지고 있고, 반드시 1개는 있어야한다

​           Family의 lifetime은 FamilyMember의 영향을 받음(aggregate할게 하나도 없다 = Family 존재 x)
​        

​    Dependency (Use relationship)

​    	? 상속 받은 거 말하는건감 

​    Let's Practice

   

```python
 Customer는 주문을 한번도 안한 사람부터~ 여러번 한 사람까지 ( 0..*)
    하나의 Order는 하나의 Customer에게만 해당된다. ( 1 )
    OrderDetail이 하나도 없는 Order는 존재하지 않는다. (aggregate)
    Item은 여러개의 orderdatil을 가질 수 없다..? 그런데 왜 0..* 이져 선생님?
    OrderDetail은 Item에 단방향 arrow가지고 있다 = Item은 orderdetail정보 가지고 있지 않음
    payment에 관련된 order하나는 무조건 존재
```

​    주의사항 : 이걸 그리는 법을 알아야한다~~~~ 읽는 법도 당연히 알아야겠지만