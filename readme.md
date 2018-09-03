# Nginx - uWSGI - Django

**Web Server** <-> **WSGI** <-> **Web Application**

## Requirements

- Python (3.6)
- pipenv

### Secrets

#### `.secrets/base.json`

```json
{
"SECRET_KEY":"<Django scret key>"
}
```

### `.secrets/dev.json`

- PostgreSQL을 사용, DATABASES섹션의 설정이 필요

```json
```json
{
  "DATABASES": {
    "default": {
      "ENGINE": "django.db.backends.postgresql",
      "HOST": "<host>",
      "PORT": 5432,
      "USER": "<user>",
      "PASSWORD": "<password>",
      "NAME": "<db name>"
    }
  }
}
```
```






