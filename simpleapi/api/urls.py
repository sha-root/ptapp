from django.urls import path
from .views import current_time

urlpatterns = [
    path('current-time/', current_time, name='current_time'),
]
