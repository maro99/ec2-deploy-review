from .base import *


ALLOWED_HOSTS = [
    'localhost',
    '127.0.1.1',
    '.amazonaws.com',
    '.amazonaws'
]

# Static, Media
STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(ROOT_DIR, '.static')
MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(ROOT_DIR, '.media')


# wsgi
WSGI_APPLICATION = 'config.wsgi.local.application'

# Database
# https://docs.djangoproject.com/en/2.1/ref/settings/#databases
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}
