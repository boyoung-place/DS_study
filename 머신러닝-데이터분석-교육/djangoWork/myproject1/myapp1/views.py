from django.shortcuts import render
from django.http.response import HttpResponse

# Create your views here.
def index(request):
    msg = """
        <html>
        <body>
            <h1>welcome to my site</h1>
            <p style="color:blue">오늘도 좋은 하루~~~</p>
        </body>
        </html>
    """
    return HttpResponse(msg)