dev:
	docker compose up

build:
	docker compose build

test:
	docker compose exec backend pytest -v --cov-report term-missing --cov-fail-under=100 --cov=.

lint:
	docker compose exec backend ruff check /src/

lint-fix:
	docker compose exec backend ruff check /src/ --fix

manage:
	docker compose exec backend python manage.py $(command)

logs:
	docker compose logs --follow backend

setup:
	cd src && poetry install && poetry shell

migrate:
	docker compose exec backend python manage.py migrate

migrations:
	docker compose exec backend python manage.py makemigrations

app-migrations:
	docker compose exec backend python manage.py makemigrations $(app)

shell:
	docker compose exec backend python manage.py shell_plus

bash:
	docker compose exec backend bash

reset_db:
	docker compose exec backend python manage.py reset_db
