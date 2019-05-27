from django.shortcuts import render
from django.http.response import HttpResponse

# Create your views here.
def index(request):
    return HttpResponse("여기는 메인페이지 입니다.")

def hello(request):
    msg = "장고 만세"
    ss = "<html><body>장고 프로젝트로 구현%s</body></html>"%(msg)
    return HttpResponse(ss)

def hello_template(request):
    name = "홍길동"
    age = 20
    return render(request, 'hello.html', {'name':name, 'age':age})

def hello_image(request):
    return render(request, 'my.html')