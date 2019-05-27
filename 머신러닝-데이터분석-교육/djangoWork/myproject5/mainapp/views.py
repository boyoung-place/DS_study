from django.shortcuts import render, redirect
from django.views.decorators.csrf import csrf_exempt

# Create your views here.
def main(request):
    try:
        if request.session["id"]:
            return render(request, "main.html")
    except Exception as e:
        return render(request, 'login.html')

@csrf_exempt
def login(request):
    if request.method == "GET":
        return render(request, 'login.html')
    elif request.method == "POST":
        id = request.POST["id"]
        pw = request.POST["pw"]

        if id == 'scott' and pw == '1111':
            request.session["id"] = id
            return render(request, 'main.html', {"id":id})
        else:
            return render(request, 'login.html')


def logout(request):
    try:
        del request.session["id"]
        return render(request, "login.html")
    except:
        return render(request, "login.html")