# WEEK 3 - Linked List, Stack, and Queue

## 1. Array for List

### (1) Scenario for List

e.g) mass public에서 Koh씨 찾기

​	-> mass public을 line-up 해야한다. (선형적 공간)

​		-> line-up 후 구조화된 형태로 저장한게 List 임.

### (2) Abstract Data Types

​	: data structure의 abstraction(추상화)

​		-> data structure: data store(insert&delete) and search

​			다양한 행동들을 추상화

​			구체적 operation을 모르겠고, 어떤 data가 저장되어있고 어떤 operation이 있다는 정도를 보여준다.

​			order를 저장. 특정 order cancel 가능

​			error condition도 미리 알아놓고 대응(?)을 깔아둠(?) <-강의 다시

### (3) Creating a List by Array

​	python에서의 array 역할 = List !

​	array  : 동일한 data를 인덱스를 활용하여 저장/access 할 수 있다. (나중에 찾아볼 수 있음)

​				각 elements는 index로 접근 가능

​	파이썬의 index는 0부터 시작한다는 것 잊지말기

### (4) array에서 search하기

​	저장된 array에서 찾는 것

​	e.g) 'd' in x ---> True / False (boolean값 출력)

​			len(x) : list의 길이 알 수 있음  

​				for loop으로 search g할 때, 

​				search하는 값이 없는 경우,  len(x) 만큼 (retrievals)돈다. always!

​				serach 하는 값이 있는 경우, len(x) within으로 돌면서 찾을 수 있다.				

### (5) Insert 하기

​	e.g) x = ['a','b','d','e','f']

​	c가 없다 -> c를 list(x)에 넣자(b와 d사이에) -> how? 

​	x = ['a', 'b', 'd', 'e', 'f']

​	step 1) list를 새로 만든다. (cell6개가 있는 list y)

​	step 2) x[0:a-1] -> y[0:a-1] 로 reference copy (retrieval cnt.: a)

​			삽입값의 예정위치 이전까지는 모두 동일  cf) reference란?  x[0] -> 'a'  와 같은 구조

​	step 3) c 를 y[a] 에 넣는다 (retrieval cnt.:1)  (저장하려는 위치에 넣는다.)

​	step 4) x[a:] -> y[a+1:]  copy (retrieval cnt.: n-a-1) (나머지부분 작업)

​	step 5) x의 reference를 y의 reference로 변경한다.

​	Total count of retrievals = a + 1 + n - a - 1 = n

```python
x = ['a','b','d','e','f']
idxInsert = 2
valInsert = 'c'

y= list(range(6))

# step 2 x[0:a-1] -> y[0:a-1] reference copy
for itr in range(0, idxInsert):
    y[itr] = x[itr]

# step 3 저장하려는 위치에 넣는다
y[idxInsert] = valInsert

# step 4
for itr in range(idxInsert, len(x)):
    y[itr+1] = x[itr]
    
# step 5  바꿔치기
x = y
```





### (6) Delete 하기

​	list 안에 있는 'd'를 제거하기 (a = delete position index)

​	step 1) 5개의 cell이 있는 list y 를 새로 만든다. (1개 줄어든 길이)

​	step 2) x[0:a-1] 의 reference links를 y[0:a-1]로 copy (retrieval cnt.:a)

​	step 3) x[a+1:] 의 reference links를 y[a:] 로 copy (retrieval cnt.: n-a-1)

​       	즉, from x[4] = 'e' to y[3] = 'e' 와 같이 된다는 말 ('d'를 삭제하는 것이므로)

​	step 4) x의 reference를 y의 reference로 변경

​	Total count of retrievals = a + n - a - 1 = n - 1 (만큼의 operation을 수행하였다.)

```python
# delete example
idxDelete = 3

# step 1
y = list(range(5))

# step 2
for itr in range(0, idxDelete):
    y[itr] = x[itr]

# step 3
for itr in range(idxDelete+1, len(x)):
    y[itr-1] = x[itr]

# step 4
x = y
```



### (7) Problems in Array

​	: line-wise retrievals

​		하나라도 넣거나 빼려면 n개의 retrievals가 필요하다.

​		예시) airline passengers 

​			승객 1명을 middle of the line에 넣으려고 한다. -> space를 만들고자 passenger들이 step back해야하는 상황

​			1명이 들어갈 공간을 딱 만들어주는 방법은 없을까? 

​			-> 해결방법:  Linked list ! (data handling 가능)

​				   	 -> Linked list는 단순 array방식 이외의 방법들을 활용해야지만 가능하다. (더 이상 1차원적인 index에 저장 x)



## 2. Linked List

### (1) Detour : Assignment and Equivalence

​	x = [1,2,3]

