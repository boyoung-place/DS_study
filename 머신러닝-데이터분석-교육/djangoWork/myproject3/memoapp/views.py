from django.shortcuts import render, redirect
from memoapp.models import Memo
from django.views.decorators.csrf import csrf_exempt    #settings.py 의 django.middleware.csrf.CsrfViewMiddleware

# Create your views here.
def home(request):
    memoList = Memo.objects.order_by("-idx")    # 앞에 -표시를 해주면 내림차순이 됨!
    memoCount = Memo.objects.all().count    # Memo 모든걸 다 가져오기
    return render(request, 'list.html', {'memoList' : memoList, 'memoCount' : memoCount})

@csrf_exempt    # 함수decoration기능
def insert(request):
    writer = request.POST["writer"]    # 사용자가 보내는 이름과 메모의 값 불러와서 테이블에 저장
    memo = request.POST["memo"]
    # print(writer, ',', memo)

    # table에 data 저장
    Memo(writer=writer, memo=memo).save()    # save()를 쓰면 db에 전달되어 저장된다

    # list 페이지로 복귀
    # return render(request,'list.html')    # 원래 이렇게 하면 안된다고? why? home함수를 호출해야함, 호출안하면 data값이 전달된게 보이지 않음
    return redirect("/memolist")    # 루트써줘야.. (/)

def detail(request):
    idx = request.GET["idx"]
    dto = Memo.objects.get(idx=idx)    # Data Transfer Object
    # dto = Memo.objects.raw("""
    #       select * from memoapp_memo
    #       where idx=%s""", idx)
    print(dto.writer)

    return render(request, 'memodetail.html', {'dto': dto})

def delete(request):
    idx = request.GET["idx"]
    Memo.objects.get(idx=idx).delete()    # 번호 조회해서 delete
    return redirect("/memolist")

@csrf_exempt
def update(request):
    # update 테이블명 set writer=writer, memo=memo where idx=idx
    writer = request.POST["writer"]
    memo = request.POST["memo"]
    idx = request.POST["idx"]
    # print(writer, ',', memo, ',', idx)
    Memo(idx=idx, writer=writer, memo=memo).save()
    return redirect("/memolist")