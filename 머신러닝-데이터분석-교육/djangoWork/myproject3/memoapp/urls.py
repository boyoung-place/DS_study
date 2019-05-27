from django.urls import path
from memoapp import views

urlpatterns = [
    path('', views.home),
    path('memoinsert', views.insert),
    path('memodetail', views.detail),
    path('memodel', views.delete),
    path('memoupdate', views.update)
]