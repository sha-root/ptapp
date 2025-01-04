from django.http import JsonResponse
from datetime import datetime

def current_time(request):
    """API-endpoint which returns current time"""
    data = {
        "message": "Hello, this is your current time!",
        "current_time": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
    }
    return JsonResponse(data)
