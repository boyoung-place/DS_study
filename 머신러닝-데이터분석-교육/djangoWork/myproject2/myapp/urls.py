from django.urls import path
from myapp import views

urlpatterns = [
    path('', views.index),
    path('hello', views.hello),
    path('hello_tem', views.hello_template),
    path('img', views.hello_image)
]

# http://127.0.0.1:8000/
# http://127.0.0.1:8000/hello
# http://127.0.0.1:8000/hello_tem
# http://127.0.0.1:8000/img