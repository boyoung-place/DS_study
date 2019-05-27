from django.shortcuts import render
from shopapp.models import Customer
from django.views.decorators.csrf import csrf_exempt

# Create your views here.
def login(request):
    return render(request, 'login.html')

@csrf_exempt
def insert(request):
    # dto = Customer.objects.all()
    id = request.POST["id"]
    pwd = request.POST["pwd"]
    
    return(request, 'main.html')

    # if id == "scott" and pwd == "1111":
    #     request.session["id"] = id;
    #     return redirect("/")
    #
    # else:
    #     return redirect("login")