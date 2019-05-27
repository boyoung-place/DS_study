from django.urls import path
from sessionapp import views

urlpatterns=[
    path('', views.main),
    path('setos', views.setos),
    path('showos', views.showos)
]