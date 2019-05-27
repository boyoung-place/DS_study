from django.db import models

# Create your models here.
class Survey(models.Model):
    survey_idx = models.AutoField(primary_key=True)
    question = models.TextField(null=False)
    ans1 = models.TextField(null=False)
    ans2 = models.TextField(null=False)
    ans3 = models.TextField(null=False)
    ans4 = models.TextField(null=False)
    # y:진행중, n:종료
    status = models.CharField(max_length=1, default='y')

class Answer(models.Model):
    answer_idx = models.AutoField(primary_key=True)
    survey_idx = models.IntegerField()   # FK?
    num = models.IntegerField()

# python manage.py makemigrations
# python manage.py migrate


