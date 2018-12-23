#!/bin/bash

set -x


mix ecto.create
mix ecto.migrate
mix deps.get
mix phx.server