​	y = [100, x, 120] <- 여기서의 x는 [1,2,3] 이 아니라 [1,2,3]이 있는 곳을 가리키는 reference를 저장한 것을 의미

​	if, x가 바뀐다면? 

​		x[1] = 1717 -> x = [1,1717,3]  -> y에도 고쳐진 값이 적용된다.

​		(참고) == : 값이 동일 ,  is : (저장)위치 동일

​		x = [1,2,3]    x2 = [1,2,3]   둘의 값은 동일, BUT 같은 위치에 저장되어 있지는 않다.

​		이런 reference의 구조를 알아야 Linked List를 이용할 수 있다!

### (2) Basic Structure: Singly linked list

​	singly linked list는 node 와 reference로 구성된다.

​	- node의 variable2개 ->

1. variable : next node를 가리키고 있다. (reference 구조)

											2. variable : value object (value를 저장하고 있는 reference를 저장)



​	- special nodes : Head(list의 맨 처음 node) and Tail(Next node가 없음)



### (3) Implementation of Node class : 노드는 어떻게 만드나?

​	1 to 1의 association relationship (하나의 노드는 하나의 next node만을 가질 수 있다)

​	![](C:\Users\wjdqh\OneDrive\Desktop\문일철_파이썬_linear_강의필기\nodeclass.png)



```python
class Node:
    nodeNext = None
    nodePrev = ''
    objValue = ''
    binHead = False
    binTail = False
    def __init__(self, objValue='', nodeNext=None, binHead=False, binTail=False):
        self.nodeNext = nodeNext
        self.objValue = objValue
        self.binHead = binHead
        self.binTail = binTail
    def getValue(self):
        return self.objValue
    def setValue(self,objValue):
        self.objValue = objValue
    def getNext(self):
        return self.nodeNext
    def setNext(self, nodeNext):
        self.nodeNext = nodeNext
    def isHead(self):
        return self.binHead
    def isTail(self):
        return self.binTail
    
node1 = Node(objValue='a')
nodeTail = Node(binTail = True)
nodeHead = Node(binHead = True, nodeNext = node1)
```



### (4) Head and Tail

​	: special node 이다!  위치가 항상 정해져 있음

​	ex) Empty linked list

​			Head(obj+Next)  -> Tail(obj+Next)     이게 끝임!

​	

###  (5) Search procedure in singly linked list

​	예시) 'd' 와 'c' 찾기   list = ['a', 'b', 'd', 'e', 'f']

​	head -> 'a' -> 'b' -> 'd' -> 'e' -> 'f' -> Tail

​	pattern이 바뀌는건 없고, index는 더이상 사용불가

​		step1) head를 찾는다.

​		step2) next node 찾기

​			

```python
if nextnode == tail
	break
if nextnode != tail
	next.object == 'd'
	# next.next를 반복(찾는 값이 나올때까지 next의 next를 call한다)
    # maximum n 번
```



### (6) Insert procedure in singly linked list

​	step1) Node-new의 넣고 싶은 위치 정하기

​	Node-prev -----------> Node-next    이 사이에 Insert할 것임

​	

​	step2) prev와 next가 이어져있는 reference를 끊는다. (update this reference)

​	step3) Node-prev의 Next가 Node-new를 가리키도록 코드를 짠다. (add this reference)

​				Node-prev.next = Node-new

​				Node-new.next = 비어있음 (<- Node-next를 넣어준다)

### (7) Delete procedure in singly linked list

​	'd'를 delete 하자.

​	head -> 'a' -> 'b' -> 'c'(Node-prev) -> 'd'(Node-remove) -> 'e'(Node-next) -> 'f' -> tail

​	step1) 이어져있는 reference를 끊는다! 

​	<'d' delete 전의 상태>

​	Node-remove = Node-prev.Next  

​	Node-next = Node-prev.Next.Next

​	step2) Node-prev.Next를 Node-next로 update한다. (overwrite - new reference만들기) 

​				: 'd'를 가리키는 node가 없어서 d가 삭제된 것과 같은 효과이다. 

​		  		(메모리 상에서는 안 없어짐, BUT 파이썬에 garbage collector란게 있어서 궁극적으로는 없어진다.)



### (8)  Implementation of singly linked list

