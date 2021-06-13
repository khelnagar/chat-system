#!/bin/sh
set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:setup

exec bundle exec "$@"