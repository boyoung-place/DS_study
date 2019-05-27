from django.shortcuts import render
from myguest.models import Guest

# Create your views here.
def mainFunc(request):
    return render(request, 'main.html')

def listFunc(request):
    gdata = Guest.objects.all()
    # print("test:", gdata)
    return render(request, 'list.html', {'gdatas': gdata})