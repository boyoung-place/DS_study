from django.shortcuts import render
from bookmark.models import Bookmark


# Create your views here.
def home(request):
    urlCount = Bookmark.objects.all().count()
    urlList = Bookmark.objects.order_by("title")
    return render(request, 'home.html', {'urlCount': urlCount, 'urlList': urlList})

def detail(request):
    # addr = request.GET["url"]
    # name = request.GET["title"]
    # return render(request, 'memodetail.html', {"addr": addr, "name": name})

    addr = request.GET["url"]

    # select * from bookmark_bookmark where url = 'http://www.naver.com'
    dto = Bookmark.objects.get(url=addr)    # 타이틀과 url 모두 들어있음
    # print(dto.title, ',', dto.url)
    return render(request, 'memodetail.html', {'dto': dto})

