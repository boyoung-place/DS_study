from django.shortcuts import render, redirect

# Create your views here.
def shop(request):
    try:
        if request.session["id"]:
            return render(request, 'shop.html')
    except:
        return redirect("/login")
