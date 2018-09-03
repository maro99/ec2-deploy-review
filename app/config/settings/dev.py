from .base import *

secrets = json.loads(open(os.path.join(SECRET_DIR,'dev.json')).read())

DEBUG = True

# Static, Media
STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(ROOT_DIR, '.static')
MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(ROOT_DIR, '.media')


# wsgi
WSGI_APPLICATION = 'config.wsgi.dev.application'

# DB
DATABASES = secrets['DATABASES']
