from django.shortcuts import render


def index(request):
    # TEMPLATE설정에 app/templates 폴더 추가.
    # temptlates폴더에 'index.html'추가

    # STATICFILES_DIRS예 app/static 폴더 추가.
    # static/css폴더에 Bootstrap CSS파일 (css/bootstrap.css)추가.

    #index.html에서 (% static %}텤그를 ㅅ용해서
    # head 태그 내의 link css/bootstrap.css 불러오기.

    #이미지 불러오기도함.
    # static/images에 이미지 담아 놓음.
    return render(request, 'index.html')