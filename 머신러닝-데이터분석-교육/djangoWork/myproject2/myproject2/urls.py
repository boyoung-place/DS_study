"""myproject2 URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from django.urls.conf import include
from gtapp import views
from gtapp.views import CallView
urlpatterns = [
    path('admin/', admin.site.urls),    # 처음접속

    # myapp 접속 경로
    path('', include('myapp.urls')),    # 각 앱마다 url만들면 연결처리하게끔 지시해놓는 것(경로위임). 메인 urls.py에 path를 다 걸어놓으면 지저분해지니까 나눠놓는 것임
    # gtapp 접속 경로
    path('gtapp/', views.mainFunc),   # include쓰지 않고 처리    # FBV (함수기반뷰)
    path('gtapp/callget', CallView.as_view()),   # 클래스 호출   # CBV (클래스기반뷰)
    path('gtapp/', include('gtapp.urls')),
    # session 접속 경로
    path('sessionapp/', include('sessionapp.urls')),

    #dbapp 접속 경로
    path('dbapp/', include('dbapp.urls'))
]

# http://127.0.0.1:8000/
# http://127.0.0.1:8000/gtapp
# http://127.0.0.1:8000/sessionapp
