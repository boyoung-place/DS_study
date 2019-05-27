from django.contrib import admin
from surveyapp.models import Survey, Answer

# Register your models here.
class SurveyAdmin(admin.ModelAdmin):
    list_display = ("question", "ans1", "ans2", "ans4", "status")

admin.site.register(Survey, SurveyAdmin)
admin.site.register(Answer)