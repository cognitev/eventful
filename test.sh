#!/bin/bash
set -x

MIX_ENV=test

mix ecto.drop
mix ecto.create
mix deps.get
mix ecto.migrate
mix test

exit $?