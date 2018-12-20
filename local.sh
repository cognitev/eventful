#!/bin/bash
set -x
cd assets
npm install
node node_modules/brunch/bin/brunch build --production
cd ..

mix deps.get
mix ecto.create
mix ecto.migrate
mix phx.digest
mix phx.server