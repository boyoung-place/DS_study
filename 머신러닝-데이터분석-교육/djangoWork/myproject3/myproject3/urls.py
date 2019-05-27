"""myproject3 URL Configuration

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
from django.conf import settings
from django.conf.urls import url, include
from bookmark import views

urlpatterns = [
    path('admin/', admin.site.urls),

    # url(r'^$', view.home)   # r : raw 데이터 형식
    path('', views.home),      # 위의 url주석과 결과 동일함
    path('detail', views.detail),    # detail이라는 요청이 들어왔을 때 views.detail로 연결

    # memoapp 경로설정
    path('memolist/', include('memoapp.urls')),

    # surveyapp 경로설정
    path('survey/', include('surveyapp.urls')),
]

if settings.DEBUG:
    import debug_toolbar
    urlpatterns += [
        url(r'^__debug__/', include(debug_toolbar.urls)),

    ]