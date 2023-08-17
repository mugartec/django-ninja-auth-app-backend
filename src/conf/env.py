from typing import List

from pydantic import BaseSettings


class EnvSettings(BaseSettings):
    # Specify directly. We don't want to leak anything
    django_secret_key: str
    allowed_hosts: List[str]
    csrf_trusted_origins: List[str]
    debug: bool = False
    frontend_url: str = 'localhost:3000'

    # Database settings
    database_url: str

env = EnvSettings()
