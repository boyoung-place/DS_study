## QUI 구현
GUI를 구현하는 데에는 여러 라이브러리가 있으나, 이 수업에서는 wxPython을 이용하여 구현함.<br/>
해당 라이브러리를 import하여 코드작업을 통해 윈도우 창을 구현할 수 있다.<br/>
- GUI: Graphical User Interface)의 약자이며, 사용자가 그래픽을 통해 컴퓨터와 정보를 교환하는 작업 환경을 뜻함.<br/>
- 라이브러리 준비<br/>
  : 1) 직접 다운로드 -> site-packages에 복사  2) pip install 모듈명  3) pycharm에서 직접 세팅(File-setting-project interpreter-추가)
  <br/>
- GUI 구현 기본<br/>
'''<br/>
import wx <br/>
(Meaning)어플리케이션 생성<br/>
app = wx.App()<br/>
(Meaning)프레임 생성<br/>
frame = wx.Frame(None, title="첫번째 윈도우)<br/>
(Meaning)화면 나타내기<br/>
frame.Show(True)<br/>
(Meaning)어플리케이션 실행<br/>
app.MainLoop()<br/>
'''<br/>
결과= 첫번째 윈도우라고 타이틀이 걸린 프레임이 생성된다. (Grey Box, 아직 텍스트입력은 불가)<br/>

-개념참고: https://m.blog.naver.com/PostView.nhn?blogId=nonamed0000&logNo=220879681052&proxyReferer=https%3A%2F%2Fwww.google.com%2F
