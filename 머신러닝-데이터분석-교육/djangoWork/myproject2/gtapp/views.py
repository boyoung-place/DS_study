from django.shortcuts import render
from django.views.generic.base import TemplateView

# Create your views here.
def mainFunc(request):
    return render(request, 'index.html')

class CallView(TemplateView):
    template_name = "callget.html"

def insertFunc(request):
    # print("요청방식 :" + request.method)
    if request.method == "GET":
        return render(request, "insert.html")
    else:
        irum= request.POST.get("name")
        return render(request, "list.html", {"name": irum})








