#!/bin/sh

# Bail run on process fail
set -o errexit
set -o nounset

# Handle sigterm gracefully
term_handler() {
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143;
}

trap term_handler TERM

# This should be taken care of by the deployment tools for production
if [ "$DEBUG" = "true" ]
then
  export PYTHONBREAKPOINT=ipdb.set_trace
  poetry install
  python manage.py migrate
  # python manage.py compilemessages

  # I'd like to run gunicorn here, but I couldn't make reload to work
  until uvicorn conf.asgi:application --reload --port 8000 --host 0.0.0.0; do
    echo "Development server crashed... restarting" >&2
    sleep 3;
  done

  elif [ "${TESTING}" = "True" ]; then
    export DEBUG=True
    pytest -v --cov=.

  else
    python manage.py migrate
    # python manage.py compilemessages
    gunicorn conf.asgi:application -c /devops/gunicorn.conf.py
fi
