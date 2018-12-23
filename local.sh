#!/bin/bash

set -x

MIX_ENV=dev

mix ecto.create
mix ecto.migrate
mix deps.get
mix phx.server