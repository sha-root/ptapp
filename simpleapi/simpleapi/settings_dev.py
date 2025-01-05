import os
from .settings import *

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.environ.get('SECRET_KEY')

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = os.environ.get('DEBUG', True)

ALLOWED_HOSTS = ['*']

# Database
# https://docs.djangoproject.com/en/5.1/ref/settings/#databases

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": os.environ.get['POSTGRES_DB'],
        "USER": os.environ.get['POSTGRES_USER'],
        "PASSWORD": os.environ.get['POSTGRES_PASSWORD'],
        "HOST": os.environ.get['POSTGRES_HOST', '127.0.0.1'],
        "PORT": os.environ.get['POSTGRES_PORT', '5432'],
    }
}
