#### Javascript - 개념정리

##### -내가 모르는 개념들 몇가지 정리하기

(1) 객체기반(based)언어와 객체지향(oriented)언어의 차이?

  객체지향언어의 구현 방법 중 하나가 객체기반이다.

   1) 객체지향언어: 함수기반언어(대표적인 예로, C언어가 있음)가 가지고 있던 부분(함수, 흐름제어문)을 그대로 가져오면서 객체(클래스)라는 개념을 추가한 언어이다. 

(더 자세한 내용은 <https://m.blog.naver.com/PostView.nhn?blogId=ghen4268&logNo=110184188778&proxyReferer=https%3A%2F%2Fwww.google.com%2F>  포스트 참조)

​    여기서의 oriented는 방향성이 아니다. 위주, 혹은 선호라고 하는 것이 더 어울림

- 객체지향 키워드 5

  클래스(추상), 오브젝트(실체), 캡슐화, 상속성, 다형성

​    2) 객체기반언어

  Javascript가 객체기반언어라고 배웠는데 아니라는 의견도 있고.. 그렇다..! 모르겠네

 아무튼 Javascript는 객체지향언어는 아니고 객체언어의 특성을 일부분 가지고 있다.



   *Java나 Python에서는 껍데기class를 생성하고 그것을 이용하여 객체를 생성한다. 하지만 Javascript에서는 var 

​    객체이 름 으로 선언하는 순간 객체가 생성된다. 

​    (참고: 객체지향 개념<https://www.slideshare.net/plusjune/ss-46109239>)

(2) DOM이란?

Document Object Model의 줄임말. 문서를 객체로 표현하기 위한 표준, 이 때의 문서는 Markup Language를 의미한다.

프로그램 및 스크립트가 문서의 내용,구조 및 스타일에 동적으로 엑세스하고 업데이트 할 수 있게 해주는 플랫폼 및 언어 중립적 인터스페이스. 문서를 추가로 처리하고 그 결과를 제시된 페이지로 되돌릴 수 있다.

- DOM API (Node < Document, Element)

  ...는 다음에 이어서...