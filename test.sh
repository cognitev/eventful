#!/bin/bash
set -x

MIX_ENV=test
DB_NAME=eventful_test

mix deps.get
mix ecto.drop
mix ecto.create
mix ecto.migrate
mix test

exit $?