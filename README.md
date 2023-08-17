# Dockerized Django API with Django-Ninja-Auth

This project was originally intended to showcase [django-ninja-auth](https://github.com/mugartec/django-ninja-auth), but it ended up being a bit more than that. In summary, it is:

- A [Django](https://www.djangoproject.com/)-based web API;
- built with [django-ninja](https://django-ninja.rest-framework.com/);
- using [django-ninja-auth](https://github.com/mugartec/django-ninja-auth) for authentication;
- that you can run with [Docker Compose V2](https://docs.docker.com/compose/cli-command/);
- where you can **log in**, **log out**, **change your password** and **recover your password**.

You can find a [Vue-3](https://v3.vuejs.org/)-based front-end application designed to interact with this API [here](https://github.com/mugartec/django-ninja-auth-app-frontend). Both projects are presented together [here](https://github.com/mugartec/django-ninja-auth-app).

## Dependencies
The only dependency to run this project is [Docker Compose V2](https://docs.docker.com/compose/cli-command/). To make things even easier, there is a `Makefile`.


## Run
This project has [django-ninja-auth](https://github.com/mugartec/django-ninja-auth) as a submodule, so make sure to clone with `--recurse-submodules`. If you already cloned the repo, just run `git submodule update --init`.

You should be able to run the project by simply executing `docker compose up`, or `make dev`.


## Interacting with the API
You can directly interact with the API in [localhost:8000/api/docs](http://localhost:8000/api/docs). To do so, you'll first need to add a user to the database. This can be done by running
```
docker compose exec backend manage.py createsuperuser
```
or, using [taskipy](https://github.com/illBeRoy/taskipy)
```
task manage createsuperuser
```
You won't be able to call all endpoints in this interface, because there is no CSRF-token management (see more about this [here](https://github.com/mugartec/django-ninja-auth#csrf)). Use the [front-end example app](https://github.com/mugartec/django-ninja-auth-app-frontend) for this.

## Password recovery

Since the app is configured to use `django.core.mail.backends.console.EmailBackend` as email backend, when calling `/api/auth/request_password_reset/` the logs will display the email message with the link to recover the password.

The [template] (./src/templates/registration/password_reset_email.html) of this email uses the `frontend_url` variable, more information about this [here](https://github.com/mugartec/django-ninja-auth).
