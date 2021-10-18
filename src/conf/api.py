from ninja import NinjaAPI
from django_ninja_auth.ninja_auth.api import router as auth_router
from django.views.decorators.csrf import ensure_csrf_cookie
from django.http import HttpResponse


class ShortNameNinjaAPI(NinjaAPI):
    def get_openapi_operation_id(self, operation):
        return operation.view_func.__name__


api = ShortNameNinjaAPI(csrf=True)
api.add_router('/auth/', auth_router)


@api.get('/csrf', tags=['Csrf'])
@ensure_csrf_cookie
def set_csrf_cookie(request):
    return HttpResponse()
