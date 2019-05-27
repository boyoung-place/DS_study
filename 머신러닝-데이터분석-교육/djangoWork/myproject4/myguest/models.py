from django.db import models

# Create your models here.
class Guest(models.Model):
    title = models.CharField(max_length=50)
    content = models.TextField()
    regdate = models.DateTimeField()


# python manage.py makemigrations
# python manage.py migrate