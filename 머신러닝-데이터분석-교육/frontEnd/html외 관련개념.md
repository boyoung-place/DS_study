#### html, javascript, django

- 핵심 개념 정리

  1) Hyperlink기능 2가지

  ​    - 답: (1) 이동(다른 페이지로 연결) / (2) 프로그램 실행

  2) URL: 프로토콜명://도메인주소(아이피주소):( )/파일명( )  <-괄호 안에 들어가야할게 무엇인지

  ​    - 답: 포트번호/파일면#세부위치 (부가설명: 포트번호가 있어야 실제 프로그램 접근까지 가능하다.)

  3) table 중에서 열 합치기, 행 합치기 속성은?

  ​    - 답: colspan, rowspan

  4) css의 목적

  ​    - 답: (1) 디자인(html 등)의 효과적인 관리 / (2) 웹 표준화(cross browsing)

     참고: css란, cascading style sheet(우선순위가 있는 스타일 시트) 의 약자로 html의 디자인을 유지관리보수한다.

  5) css 사용방법 3가지 서술

  ​    - 답: (1) external style: 별도의 css파일을 만들어서 호출하여 사용하는 방법

  ​            (2) Internal style: 

  ​               하나의 페이지에 단 한번만 정의함으로써 같은 페이지 내에서는 동일한 디자인을 재사용할 수 있다.

          <style> 사용(속성으로 사용하는 것과 다르다)
  ​                 selector {속성명:값; 속성명:값; ...}

  ​            

  ​             (3) Inline style

  ​                 태그 안에서 직접 사용하는 방식(즉흥적, 일회성), 재사용의 의미 없음

  ​                 태그 안에 style이라는 속성으로 사용

  

   6) css selector 형식 (중요 4가지)

  ​       - 답:  

  ​            *reference: (1)~(10)의 선택자 개념 설명은 https://aboooks.tistory.com/249 을 참고하였음

  ​             (1)유형 선택자(type selector) : 요소 이름

  ​                 e.g) p {color:red}   <- p요소가 있는 곳은 모두 빨간색 글씨로 지정

  ​             (2)전체 선택자(universal selector): 문서에서 모든 요소에 적용. * 기호를 사용한다

  ​                  e.g) *{margin: 0px; padding:0px;} <-모든 요소에 margin 0px, padding 0px를 지정

  ​              (3)ID 선택자(id selector): 구체적 id를 지닌 한 요소

  ​                   e.g) #header{text-align: center;} <- header라는 id(고유이름)을 지닌 곳에 가운데로 정렬

  ​              (4)클래스 선택자(class selector): 많은 요소에 스타일을 한꺼번에 지정하고자 할 때 class로 지정된 요소

  ​                   e,g) .popup{font-size: 11px;} <- popup이란 이름을 지닌 곳에는 모두 글꼴 크기를 11px로

  ​               (5)**자식 선택자(child selector)** : 요소가 어떤 요소의 자식일 때 적용. 자식 선택자는 **기호 '>'로 분리**하며, 둘 이상의 선택자로 구성 됨.

  ​                   e.g) body>p{line-height: 1.3} <-body의 직계 자식인 모든 p요소에 적용(직계 이후에 오는 자손은 포함하지 않음)

  ​               (6)**자손 선택자(descendant selector)** 또는 문맥 선택자(contextual selector): 요소 내부에 있는 자손 요소들에 적용. **공백(space)**으로 분리

  ​                   자식과 자손의 차이는?  자식: 부모 안에 있는 자식 요소에만 영향을 미침  / 자손: 부모 안에 있는 모든 자손에 영향을 미침(자식, 손자 등)

  ​                   e.g.)

  ​                          예1: ul li a{text-decoration: none;}  <-???

  ​                          예2: div ol>li p  <- 자손 선택자와 자식 선택자를 조합한 것. div자손인 ol이어야하며, li는 이 ol의 자식이어야하며, p는 li의 자손

  ​                  (7)**인접 형제 선택자(Adjacent sibling selector)**

  ​                       구문: E1 **+** E2 (E2는 선택자의 대상임) E1과 E2가 문서 구조에서 같은부모를 가지고, E1바로 뒤에 E2가 와야함

  ​                       e.g.) h1+h2{text-indent:5px;} / h1.opener+h2{margin-top:-5mm}

  ​                   (8)속성 선택자(attrivute selector): <https://aboooks.tistory.com/249> 의 속성 선택자 설명참고

  ​                   (9)의사클래스 선택자 :https://aboooks.tistory.com/249> 의 의사 클래스 선택자 설명참고

  ​                   (10)의사 요소 선택자: https://aboooks.tistory.com/249> 의 의사 요소 선택자 설명참고

  ​                   (11)**General Sibling Selector** : 일반 형제 선택자는 특정요소의 형제인 모든 요소를 선택한다.

  ​                          e.g.) div ~ p {background-color: yellow;} <- <div>요소의 형제인 모든 <p>요소를 선택한다. <https://www.w3schools.com/css/tryit.asp?filename=trycss_sel_element_tilde> 참고

  

   7) Javascript에서 DOM객체 3가지 설명 : node, document, element

     - 그 전에, DOM이란? 

       문서(대부분 Markup Language)를 객체로 표현하기 위한 표준, 자바스크립트, 자바, C, C++, C# 등 다양한 언어에서 DOM API를 지원

        (1) Node : DOM에서 표현되는 모든 것

       ![1555581853070](C:\Users\acorn\AppData\Roaming\Typora\typora-user-images\1555581853070.png)

  ​              (2) document : 문서 전체를 나타내는 인터페이스. node인터페이스를 상속받는다.

     ![1555581936041](C:\Users\acorn\AppData\Roaming\Typora\typora-user-images\1555581936041.png)

  

  ​               (3) element: 태그를 나타내는 인터페이스

  ​                     tagName

  ​                     getAttribute()

  ​                     setAttrubute()

  ​                     removeAttribute()

  

   8) mtv 패턴에 대해 서술

  ​     일반적으로 말하는 MVC패턴에 대해 장고는 용어 표현을 달리하고 있다. 장고는 MTV(Model Template View: 보통은 MVC) 구조에 의해 프로젝트를 처리하고 있다. 즉, Model은 DB처리를, Templates가 출력에 관련된 역할(출력파일을 별도관리)을 하고, View는 컨트롤러 역할(요청과 처리를 제어)을 하게 된다. 이러한 구조 내에서 전체 파일들 사이의 관계를 settings.py를 통해서 진행한다. (이미지 출처:<https://sonej.tistory.com/53> )

  ![1555582418657](C:\Users\acorn\AppData\Roaming\Typora\typora-user-images\1555582418657.png)

- 실습해보기

  1) 테이블만들기  레이아웃나눠서..( 불규칙한 테이블 만들기)

  2) css 문제:  

  ```html
  <h1 class="BLUE">글자색을 파랑색으로</h1>
  ```

  3)  DOM문제,, javascript

  ```html
      <body><div>a 입니다.</div>
  
      <span id="b"> b입니다. </span> </body>
  ```

  4) http://127.0.0.1:8000/myapp 했을때 안녕하세요라는 문자열 출력(html 안만들고)

  5) 4)의 문제를 html을 만들어서 출력