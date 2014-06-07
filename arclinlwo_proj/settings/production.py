from .base import *

DEBUG = False
TEMPLATE_DEBUG = DEBUG

# Hosts/domain names that are valid for this site; required if DEBUG is False
# See https://docs.djangoproject.com/en/1.5/ref/settings/#allowed-hosts
ALLOWED_HOSTS = ['*']

# Make this unique, and don't share it with anybody.
SECRET_KEY = os.environ['DJANGO_SECRET_KEY']

# 3rd-party apps tracking IDs.
INTERCOM_APP_ID = 'a6d0326564469dfd7f7d9b1bfc909ee3815a85a8'
GOOGLE_ANALYTICS_TRACKING_ID = 'UA-45698014-1'

EMAIL_HOST = os.environ['EMAIL_HOST']
EMAIL_HOST_USER = os.environ['EMAIL_HOST_USER']
EMAIL_HOST_PASSWORD = os.environ['EMAIL_HOST_PASSWORD']
EMAIL_PORT = 587
EMAIL_USE_TLS = True

# The 'From:' header of admin-related emails.
DEFAULT_FROM_EMAIL = 'info@glucosetracker.net'

ADMINS = (
    ('Local Admin', 'admin@glucosetracker.net'),
)

MANAGERS = ADMINS

CONTACTS = {
    'support_email': 'support@glucosetracker.net',
    'admin_email': 'admin@glucosetracker.net',
    'info_email': 'info@glucosetracker.net',
}

# For 'subscribers' app
SEND_SUBSCRIBERS_EMAIL_CONFIRMATION = True

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'glucosetracker',
        'USER': os.environ['DATABASE_USER'],
        'PASSWORD': os.environ['DATABASE_PASSWORD'],
        'HOST': 'localhost',
        'PORT': '',
    }
}