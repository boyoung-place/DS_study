# 윈도우창 실행을 exe파일로 해보기
GUI구현, 윈도우창 실행을 wxPython으로 진행하였음. </br>
이를 이용한 윈도우창을 보기위해선 Python이 깔려있어야함 </br>
이를 Python을 사용하지 않는 사용자를 위해서 exe파일로 변경할 것임.</br>
도스창에서 pip install pyinstaller 실행</br>
파일 실행할 위치에서 도스창 열어줌</br>
pyinstaller -F : 실행파일을 하나의 파일로 압축시켜줌</br>
뒤에 --noconsole 붙여줌 : 이게 없으면 실행시에 도스창도 같이 뜸</br>
뒤에 -n aaa.exe "실행파일" 붙여줌  (-n aaa.exe는 선택적: 파일명을 지정? 할 수 있는 옵션임)</br>
뒤에 --hidden-import [추가해줄모듈이름] : 여기에선 wx임  -> 엔터</br>
실행 위치에 dis폴더생기구 그 안에 exe파일 만들어져있음</br>
신기하다!