```python
class SinglyLinkedList:
    nodeHead=''
    nodeTail=''
    size = 0
    def __init__(self):
        self.nodeTail = Node(binTail = True)
        self.nodeHead = Node(binHead=True, nodeNext=self.nodeTail)
        
    def insertAt(self, objInsert, idxInsert):
        nodeNew = Node(objValue = objInsert)
        nodePrev = self.get(idxInsert - 1)
        nodeNext = nodePrev.getNext()
        nodePrev.setNext(nodeNew)
        nodeNew.setNext(nodeNext)
        self.size = self.size + 1
        
    def removeAt(self, idxRemove):
        nodePrev = self.get(idxRemove - 1)
        nodeRemove = nodePrev.getNext()
        nodeNext = nodeRemove.getNext()
        nodePrev.setNext(nodeNext)
        self.size = self.size - 1
        return nodeRemove.getValue()
    
    def get(self, idxRetrieve):
        nodeReturn = self.nodeHead
        for itr in range(idxRetrieve + 1):
            nodeReturn = nodeReturn.getNext()
        return nodeReturn
    
    def printStatus(self):
        nodeCurrent = self.nodeHead
        while nodeCurrent.getNext().isTail() == False:
            nodeCurrent = nodeCurren.getNext()
            print(nodeCurrent.getValue(), end=" ")
        print("")
        
    def getSize(self):
        return self.size
```

이렇게 class를 생성하고,  예시 풀이에 이 class안의 함수들을 이용하여 아래와 같이 나타낼 수 있다

```python
list1 = SinglyLinkedList()
list1.insertAt('a', 0)
list1.insertAt('b', 1)
list1.insertAt('d', 2)
list1.insertAt('e', 3)
list1.insertAt('f', 4)
list1.printStatus()

list1.insertAt('c', 2)
list1.printStatus()

list1.removeAt(3)
list1.printStatus()

print("----------output---------------")
'''
a b d e f
a b c d e f
a b c e f
'''
```

Singly linked list는 위와 같은 식으로 실행된다.



## 3. Stack and Queue

### (1) Stack 의 구조

​	  Stack: 데이터를 넣고 뺄 수 있는 위치가 하나로 고정 되어있는 데이터 구조

​	  그래서, 데이터가 어떻게 쓰일지 미리 알고 시나리오를 짠다. (LIFO 같은..)

	  - 선형구조.
	  - Singly linked list의 변형구조이다.
	  - 중간에 Insert하는 Insert기능 안된다. 오로지 1번째 node만 관리한다. (Top only accessible)
	  -  list의 1번째 instance이다 = stack의 Top
	  -  LIFO mechanism (후입선출, Last In First Out)



### (2) Operation of Stack

​	list 에서는 search / insert / delete 기능

​	stack은  search x (only Top만) = push (항상 linked list의 첫번째에  instance 삽입)

​				  delete x (only Top만) = pop (상동)

​	

### (3) Implementation of Stack

​	pop : 항상 Top을 remove    /    push : 항상 Top을 insert

```python
from src.edu.kaist.seslab.ie362.week3.SinglyLinkedList import SinglyLinkedList

class Stack(object):
    1stInstance = SinglyLinkedList()
    def pop(self):
        return self.1stInstance.removeAt(0)
    def push(self, value):
        self.1stInstance.insertAt(value,0)
        
stack = Stack()
stack.push('a')
stack. push('b')
stack.push('c')

print(stack.pop())  ----> c
print(stack.pop())  ----> b
print(stack.pop())  ----> a
```

### (4) Example: Balancing Symbols

- Balancing symbols?
  - [2+(1+2)] - 3  --> 심볼 발란스 굳
  - [2+(1+2] -3  --> 심볼 발란스 낫 굳
- 심볼 발란스 확인을 위한 알고리즘
  - 빈 stack 만든다
  - 심볼을 읽는다 (formula의 끝까지)
  - formula의 끝에서 stack이 비지 않았으면 error report

  (괄호 쓰는 법을 말하는건가..?)



### (5) Queue 시나리오

​	예) airport에 사람들이 줄서있음, 중간에 낄 수 없다!  -> 선입선출 구조 (FIFO)



### (6) Queue 의 구조

	- Singly linked list의 변형구조이다.
	- middle 접근 불가
	- list의 첫번째 instance는 나갈 수 있고(front), 

​       list의 마지막 instance는 들어올 수 있는(rear) 구조



### (7) Operation of Queue

​	: list의 insert / remove 활용

	- Enqueue : last위치에 element insert
	- Dequeue :  첫번째 element remove



### (8) Implementation of Queue

​	Enqueue 문제: index가 계속 변함

​	-> list size에 따라 index가 달라진다 -> size를 알아내서 index

```python
from src.edu.kaist.seslab.ie362.week3.SinglyLinkedList import SinglyLinkedList

class Queue(object):
    1stInstance = SinglyLinkedList()
    def dequeue(self):
        return self.1stInstance.removeAt(0)
    def enqueue(self, value):
        self.1stInstance.insertAt(value, self.1stInstance.getSize())
        
queue = Queue()
queue.enqueue('a')
queue.enqueue('b')
queue.enqueu('c')

print(queue.dequeue())  --> a
print(queue.dequeue())  -> b
print(queue.dequeue())  -> c
```

