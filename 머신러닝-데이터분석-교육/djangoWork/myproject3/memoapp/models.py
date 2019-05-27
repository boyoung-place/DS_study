from django.db import models
from datetime import datetime

# Create your models here.
class Memo(models.Model):
    idx = models.AutoField(primary_key=True)
    writer = models.CharField(null=False, max_length=50)
    memo = models.TextField(null=False)
    post_date = models.DateTimeField(default=datetime.now, blank=True)    # python에서는 날짜함수는 모듈을 import하여 사용해야 했다는 걸 기억하기

