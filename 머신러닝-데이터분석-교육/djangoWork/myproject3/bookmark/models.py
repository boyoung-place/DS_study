from django.db import models

# Create your models here.
class Bookmark(models.Model):
    title = models.CharField(max_length=100, blank=True, null=True)
    url = models.URLField('url', unique=True)

    def __str__(self):
        return self.title    # 오버라이딩    # 이후에 python manage.py makemigrations 로 테이블 재정비(바뀐 내용 추가함)