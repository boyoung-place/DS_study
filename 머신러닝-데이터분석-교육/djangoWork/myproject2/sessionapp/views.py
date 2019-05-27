from django.shortcuts import render
from django.http.response import HttpResponseRedirect

# Create your views here.
def main(request):
    return render(request, "main.html")

def setos(request):
    if "favorite_os" in request.GET:
        os = request.GET.get("favorite_os")
        request.session['f_os'] = os
        return HttpResponseRedirect("showos")   # 사용자로부터 다시 요청이 오게끔 서버는 사용자의 요청에 응답... = redirect (서버에서 방향을 틂) urls..
    else:
        return render(request, "setos.html")

def showos(request):
    # os = {}    # 딕트보내기..?
    # os["favor"] = request.GET.get("favorite_os")    # request.GET["favorite_os"]
    # os["stars"] = "4"
    if "f_os" in request.session:
        request.session.set_expiry(3)    # 3초(만료기간)
        return render(request, "showos.html", {"os": request.session["f_os"]})
    else:
        return render(request, "showos.html", {"os" : "선택한 os가 없습니다."})
