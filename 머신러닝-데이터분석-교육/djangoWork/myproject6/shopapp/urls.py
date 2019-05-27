from django.urls import path
from shoppingapp import views

urlpatterns = [
    path('loginsert', views.insert),

]
