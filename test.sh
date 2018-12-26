#!/bin/bash
set -x

MIX_ENV=test
<<<<<<< HEAD
=======
DB_NAME=eventful_test
>>>>>>> 2c20431b5ae48766f05cfacc18c9b9016b400d73

mix deps.get
mix ecto.drop
mix ecto.create
mix ecto.migrate
mix test

exit $?