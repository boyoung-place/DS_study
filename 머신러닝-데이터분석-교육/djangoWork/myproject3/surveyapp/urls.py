from django.urls import path
from surveyapp import views

urlpatterns = [
    path('', views.home),
    path('save_survey', views.save_survey),
    path('show_result', views.show_result)
]