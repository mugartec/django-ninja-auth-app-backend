# from django.conf import settings
from django.urls import path
from conf.api import api


urlpatterns = [
    path('api/', api.urls),
]
