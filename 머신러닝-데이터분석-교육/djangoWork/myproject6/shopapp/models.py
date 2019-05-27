from django.db import models

# Create your models here.
class Customer(models.Model):
    idx = models.AutoField(primary_key=True)
    id = models.TextField(null=False)
    pwd = models.CharField(null=False, max_length=50)