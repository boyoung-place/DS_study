from django.shortcuts import render
from dbapp.models import Article

# Create your views here.
def show(request):
    return render(request, 'articlelist.html', {'articles' : Article.objects.all()})