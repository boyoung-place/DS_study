cmd에서 - cd(chage directory) cd..(상위파일로 이동) cd\(제일 상위파일로 이동) dir(폴더안의 파일/폴더들 확인) </br>
Anaconda 설치, JDK설치, notepad++설치</br>

### Path 설정: 어느 위치에서든 내가 원하는 'a'프로그램을 실행시키기 위해 경로를 설정해주는 것.</br>
 컴퓨터속성-시스템-고급시스템설정-환경변수-새로만들기/편집-확인</br>
 e.g) Python과 Jupyter notebook을 cmd창에서 한번에 실행시키기 위해 Path설정을 해준다</br>
      새로만들기-CONDA_HOME-파일이 있는 주소입력 / 이 주소는 이제 %CONDA_HOME% 으로 표현가능</br>
      
### Jupyter notebook 파일 저장위치 설정방법: 시작-모든프로그램-Anaconda3-Jupyter notebook 마우스오른쪽버튼-속성-바로가기-대상&시작위치 조정</br>
 -> cmd창에서 jupyter notebook --generate-config -> C드라이브-사용자-특정폴더-.jupyter-jupyter_notebook_config.py 생성된 것 확인 가능.</br>
 ->이 파일을 노트패드로 연결-261번째 줄 보면 notebook app을 열 때 dir를 지정하는 문구가 보일 것임, 거기에서 수정해준다!</br>
 
### 파이썬 건드려보기: 메모장으로 test.py 파일 생성-cmd에서 test.py 위치로 ㄱㄱ-python test.py 로 실행-결과확인
