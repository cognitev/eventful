#!/bin/sh

set -x

if [ "$1" = "eventful" ];
then

    echo "==================="
    echo "Running Eventful"
    echo "==================="
    echo
    /usr/local/bin/envconsul -consul consul.mcagrid.com -token $CONSUL_TOKEN -prefix $DEPLOY_ENV/ mix deps.get --only prod
    /usr/local/bin/envconsul -consul consul.mcagrid.com -token $CONSUL_TOKEN -prefix $DEPLOY_ENV/ mix ecto.migrate
    /usr/local/bin/envconsul -consul consul.mcagrid.com -token $CONSUL_TOKEN -prefix $DEPLOY_ENV/ mix phx.server

fi