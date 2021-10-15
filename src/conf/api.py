from ninja import NinjaAPI
from django_ninja_auth.ninja_auth.api import router as auth_router

api = NinjaAPI(csrf=True)
api.add_router('/auth/', auth_router)
